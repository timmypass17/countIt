//
//  HomeTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/16/24.
//

import UIKit
import SwiftUI

class HomeTableViewController: UITableViewController {
        
    let mealPlan: MealPlan
    let foodService: FoodService
    let goalIndexPath = IndexPath(row: 0, section: 0)
    
    enum Section: Int, CaseIterable {
        case goal
        case meals
    }
    
    init(foodService: FoodService) {
        self.mealPlan = CoreDataStack.shared.getMealPlan(for: .now) ?? MealPlan.sample
        self.foodService = foodService
        mealPlan.printPrettyString()
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = HomeTitleView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MacrosView.reuseIdentifier)
        tableView.register(FoodEntryTableViewCell.self, forCellReuseIdentifier: FoodEntryTableViewCell.reuseIdentifier)
        navigationItem.rightBarButtonItem = editButtonItem
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        let addMealButton = AddFoodButton()
        addMealButton.addAction(didTapFooterView(), for: .touchUpInside)
        addMealButton.setTitle("Add Meal", for: .normal)
        footerView.addSubview(addMealButton)
        addMealButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = footerView

        NSLayoutConstraint.activate([
            addMealButton.topAnchor.constraint(equalTo: footerView.layoutMarginsGuide.topAnchor),
            addMealButton.bottomAnchor.constraint(equalTo: footerView.layoutMarginsGuide.bottomAnchor),
            addMealButton.leadingAnchor.constraint(equalTo: footerView.layoutMarginsGuide.leadingAnchor, constant: 12),
            addMealButton.trailingAnchor.constraint(equalTo: footerView.layoutMarginsGuide.trailingAnchor, constant: -12),
        ])
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + mealPlan.meals.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.mealPlan.meals[section - 1].foodEntries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MacrosView.reuseIdentifier, for: indexPath)
            let calories = MacroData(amount: mealPlan.getTotalNutrients(.calories), userGoal: Settings.shared.userDailyValues.calories)
            let carbs = MacroData(amount: mealPlan.getTotalNutrients(.carbs), userGoal: Settings.shared.userDailyValues.carbs)
            let protein = MacroData(amount: mealPlan.getTotalNutrients(.protein), userGoal: Settings.shared.userDailyValues.protein)
            let fats = MacroData(amount: mealPlan.getTotalNutrients(.totalFat), userGoal: Settings.shared.userDailyValues.fat)

            cell.contentConfiguration = UIHostingConfiguration { // affected by reloadData(), can't get it to update automatically
                MacrosView(calories: calories, carbs: carbs, protein: protein, fats: fats)
            }
        
            return cell
        }
        
        let foodEntry = mealPlan.meals[indexPath.section - 1].foodEntries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodEntryTableViewCell.reuseIdentifier, for: indexPath) as! FoodEntryTableViewCell
        cell.update(with: foodEntry)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Goals"
        }
        return mealPlan.meals[section - 1].name
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section != Section.goal.rawValue else { return nil }
        let addFoodView = AddItemView()
        addFoodView.section = section
        addFoodView.addButton.addAction(didTapAddFoodButton(section: section), for: .touchUpInside)
        addFoodView.addButton.setTitle("Add Food", for: .normal)
        return addFoodView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = mealPlan.meals[indexPath.section - 1]
        let foodEntry = meal.foodEntries[indexPath.row]
        guard let food = foodEntry.food?.convertToFDCFood() else { return }
        let foodDetailTableViewController = FoodDetailTableViewController(
            food: food,
            meal: meal,
            foodService: foodService,
            selectedFoodPortion: foodEntry.servingSize,
            numberOfServings: foodEntry.numberOfServings,
            state: .edit
        )
        foodDetailTableViewController.foodEntry = foodEntry
        foodDetailTableViewController.dismissDelegate = self
        foodDetailTableViewController.delegate = self
        
        present(UINavigationController(rootViewController: foodDetailTableViewController), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard indexPath.section != 0 else { return false }
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let foodEntry = mealPlan.meals[indexPath.section - 1].foodEntries[indexPath.row]
            mealPlan.meals[indexPath.section - 1].removeFromFoodEntries_(foodEntry)
            
            tableView.beginUpdates()
            tableView.reloadRows(at: [goalIndexPath], with: .automatic)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let foodEntry = mealPlan.meals[sourceIndexPath.section - 1].foodEntries.remove(at: sourceIndexPath.row)
        mealPlan.meals[destinationIndexPath.section - 1].foodEntries.insert(foodEntry, at: destinationIndexPath.row)

        foodEntry.meal = mealPlan.meals[destinationIndexPath.section - 1]
    }
    
    func didTapAddFoodButton(section: Int) -> UIAction {
        return UIAction { [self] _ in
            let meal = mealPlan.meals[section - 1]
            let searchFoodTableViewController = SearchFoodTableViewController(foodService: foodService, meal: meal)
            searchFoodTableViewController.delegate = self
            let vc = UINavigationController(rootViewController: searchFoodTableViewController)
            searchFoodTableViewController.navigationItem.title = meal.name
            present(vc, animated: true)
        }
    }
    
    func didTapFooterView() -> UIAction {
        return UIAction { _ in
            self.showMealAlert()
        }
    }
    
    private func showMealAlert() {
        let alert = UIAlertController(title: "Add Meal", message: "Enter meal name below", preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "Ex. Breakfast"
            let textChangedAction = UIAction { _ in
                alert.actions[1].isEnabled = textField.text!.count > 0
            }
            textField.addAction(textChangedAction, for: .allEditingEvents)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [self] _ in
            guard let mealName = alert.textFields?.first?.text else { return }
            CoreDataStack.shared.addMeal(mealName: mealName, to: mealPlan)
            tableView.insertSections(IndexSet(integer: mealPlan.meals.count), with: .automatic)
        }))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

extension HomeTableViewController: FoodDetailTableViewControllerDelegate {
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didAddFoodEntry foodEntry: FoodEntry) {
        guard let section = mealPlan.meals.firstIndex(where: { $0 == foodEntry.meal! }) else { return }
        let row = mealPlan.meals[section].foodEntries.count - 1
        let indexPath = IndexPath(row: row, section: section + 1)
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [goalIndexPath], with: .automatic)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didUpdateFoodEntry foodEntry: FoodEntry) {
        guard let section = mealPlan.meals.firstIndex(where: { $0 == foodEntry.meal! }),
              let row = mealPlan.meals[section].foodEntries.firstIndex(where: { $0 == foodEntry })
        else { return }
        let indexPath = IndexPath(row: row, section: section + 1)
        tableView.reloadRows(at: [indexPath, goalIndexPath], with: .automatic)
    }
}

extension HomeTableViewController: FoodDetailTableViewControllerDismissDelegate {
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didDismiss: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
