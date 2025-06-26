//
//  CreateRecipeViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/22/25.
//

import UIKit
import CoreData

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
        var foodEntry = FoodEntry(context: childContext)
        foodEntry.quantity = 1
        foodEntry.gramWeight = nil
        foodEntry.amount = 1
        foodEntry.modifier = "serving"
        foodEntry.portionId = 0 // 0 means user generated
        foodEntry.isCustom = true
        foodEntry.isRecipe = true
        
        let foodInfo = FoodInfo(context: childContext)
        foodInfo.fdcId = Int64.random(in: Int64.min..<0)    // negative means user generated
        foodInfo.brandName_ = nil
        foodEntry.foodInfo = foodInfo
        
        for nutrientId in NutrientId.allCases {
            let foodInfoNutrient = FoodInfoNutrient(context: childContext)
            foodInfoNutrient.nutrientId = nutrientId
            foodInfo.addToNutrients_(foodInfoNutrient)
        }
        
        return foodEntry
    }()
    
    var childContext: NSManagedObjectContext = CoreDataStack.shared.childContext()
    let foodService = FoodService()
    
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", primaryAction: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", primaryAction: didTapSaveButton())
    }
    
    func didTapSaveButton() -> UIAction {
        return UIAction { _ in
            do {
                let foodPortion = FoodInfoPortion(context: self.childContext)
                foodPortion.id = self.foodEntry.portionId
                foodPortion.gramWeight = self.foodEntry.gramWeight
                foodPortion.amount = self.foodEntry.amount
                foodPortion.modifier = self.foodEntry.modifier
                foodPortion.foodInfo = self.foodEntry.foodInfo
                
                // We just adding to history, (does not log to any meals)
                let history = History(context: self.childContext)
                history.fdcId = self.foodEntry.foodInfo!.fdcId
                history.createdAt_ = .now
                history.foodEntry = self.foodEntry

                try self.childContext.save()
                CoreDataStack.shared.saveContext()
            } catch {
                print("Error saving food entry")
            }
        }
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
            cell.update(title: "Name", description: "Required*", placeholderText: "e.g. Protein Smoothie") { name in
                self.foodEntry.foodInfo?.name = name ?? ""
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
    }
}

extension CreateRecipeViewController: AddFoodDetailViewControllerDelegate {
    func addFoodDetailViewController(_ tableViewController: AddFoodDetailViewController, didAddFood food: FoodEntry) {
        let foodID = food.objectID
        let foodInChildContext = childContext.object(with: foodID) as! FoodEntry
                
        foodInChildContext.index = Int16(foodEntry.ingredients.count)   // setting relationship does change size of relationship
        foodInChildContext.parent = foodEntry
        foodEntry.addToIngredients_(foodInChildContext)
        let indexPath = IndexPath(row: Int(foodInChildContext.index), section: 1)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}
