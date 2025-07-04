//
//  CreateRecipeViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/22/25.
//

import UIKit
import CoreData

// TODO: Unsaved ingredients are unexepctly being saved if user discards recipe midway and saves something else later
class CreateRecipeViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = UIColor(hex: "#1c1c1e")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    enum Section: Int, CaseIterable {
        case name, ingredients
    }
    
    lazy var recipeEntry: FoodEntry = {
        var foodEntry = FoodEntry(context: recipeContext)
        foodEntry.quantity = 1
        foodEntry.gramWeight = nil
        foodEntry.amount = 1
        foodEntry.modifier = "serving"
        foodEntry.portionId = 0 // 0 means user generated
        foodEntry.isCustom = true
        foodEntry.isRecipe = true
        
        let foodInfo = FoodInfo(context: recipeContext)
        foodInfo.fdcId = Int64.random(in: Int64.min..<0)    // negative means user generated
        foodInfo.brandName_ = nil
        foodEntry.foodInfo = foodInfo
        
        for nutrientId in NutrientId.allCases {
            let foodInfoNutrient = FoodInfoNutrient(context: recipeContext)
            foodInfoNutrient.nutrientId = nutrientId
            foodInfo.addToNutrients_(foodInfoNutrient)
        }
        
        return foodEntry
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
    
    let userProfile: UserProfile
    
    init(userProfile: UserProfile) {
        self.userProfile = userProfile
        super.init(nibName: nil, bundle: nil)
//        print("timmy init CreateRecipeViewController")
    }
    
    deinit {
//        print("timmy deinit CreateRecipeViewController")
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
                
                // We just adding to history, (does not log to any meals)
                let history = History(context: self.recipeContext)
                history.fdcId = self.recipeEntry.foodInfo!.fdcId
                history.createdAt_ = .now
                history.foodEntry = self.recipeEntry
                
//                // Update ingredients
//                for ingredient in foodEntry.ingredients {
//                    guard let fdcId = ingredient.foodInfo?.fdcId else { continue }
//                    if fdcId < 0 {
//                        ingredient.isCustom = true
//                    } else {
//                        ingredient.isCustom = true
//                    }
//                    ingredient.is
//                }

                try self.recipeContext.save()
                CoreDataStack.shared.saveContext()
                self.dismiss(animated: true)
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
        recipeEntry.foodInfo?.name_ != nil &&
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
            return cell
        case .ingredients:
            if indexPath.row == recipeEntry.ingredients.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddItemTableViewCell.reuseIdentifier, for: indexPath) as! AddItemTableViewCell
                return cell
            } else {
                let food = recipeEntry.ingredients[indexPath.row]
                let cell = tableView.dequeueReusableCell(withIdentifier: FoodEntryTableViewCell.reuseIdentifier, for: indexPath) as! FoodEntryTableViewCell
                cell.backgroundColor = UIColor(hex: "#252525")
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
        
        let updateFoodDetailTableViewController = UpdateFoodDetailViewController(foodEntry: foodEntry, fdcFood: fdcFood, meal: nil, userProfile: userProfile, foodService: foodService, selectedFoodPortion: selectedPortion, numberOfServings: Int(foodEntry.quantity))
        updateFoodDetailTableViewController.updateDelegate = self
        updateFoodDetailTableViewController.dismissDelegate = self
        present(UINavigationController(rootViewController: updateFoodDetailTableViewController), animated: true)
    }
}

extension CreateRecipeViewController: UpdateFoodDetailViewControllerDelegate {
    func updateFoodDetailViewController(_ viewController: UpdateFoodDetailViewController, didUpdateFood food: FoodEntry) {
        
    }

}

extension CreateRecipeViewController: FoodDetailTableViewControllerDismissDelegate {
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didDismiss: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}


extension CreateRecipeViewController: AddFoodDetailViewControllerDelegate {
    func addFoodDetailViewController(_ tableViewController: FoodDetailTableViewController, didAddFood food: FoodEntry) {
        // Adds an ingredient
        // Ingreident may be added from main context (e.g. "My Colleciton", search)
        // existingObject doesn't work for some reason
        guard let ingredient = recipeContext.object(with: food.objectID) as? FoodEntry else {
            print("timmy fail to get ingredient")
            return
        }
        print("timmy add ingredient")
        ingredient.index = Int16(recipeEntry.ingredients.count)   // setting relationship does change size of relationship
        ingredient.parent = recipeEntry
        recipeEntry.addToIngredients_(ingredient)
        let indexPath = IndexPath(row: Int(ingredient.index), section: 1)
        tableView.insertRows(at: [indexPath], with: .automatic)
        self.updateSaveButton()
    }
}
