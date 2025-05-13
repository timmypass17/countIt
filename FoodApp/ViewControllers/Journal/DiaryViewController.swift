//
//  HomeTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/16/24.
//

import UIKit
import SwiftUI

class DiaryViewController: UITableViewController {
        
    var mealPlan: MealPlan
    let foodService: FoodService
    let goalIndexPath = IndexPath(row: 0, section: 0)
    
    enum Section: Int, CaseIterable {
        case goal
        case meals
    }
    
    init(foodService: FoodService) {
        if let existingMealPlan = foodService.getMealPlan(date: .now) {
            self.mealPlan = existingMealPlan
        } else {
            self.mealPlan = foodService.createEmptyMealPlan(date: .now)
        }
        
        self.foodService = foodService
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mealPlanDateView = MealPlanDateView()
        mealPlanDateView.delegate = self
        navigationItem.titleView = mealPlanDateView
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MacrosView.reuseIdentifier)
        tableView.register(FoodEntryTableViewCell.self, forCellReuseIdentifier: FoodEntryTableViewCell.reuseIdentifier)
        tableView.register(MealHeaderView.self, forHeaderFooterViewReuseIdentifier: MealHeaderView.reuseIdentifier)
        tableView.register(AddFoodTableViewCell.self, forCellReuseIdentifier: AddFoodTableViewCell.reuseIdentifier)

        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        let addMealButton = AddMealButton()
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
        
        updateUI()
    }
    
    func updateUI() {
        let copyMenu = UIMenu(title: "Copy Meal Plan",
                              image: UIImage(systemName: "doc.on.doc"),
                              children: [copyLatestAction(), copyDateAction()])

        let menu = UIMenu(children: [reorderMealAction(), copyMenu])
        
        let optionsButton = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), menu: menu)
        navigationItem.leftBarButtonItem = optionsButton
        navigationItem.rightBarButtonItem = editButtonItem
        
        tableView.reloadData()
    }
    
    func reloadTableViewHeader(at section: Int) {
        guard let mealHeaderView = tableView.headerView(forSection: section) as? MealHeaderView else { return }
        let meal = mealPlan.meals[section - 1]
        mealHeaderView.update(with: meal)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + mealPlan.meals.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }

        return self.mealPlan.meals[section - 1].foods.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MacrosView.reuseIdentifier, for: indexPath)
//            let calories = MacroData(amount: mealPlan.getTotalNutrients(.calories), goal: mealPlan.nutrientGoals[.calories, default: 0.0])
//            let carbs = MacroData(amount: mealPlan.getTotalNutrients(.carbs), goal: mealPlan.nutrientGoals[.carbs, default: 0.0])
//            let protein = MacroData(amount: mealPlan.getTotalNutrients(.protein), goal: mealPlan.nutrientGoals[.protein, default: 0.0])
//            let fats = MacroData(amount: mealPlan.getTotalNutrients(.totalFat), goal: mealPlan.nutrientGoals[.totalFat, default: 0.0])
            let calories = MacroData(amount: 0, goal: 0)
            let carbs = MacroData(amount: 0, goal: 0)
            let protein = MacroData(amount: 0, goal: 0)
            let fats = MacroData(amount: 0, goal: 0)

            cell.contentConfiguration = UIHostingConfiguration { // affected by reloadData(), can't get it to update automatically
                MacrosView(calories: calories, carbs: carbs, protein: protein, fats: fats)
            }
        
            return cell
        }

        let count = mealPlan.meals[indexPath.section - 1].foods.count
        if indexPath.row == count {
            // Add Button
            let cell = tableView.dequeueReusableCell(withIdentifier: AddFoodTableViewCell.reuseIdentifier, for: indexPath) as! AddFoodTableViewCell
            return cell
        }
        
        let food = mealPlan.meals[indexPath.section - 1].foods[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodEntryTableViewCell.reuseIdentifier, for: indexPath) as! FoodEntryTableViewCell
        cell.update(with: food)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 0 else { return nil }
        return "Goals"
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section != 0 else { return nil }
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MealHeaderView.reuseIdentifier) as! MealHeaderView
        let meal = mealPlan.meals[section - 1]
        header.update(with: meal)
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
//            let goalTableViewController = GoalTableViewController(mealPlan: mealPlan)
//            goalTableViewController.delegate = self
//            navigationController?.pushViewController(goalTableViewController, animated: true)
            return
        }
        
        let count = mealPlan.meals[indexPath.section - 1].foods.count
        if indexPath.row == count {
            tableView.deselectRow(at: indexPath, animated: true)
            let meal = mealPlan.meals[indexPath.section - 1]
            let searchFoodTableViewController = SearchFoodTableViewController(foodService: foodService, meal: meal)
            searchFoodTableViewController.delegate = self
            searchFoodTableViewController.quickAddDelegate = self
            searchFoodTableViewController.resultDelegate = self
            navigationController?.pushViewController(searchFoodTableViewController, animated: true)
            return
        }
        
//        let meal = mealPlan.meals[indexPath.section - 1]
//        let foodEntry = meal.foodEntries[indexPath.row]
//        guard let food = foodEntry.food?.convertToFDCFood() else { return }
//        let foodDetailTableViewController = FoodDetailTableViewController(
//            food: food,
//            meal: meal,
//            foodService: foodService,
//            selectedFoodPortion: foodEntry.servingSize,
//            numberOfServings: foodEntry.numberOfServings,
//            state: .edit
//        )
//        foodDetailTableViewController.foodEntry = foodEntry
//        foodDetailTableViewController.dismissDelegate = self
//        foodDetailTableViewController.delegate = self
//        
//        present(UINavigationController(rootViewController: foodDetailTableViewController), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        guard indexPath.section != 0 else { return false }
//        let addFoodRow = mealPlan.meals[indexPath.section - 1].foodEntries.count
//        guard indexPath.row != addFoodRow else { return false }
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let foodEntry = mealPlan.meals[indexPath.section - 1].foodEntries[indexPath.row]
//            mealPlan.meals[indexPath.section - 1].removeFromFoodEntries_(foodEntry)
//            
//            tableView.beginUpdates()
//            tableView.reloadRows(at: [goalIndexPath], with: .automatic)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            tableView.endUpdates()
//            reloadTableViewHeader(at: indexPath.section)
//        }
    }
    
    // TODO: Bug with reordering
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        guard destinationIndexPath.section != 0 else { return }
//        
//        let foodEntry = mealPlan.meals[sourceIndexPath.section - 1].foodEntries.remove(at: sourceIndexPath.row)
//        mealPlan.meals[sourceIndexPath.section - 1].foodEntries.updateIndexes()
//        
//        // Shift everything in array to the right, th#imageLiteral(resourceName: "simulator_screenshot_FBD26982-5845-4701-BBC6-AD449B84350D.png")en insert item (like implementing array insert). Update backwards (cause sorted by index)
//        let foodEntryCount = mealPlan.meals[destinationIndexPath.section - 1].foodEntries.count
//        for i in stride(from: foodEntryCount - 1, to: destinationIndexPath.row - 1, by: -1) {
//            mealPlan.meals[destinationIndexPath.section - 1].foodEntries[i].index += 1
//        }
//        
//        foodEntry.index = Int16(destinationIndexPath.row)
//        mealPlan.meals[destinationIndexPath.section - 1].foodEntries.insert(foodEntry, at: destinationIndexPath.row)
//
//        foodEntry.meal = mealPlan.meals[destinationIndexPath.section - 1]
//        updateUI()
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
//        // Restricts cell's reorder destination (i.e. repositioning food under "Add Food" button)
//        guard proposedDestinationIndexPath.section != 0 else { return sourceIndexPath }
//        var addFoodRow = mealPlan.meals[proposedDestinationIndexPath.section - 1].foodEntries.count
//        if sourceIndexPath.section != proposedDestinationIndexPath.section {
//            addFoodRow += 1
//        }
//        guard proposedDestinationIndexPath.row != addFoodRow else { return sourceIndexPath }
//        print(proposedDestinationIndexPath)
//        return proposedDestinationIndexPath
        return IndexPath()
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    func didTapAddFoodButton(section: Int) -> UIAction {
        return UIAction { [self] _ in
//            let meal = mealPlan.meals[section - 1]
//            let searchFoodTableViewController = SearchFoodTableViewController(foodService: foodService, meal: meal)
//            searchFoodTableViewController.delegate = self
//            let vc = UINavigationController(rootViewController: searchFoodTableViewController)
//            present(vc, animated: true)
        }
    }
    
    func didTapFooterView() -> UIAction {
        return UIAction { _ in
            self.showMealAlert()
        }
    }
    
    private func showMealAlert() {
//        let alert = UIAlertController(title: "Add Meal", message: "Enter name for meal", preferredStyle: .alert)
//
//        alert.addTextField { textField in
//            textField.placeholder = "Ex. Breakfast"
//            let textChangedAction = UIAction { _ in
//                alert.actions[1].isEnabled = textField.text!.count > 0
//            }
//            textField.addAction(textChangedAction, for: .allEditingEvents)
//        }
//        
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [self] _ in
//            guard let mealName = alert.textFields?.first?.text else { return }
//            CoreDataStack.shared.addMeal(mealName: mealName, to: mealPlan)
//            tableView.insertSections(IndexSet(integer: mealPlan.meals.count), with: .automatic)
//        }))
//
//        // show the alert
//        self.present(alert, animated: true, completion: nil)
    }
    
    func reorderMealAction() -> UIAction {
        return UIAction(title: NSLocalizedString("Edit Meals", comment: ""),
                        image: UIImage(systemName: "takeoutbag.and.cup.and.straw")) { [self] action in
//            let reorderMealTableViewController = ReorderMealTableViewController(meals: mealPlan.meals)
//            reorderMealTableViewController.delegate = self
//            self.present(UINavigationController(rootViewController: reorderMealTableViewController), animated: true)
        }
    }
    
    func reorderFoodAction() -> UIAction {
        return UIAction(title: NSLocalizedString("Reorder Food", comment: ""),
                        image: UIImage(systemName: "carrot")) { [self] action in
            tableView.setEditing(!tableView.isEditing, animated: true)
        }
    }
        
    func copyLatestAction() -> UIAction {
//        if let previousMealPlan = CoreDataStack.shared.getLatestMealPlan(currentDate: mealPlan.date), previousMealPlan.date != mealPlan.date {
//            let copyAction = UIAction(title: "Latest", image: UIImage(systemName: "clock")) { [self] action in
//                let mealPlan = CoreDataStack.shared.copy(mealPlanAt: previousMealPlan.date, into: mealPlan)
//                self.mealPlan = mealPlan
//                tableView.reloadData()
//            }
//            return copyAction
//            
//        } else {
//            let copyAction = UIAction(title: "Latest", image: UIImage(systemName: "clock"), attributes: .disabled) { _ in
//            }
//            return copyAction
//        }
        
        return UIAction {_ in }
    }
        
    func copyDateAction() -> UIAction {
        return UIAction(title: NSLocalizedString("Date", comment: ""),
                        image: UIImage(systemName: "calendar")) { [self] action in
//            let calendarViewController =  CalendarViewController(date: mealPlan.date)
//            calendarViewController.delegate = self
//            let navigationController = UINavigationController(rootViewController: calendarViewController)
//            if let sheet = navigationController.sheetPresentationController {
//                sheet.detents = [.medium()]
//            }
//            
//            self.present(navigationController, animated: true)
        }
    }
}

extension DiaryViewController: FoodDetailTableViewControllerDelegate {
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didAddFoodEntry foodEntry: Food) {
        updateUI()
    }
    
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didUpdateFoodEntry foodEntry: Food) {
        updateUI()
    }
}

extension DiaryViewController: FoodDetailTableViewControllerDismissDelegate {
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didDismiss: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        // Note: pushing vc (navigationContoller.pushViewController()) doesn't require deselecting row (is free) but presenting (present()) vc modally does not have that out the box
    }
}

extension DiaryViewController: MealPlanDateViewDelegate {
    func mealPlanDateViewDelegate(_ sender: MealPlanDateView, datePickerValueChanged date: Date) {
        // When moving between dates, clean up empty meals
//        if self.mealPlan.isEmpty {
//            CoreDataStack.shared.context.delete(mealPlan)
//        }
//        self.mealPlan = CoreDataStack.shared.getMealPlan(for: date) ?? CoreDataStack.shared.createEmpty(for: date)
        updateUI()
    }
}

extension DiaryViewController: CalendarViewControllerDelegate {
    func calendarViewController(_ sender: CalendarViewController, didSelectDate date: Date) {
        self.mealPlan = CoreDataStack.shared.copy(mealPlanAt: date, into: self.mealPlan)
        updateUI()
    }
}

extension DiaryViewController: ReorderMealTableViewControllerDelegate {
    func reorderMealTableViewController(_ viewController: ReorderMealTableViewController, didReorderMeals: Bool) {
        updateUI()
    }
}

extension DiaryViewController: QuickAddTableViewControllerDelegate {
    func quickAddTableViewController(_ viewController: QuickAddTableViewController, didAddFoodEntry: Food) {
        updateUI()
    }
}

extension DiaryViewController: GoalTableViewControllerDelegate {
    func goalTableViewController(_ viewController: GoalTableViewController, didUpdateNutrientGoals nutrientGoals: [NutrientId : Float]) {
        updateUI()
    }
}

extension DiaryViewController: ResultTableViewCellDelegate {
    func resultTableViewCell(_ cell: ResultTableViewCell, didAddFoodEntry foodEntry: Food) {
        print(#function)
        updateUI()
    }
}
