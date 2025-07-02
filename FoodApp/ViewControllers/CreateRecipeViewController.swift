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
    
    lazy var foodEntry: FoodEntry = {
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
        print("timmy init CreateRecipeViewController")
    }
    
    deinit {
        print("timmy deinit CreateRecipeViewController")
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
                foodPortion.id = self.foodEntry.portionId
                foodPortion.gramWeight = self.foodEntry.gramWeight
                foodPortion.amount = self.foodEntry.amount
                foodPortion.modifier = self.foodEntry.modifier
                foodPortion.foodInfo = self.foodEntry.foodInfo
                
                // We just adding to history, (does not log to any meals)
                let history = History(context: self.recipeContext)
                history.fdcId = self.foodEntry.foodInfo!.fdcId
                history.createdAt_ = .now
                history.foodEntry = self.foodEntry

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
        foodEntry.foodInfo?.name_ != nil &&
        foodEntry.ingredients.count > 0
        
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
            return 1 + foodEntry.ingredients.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: CreateFoodInfoTableViewCell.reuseIdentifier, for: indexPath) as! CreateFoodInfoTableViewCell
            cell.update(title: "Name", description: "Required*", placeholderText: "e.g. Protein Smoothie") { [weak self] name in
                guard let self else { return }
                self.foodEntry.foodInfo?.name = name ?? ""
                self.updateSaveButton()
            }
            return cell
        case .ingredients:
            if indexPath.row == foodEntry.ingredients.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddItemTableViewCell.reuseIdentifier, for: indexPath) as! AddItemTableViewCell
                return cell
            } else {
                let food = foodEntry.ingredients[indexPath.row]
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
              indexPath.row < foodEntry.ingredients.count else { return }

        // Remove the ingredient from the Core Data relationship
        let foodToDelete = foodEntry.ingredients[indexPath.row]
        foodEntry.removeFromIngredients_(foodToDelete)
        recipeContext.delete(foodToDelete)

        // Reindex remaining ingredients
        for (i, ingredient) in foodEntry.ingredients.enumerated() {
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
            return indexPath.row < foodEntry.ingredients.count
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
        let isAddFoodButton = indexPath.row == foodEntry.ingredients.count
        if isAddFoodButton {
            tableView.deselectRow(at: indexPath, animated: true)
            let searchFoodTableViewController = SearchFoodTableViewController(
                foodService: foodService,
                foodEntry: foodEntry,
                userProfile: userProfile,
                visibleTabs: [.all, .myFoods],
                visibleButtonTypes: [.barcode, .quickAdd, .addFood]
            )
            searchFoodTableViewController.title = "Add Ingredient"
            searchFoodTableViewController.addFoodDelegate = self
//            searchFoodTableViewController.quickAddDelegate = self
//            searchFoodTableViewController.resultDelegate = self
            navigationController?.pushViewController(searchFoodTableViewController, animated: true)
            return
        }
        
        let foodEntry: FoodEntry = foodEntry.ingredients[indexPath.row]
        guard let fdcFood = foodEntry.convertToFDCFood() else { return }
        let selectedPortion = foodEntry.foodInfo?.convertToFoodPortions().first { $0.id == foodEntry.portionId }
        
        let updateFoodDetailTableViewController = UpdateFoodDetailViewController(foodEntry: foodEntry, fdcFood: fdcFood, meal: nil, userProfile: userProfile, foodService: foodService, selectedFoodPortion: selectedPortion, numberOfServings: Int(foodEntry.quantity))
        updateFoodDetailTableViewController.delegate = self
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
    func addFoodDetailViewController(_ tableViewController: AddFoodDetailViewController, didAddFood food: FoodEntry) {
//        try? food.managedObjectContext?.save()
//
//        let foodID = food.objectID
//        let foodInChildContext = recipeContext.object(with: foodID) as! FoodEntry
        
        food.index = Int16(foodEntry.ingredients.count)   // setting relationship does change size of relationship
        food.parent = foodEntry
        foodEntry.addToIngredients_(food)
        let indexPath = IndexPath(row: Int(food.index), section: 1)
        tableView.insertRows(at: [indexPath], with: .automatic)
        self.updateSaveButton()
    }
}
