//
//  CreateRecipeViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/22/25.
//

import UIKit
import CoreData

// TODO: Creating recipe and adding ingreideint using add food doesn't save history's ingredient properly
class CreateRecipeViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = Settings.shared.currentTheme.background.uiColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    enum Section: Int, CaseIterable {
        case name, ingredients
    }
        
    lazy var recipeEntry: FoodEntry = {
        var recipeEntry = FoodEntry(context: recipeContext)
        recipeEntry.quantity = 1
        recipeEntry.gramWeight = nil
        recipeEntry.amount = 1
        recipeEntry.modifier = "serving"
        recipeEntry.portionId = 0 // 0 means user generated
        recipeEntry.isCustom = true
        recipeEntry.isRecipe = true
        
        let foodInfo = FoodInfo(context: recipeContext)
        foodInfo.fdcId = Int64.random(in: Int64.min..<0)    // negative means user generated
        foodInfo.brandName_ = nil
        recipeEntry.foodInfo = foodInfo
        
        for nutrientId in NutrientId.allCases {
            let foodInfoNutrient = FoodInfoNutrient(context: recipeContext)
            foodInfoNutrient.nutrientId = nutrientId
            foodInfo.addToNutrients_(foodInfoNutrient)
        }
        
        recipeEntry.meal = meal
        
        return recipeEntry
    }()
    
    var recipeContext: NSManagedObjectContext = CoreDataStack.shared.childContext()
    let foodService = FoodService()
    
    lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Cancel", primaryAction: didTapCancelButton())
        return button
    }()
    
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Save", primaryAction: didTapSaveButton())
        button.isEnabled = false
        return button
    }()
    
    let meal: Meal
    let userProfile: UserProfile
    
    weak var addFoodDelegate: AddFoodDetailViewControllerDelegate?
    
    init(meal: Meal, userProfile: UserProfile) {
        self.meal = recipeContext.object(with: meal.objectID) as! Meal
        self.userProfile = userProfile
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Recipe"
        tableView.register(CreateFoodInfoTableViewCell.self, forCellReuseIdentifier: CreateFoodInfoTableViewCell.reuseIdentifier)
        tableView.register(AddItemTableViewCell.self, forCellReuseIdentifier: AddItemTableViewCell.reuseIdentifier)
        tableView.register(FoodEntryTableViewCell.self, forCellReuseIdentifier: FoodEntryTableViewCell.reuseIdentifier)

        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func didTapSaveButton() -> UIAction {
        return UIAction { [weak self] _ in
            guard let self else { return }
            do {
                let foodPortion = FoodInfoPortion(context: self.recipeContext)
                foodPortion.id = self.recipeEntry.portionId
                foodPortion.gramWeight = self.recipeEntry.gramWeight
                foodPortion.amount = self.recipeEntry.amount
                foodPortion.modifier = self.recipeEntry.modifier
                foodPortion.foodInfo = self.recipeEntry.foodInfo
                                
                try recipeContext.save()   // fully commit recipe context changes
                CoreDataStack.shared.saveContext()
                
                // We just adding to history, (does not log to any meals)
                if let fdcRecipe = recipeEntry.convertToFDCFood() {
                    print("timmy ingredients: \(fdcRecipe.ingredients.map { $0.description })")
                    self.foodService.addHistoryIfNeeded(fdcFood: fdcRecipe, context: CoreDataStack.shared.context)
                    CoreDataStack.shared.saveContext()
                }
                addFoodDelegate?.addFoodDetailViewController(self, didAddFood: recipeEntry) // add to meal in diary
                dismiss(animated: true)
                
            } catch {
                print("Error saving food entry")
            }
        }
    }
    
    func didTapCancelButton() -> UIAction {
        return UIAction { [weak self] _ in
            guard let self else { return }
            self.dismiss(animated: true)
        }
    }
    
    func updateSaveButton() {
        let isFormComplete =
        recipeEntry.foodInfo?.name != "" &&
        recipeEntry.ingredients.count > 0
        
        saveButton.isEnabled = isFormComplete
    }
}

extension CreateRecipeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .name:
            return 1
        case .ingredients:
            return 1 + recipeEntry.ingredients.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: CreateFoodInfoTableViewCell.reuseIdentifier, for: indexPath) as! CreateFoodInfoTableViewCell
            cell.update(title: "Name", description: "Required*", placeholderText: "e.g. Protein Smoothie") { [weak self] name in
                guard let self else { return }
                self.recipeEntry.foodInfo?.name = name ?? ""
                self.updateSaveButton()
            }
            cell.selectionStyle = .none // don't show highlight
            return cell
        case .ingredients:
            if indexPath.row == recipeEntry.ingredients.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddItemTableViewCell.reuseIdentifier, for: indexPath) as! AddItemTableViewCell
                cell.update(title: "Add Food")
                return cell
            } else {
                let food = recipeEntry.ingredients[indexPath.row]
                let cell = tableView.dequeueReusableCell(withIdentifier: FoodEntryTableViewCell.reuseIdentifier, for: indexPath) as! FoodEntryTableViewCell
                cell.update(food)
                cell.accessoryType = .disclosureIndicator
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        guard let section = Section(rawValue: indexPath.section),
              section == .ingredients,
              indexPath.row < recipeEntry.ingredients.count else { return }

        // Remove the ingredient from the Core Data relationship
        let foodToDelete = recipeEntry.ingredients[indexPath.row]
        recipeEntry.removeFromIngredients_(foodToDelete)
        recipeContext.delete(foodToDelete)

        // Reindex remaining ingredients
        for (i, ingredient) in recipeEntry.ingredients.enumerated() {
            ingredient.index = Int16(i)
        }

        tableView.deleteRows(at: [indexPath], with: .automatic)
        updateSaveButton()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let section = Section(rawValue: indexPath.section) else { return false }

        switch section {
        case .name:
            return false
        case .ingredients:
            return indexPath.row < recipeEntry.ingredients.count
        }
    }
}

extension CreateRecipeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return nil }
        switch section {
        case .name:
            return nil
        case .ingredients:
            return "Ingredients"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section),
              section == .ingredients
        else { return }
        let isAddFoodButton = indexPath.row == recipeEntry.ingredients.count
        if isAddFoodButton {
            tableView.deselectRow(at: indexPath, animated: true)
            let searchIngredientViewController = SearchIngredientViewController(
                recipeEntry: recipeEntry,
                foodService: foodService,
                userProfile: userProfile
            )
//            searchIngredientViewController.title = "Add Ingredient"
            searchIngredientViewController.addFoodDelegate = self
//            searchFoodTableViewController.quickAddDelegate = self
//            searchFoodTableViewController.resultDelegate = self
            navigationController?.pushViewController(searchIngredientViewController, animated: true)
            return
        }
        
        let foodEntry: FoodEntry = recipeEntry.ingredients[indexPath.row]
        guard let fdcFood = foodEntry.convertToFDCFood() else { return }
        let selectedPortion = foodEntry.foodInfo?.convertToFoodPortions().first { $0.id == foodEntry.portionId }
        
        let updateFoodDetailTableViewController = UpdateFoodDetailViewController(foodEntry: foodEntry, fdcFood: fdcFood, meal: nil, userProfile: userProfile, foodService: foodService)
        updateFoodDetailTableViewController.updateDelegate = self
        updateFoodDetailTableViewController.dismissDelegate = self
        present(UINavigationController(rootViewController: updateFoodDetailTableViewController), animated: true)
    }
    
    // conditionally allow or prevent selection
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let section = Section(rawValue: indexPath.section) else { return nil }
        switch section {
        case .name:
            return nil
        case .ingredients:
            return indexPath
        }
    }
}

extension CreateRecipeViewController: UpdateFoodDetailViewControllerDelegate {
    func updateFoodDetailViewController(_ viewController: UpdateFoodDetailViewController, didUpdateFood food: FoodEntry) {
        tableView.reloadRows(at: [IndexPath(row: Int(food.index), section: Section.ingredients.rawValue)], with: .automatic)
    }

}

extension CreateRecipeViewController: ViewControllerDismissDelegate {
    func viewControllerDidDismiss(_ viewController: UIViewController) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}


extension CreateRecipeViewController: AddFoodDetailViewControllerDelegate {
    // Adds an ingredient
    func addFoodDetailViewController(_ tableViewController: UIViewController, didAddFood ingredient: FoodEntry) {
        // Ingreident may be added from main context (e.g. "My Colleciton", search)
        // existingObject doesn't work for some reason
        
        let indexPath = IndexPath(row: Int(ingredient.index), section: 1)
        print("timmy ingredient index: \(ingredient.index)")
        print("timmy ingredients: \(recipeEntry.ingredients.map { $0.foodInfo?.name })")
        tableView.insertRows(at: [indexPath], with: .automatic)
        self.updateSaveButton()
    }
}
