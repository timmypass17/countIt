//
//  HomeTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/16/24.
//

import UIKit
import SwiftUI
import CoreData

protocol DiaryViewControllerDelegate: AnyObject {
    func diaryViewController(_ viewController: DiaryViewController, mealPlanChanged mealPlan: MealPlan)
}

// Can't use fetch result controller, doesn't detect relationship changes properly. E.g. FRC<Meal>, if you insert food to meal, doesn't see it as "insert" but as an "update" to meal. So doesn't know when to insert/delete rows and crashes
// TODO: add nickname to foods
class DiaryViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .secondarySystemGroupedBackground// UIColor(hex: "#202020")
//        tableView.backgroundColor = UIColor(hex: "#202020")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var userProfile: UserProfile
    var mealPlan: MealPlan!
    let foodService: FoodService
    let goalIndexPath = IndexPath(row: 0, section: 0)
    weak var delegate: DiaryViewControllerDelegate?
    
    enum Section: Int, CaseIterable {
        case goal
        case meals
    }
    
    init(userProfile: UserProfile, foodService: FoodService) {
        if let existingMealPlan = foodService.getMealPlan(date: .now) {
            self.mealPlan = existingMealPlan
        } else {
            do {
                self.mealPlan = try foodService.createEmptyMealPlan(date: .now, userProfile: userProfile)
            } catch {
                // useful for development, don't keep in prod
                fatalError("User profile is missing")
            }
        }
        self.userProfile = userProfile
        self.foodService = foodService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false

        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let mealPlanDateView = MealPlanDateView()
        mealPlanDateView.delegate = self
        navigationItem.titleView = mealPlanDateView
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CaloriesConsumedView.reuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MacrosView.reuseIdentifier)
        tableView.register(FoodEntryTableViewCell.self, forCellReuseIdentifier: FoodEntryTableViewCell.reuseIdentifier)
        tableView.register(MealHeaderView.self, forHeaderFooterViewReuseIdentifier: MealHeaderView.reuseIdentifier)
        tableView.register(AddItemTableViewCell.self, forCellReuseIdentifier: AddItemTableViewCell.reuseIdentifier)
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        let addMealButton = AddMealButton()
        addMealButton.addAction(didTapFooterView(), for: .touchUpInside)
        addMealButton.setTitle("Add Meal", for: .normal)
        footerView.addSubview(addMealButton)
        addMealButton.translatesAutoresizingMaskIntoConstraints = false
//        tableView.tableFooterView = footerView
        
        NSLayoutConstraint.activate([
            addMealButton.topAnchor.constraint(equalTo: footerView.layoutMarginsGuide.topAnchor),
            addMealButton.bottomAnchor.constraint(equalTo: footerView.layoutMarginsGuide.bottomAnchor),
            addMealButton.leadingAnchor.constraint(equalTo: footerView.layoutMarginsGuide.leadingAnchor, constant: 12),
            addMealButton.trailingAnchor.constraint(equalTo: footerView.layoutMarginsGuide.trailingAnchor, constant: -12),
        ])
        
        updateUI()
        
        self.delegate?.diaryViewController(self, mealPlanChanged: self.mealPlan)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func updateUI() {
        let optionsButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis")?.withRenderingMode(.alwaysTemplate),
            menu: buildMenu()
        )
        optionsButton.tintColor = .white

//        let profileBarButton = UIBarButtonItem(
//            image: UIImage(systemName: "person.fill")?.withRenderingMode(.alwaysTemplate),
//            primaryAction: didTapProfileButton()
//        )
//        profileBarButton.tintColor = .white

//        navigationItem.leftBarButtonItem = optionsButton
//        navigationItem.rightBarButtonItem = profileBarButton
        
        navigationItem.rightBarButtonItem = optionsButton

        tableView.reloadData()
    }
    
    func didTapProfileButton() -> UIAction {
        return UIAction { _ in
            self.navigationController?.pushViewController(SettingsViewController(userProfile: self.userProfile), animated: true)

//            self.navigationController?.pushViewController(GoalsViewController(userProfile: self.userProfile), animated: true)
        }
    }
    
    func buildMenu() -> UIMenu {
        let copyMenu = UIMenu(title: "Copy Meal Plan From Another Date",
                              image: UIImage(systemName: "doc.on.doc"),
                              options: .displayInline,
                              children: [copyLatestAction(), copyDateAction()])
        
        let menu = UIMenu(children: [editMealsAction(), editFoodsAction(), copyMenu])
        return menu
    }
    
    func reloadTableViewHeader(section: Int) {
        guard let mealHeaderView = tableView.headerView(forSection: section) as? MealHeaderView,
              let mealPlan
        else { return }
        print("timmy reload header: \(section)")
        let meal = mealPlan.meals[section - 2]
        mealHeaderView.update(with: meal)
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
        let alert = UIAlertController(title: "Add Meal", message: "Enter name for meal", preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "e.g. Breakfast"
            let textChangedAction = UIAction { _ in
                alert.actions[1].isEnabled = textField.text!.count > 0
            }
            textField.addAction(textChangedAction, for: .allEditingEvents)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [self] _ in
            guard let mealName = alert.textFields?.first?.text else { return }
            
            do {
                let section = mealPlan.meals.count + 2
                try CoreDataStack.shared.addMeal(mealName: mealName, to: mealPlan)
                tableView.insertSections(IndexSet(integer: section), with: .automatic)
            } catch {
                print("Error adding meal: \(error)")
            }
        }))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func editFoodsAction() -> UIAction {
        return UIAction(title: NSLocalizedString("Edit Foods", comment: ""),
                        image: UIImage(systemName: "carrot"),
                        state: tableView.isEditing ? .on : .off
        ) { [weak self] action in
            guard let self else { return }
            tableView.setEditing(!tableView.isEditing, animated: true)
            navigationItem.leftBarButtonItem?.menu = buildMenu()
        }
    }
    
    func editMealsAction() -> UIAction {
        return UIAction(title: NSLocalizedString("Edit Meals", comment: ""),
                        image: UIImage(systemName: "takeoutbag.and.cup.and.straw")) { [self] action in
            let reorderMealTableViewController = ReorderMealTableViewController(mealPlan: mealPlan)
            reorderMealTableViewController.delegate = self
            self.present(UINavigationController(rootViewController: reorderMealTableViewController), animated: true)
        }
    }
    
    func reorderFoodAction() -> UIAction {
        return UIAction(title: NSLocalizedString("Reorder Food", comment: ""),
                        image: UIImage(systemName: "carrot")) { [self] action in
            tableView.setEditing(!tableView.isEditing, animated: true)
        }
    }
    
    func copyLatestAction() -> UIAction {
        if let previousMealPlan = foodService.getPreviousMealPlan(for: mealPlan.date) {
            let copyAction = UIAction(title: "\(previousMealPlan.date.formatted(date: .abbreviated, time: .omitted))", image: UIImage(systemName: "clock.arrow.circlepath")) { [self] action in
                do {
                    print("timmy copying meal plan")
                    let mealPlan = try foodService.copyMeals(from: previousMealPlan, to: mealPlan)
                    self.mealPlan = mealPlan
                    tableView.reloadData()
                } catch{
                    print("Error copying meals: \(error)")
                }
            }
            return copyAction
            
        } else {
            let copyAction = UIAction(title: "No Previous", image: UIImage(systemName: "clock.arrow.circlepath"), attributes: .disabled) { _ in
            }
            return copyAction
        }
    }
    
    func copyDateAction() -> UIAction {
        return UIAction(title: NSLocalizedString("Select a Date", comment: ""),
                        image: UIImage(systemName: "calendar")) { [self] action in
            let calendarViewController =  CalendarViewController(date: mealPlan.date)
            calendarViewController.delegate = self
            let navigationController = UINavigationController(rootViewController: calendarViewController)
            if let sheet = navigationController.sheetPresentationController {
                sheet.detents = [.medium()]
            }
            
            self.present(navigationController, animated: true)
        }
    }
}

extension DiaryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let caloriesView = 1
        let macrosView = 1
        let mealCount = mealPlan.meals.count
        return caloriesView + macrosView + mealCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        }
        
        let sectionOffset = 2
        let addFoodButton = 1
        let meal = mealPlan.meals[section - 2]
        return (meal.foodEntries.count) + addFoodButton
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let mealPlan else { return UITableViewCell() }
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CaloriesConsumedView.reuseIdentifier, for: indexPath)
                        
            cell.contentConfiguration = UIHostingConfiguration {
                CaloriesConsumedView(mealPlan: mealPlan)
                    .environment(\.managedObjectContext, CoreDataStack.shared.context)
            }
            cell.backgroundColor = UIColor(hex: "#252525")
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MacrosView.reuseIdentifier, for: indexPath)
            
            cell.contentConfiguration = UIHostingConfiguration {
                MacrosView(mealPlan: mealPlan)  // uses coredata fetch, updated automatically when core data changes
                    .environment(\.managedObjectContext, CoreDataStack.shared.context)
            }
            cell.backgroundColor = UIColor(hex: "#252525")
            
            return cell
        }
        
        let meal = mealPlan.meals[indexPath.section - 2]
        if indexPath.row == meal.foodEntries.count {
            // Add Button
            let cell = tableView.dequeueReusableCell(withIdentifier: AddItemTableViewCell.reuseIdentifier, for: indexPath) as! AddItemTableViewCell
            cell.backgroundColor = UIColor(hex: "#252525")

            return cell
        }
        
        let food = meal.foodEntries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodEntryTableViewCell.reuseIdentifier, for: indexPath) as! FoodEntryTableViewCell
        cell.backgroundColor = UIColor(hex: "#252525")
        cell.update(food)
        cell.accessoryType = .disclosureIndicator
        return cell
        
    }
}

extension DiaryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section != 0, section != 1,
              let mealPlan
        else { return nil }
        
        // TODO: Instead of using date picke, just use label and show "Today", "Yesterday", 
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MealHeaderView.reuseIdentifier) as! MealHeaderView
        let meal = mealPlan.meals[section - 2]
        header.update(with: meal)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let mealPlan else { return }
        if indexPath.section == 0 {
            //            let goalTableViewController = GoalTableViewController(mealPlan: mealPlan)
            //            goalTableViewController.delegate = self
            //            navigationController?.pushViewController(goalTableViewController, animated: true)
            return
        }
        
        if indexPath.section == 1 {
            return
        }
        
        let meal = mealPlan.meals[indexPath.section - 2]
        let isAddFoodButton = indexPath.row == meal.foodEntries.count
        if isAddFoodButton {
            tableView.deselectRow(at: indexPath, animated: true)
            let meal = mealPlan.meals[indexPath.section - 2]
            let searchFoodTableViewController = SearchFoodTableViewController(foodService: foodService, meal: meal)
            searchFoodTableViewController.addFoodDelegate = self
            searchFoodTableViewController.quickAddDelegate = self
            searchFoodTableViewController.resultDelegate = self
            navigationController?.pushViewController(searchFoodTableViewController, animated: true)
            return
        }
        
        let foodEntry: FoodEntry = meal.foodEntries[indexPath.row]
        guard let fdcFood = foodEntry.convertToFDCFood() else { return }
        let selectedPortion = foodEntry.foodInfo?.convertToFoodPortions().first { $0.id == foodEntry.portionId }
        fdcFood.ingredients.forEach {
            print("timmy ingred: \($0.description) - \($0.foodPortions)")
        }
        let updateFoodDetailTableViewController = UpdateFoodDetailViewController(foodEntry: foodEntry, fdcFood: fdcFood, meal: meal, foodService: foodService, selectedFoodPortion: selectedPortion, numberOfServings: Int(foodEntry.quantity))
        updateFoodDetailTableViewController.delegate = self
        updateFoodDetailTableViewController.dismissDelegate = self
        present(UINavigationController(rootViewController: updateFoodDetailTableViewController), animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let meal = mealPlan.meals[indexPath.section - 2]
            do {
                let foodToDelete: FoodEntry = meal.foodEntries.remove(at: indexPath.row)
                try foodService.deleteFood(foodToDelete)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
                for (index, food) in meal.foodEntries.enumerated() {
                    food.index = Int16(index)
                }
                
                CoreDataStack.shared.saveContext()
                let indexPaths = meal.foodEntries.map { IndexPath(row: Int($0.index), section: indexPath.section) }
                tableView.reloadRows(at: indexPaths, with: .automatic)
                
                reloadTableViewHeader(section: indexPath.section)
            } catch {
                print("Error deleting food: \(error)")
            }
        }
    }
    
    // Which view can be edited?
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard indexPath.section > 1 else { return false }
        let isFood = indexPath.row < mealPlan.meals[indexPath.section - 2].foodEntries.count
        return isFood
    }
    
    
    // TODO: Bug with reordering
    // Called when a user moves a row (cell) in a table view while it's in editing mode
    // - update your data model to reflect the new position of a moved row
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard destinationIndexPath.section > 1 else { return }

        let sourceMeal = mealPlan.meals[sourceIndexPath.section - 2]
        let destinationMeal = mealPlan.meals[destinationIndexPath.section - 2]
        let food = sourceMeal.foodEntries[sourceIndexPath.row]

        if sourceMeal != destinationMeal {
            // Moving across meals
            sourceMeal.removeFromFoodEntries_(food)   // does update sourceMeal.foods
            destinationMeal.addToFoodEntries_(food)
            food.meal = destinationMeal

            // Reindex source
            let sourceFoods = sourceMeal.foodEntries
            for (i, item) in sourceFoods.enumerated() {
                item.index = Int16(i)
            }

            // Shift destination indices
            let destinationFoods = destinationMeal.foodEntries
            for item in destinationFoods {
                if item.index >= Int16(destinationIndexPath.row) {
                    item.index += 1
                }
            }
        } else {
            // Moving within the same meal
            let sourceFoods = sourceMeal.foodEntries
            if sourceIndexPath.row < destinationIndexPath.row {
                // Shift affected items left
                for item in sourceFoods {
                    if item.index > Int16(sourceIndexPath.row) && item.index <= Int16(destinationIndexPath.row) {
                        item.index -= 1
                    }
                }
            } else if sourceIndexPath.row > destinationIndexPath.row {
                // Shift affected items right
                for item in sourceFoods {
                    if item.index >= Int16(destinationIndexPath.row) && item.index < Int16(sourceIndexPath.row) {
                        item.index += 1
                    }
                }
            }
        }
        
        food.index = Int16(destinationIndexPath.row)
        CoreDataStack.shared.saveContext()
        updateUI()
    }
    
    // Lets you control where a row is allowed to be moved (e.g. Don't let users move food item under "add button")
    // - “Can I drop the row at this new location?”
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        // Rejects any move into sections 0 or 1
        guard proposedDestinationIndexPath.section > 1 else { return sourceIndexPath }
        var isAddButtonRow = mealPlan.meals[proposedDestinationIndexPath.section - 2].foodEntries.count
        if sourceIndexPath.section != proposedDestinationIndexPath.section {
            // When moving between different meals (sections), the Add Food row shifts down by 1. This adjusts for the layout difference that happens when a row is being dragged into a new section.
            isAddButtonRow += 1
        }
        guard proposedDestinationIndexPath.row != isAddButtonRow else { return sourceIndexPath }
        return proposedDestinationIndexPath
    }
}

extension DiaryViewController: AddFoodDetailViewControllerDelegate {
    func addFoodDetailViewController(_ tableViewController: AddFoodDetailViewController, didAddFood food: FoodEntry) {
        guard let meal = food.meal,
              let section = mealPlan.meals.firstIndex(of: meal)
        else { return }
        let indexPath = IndexPath(row: Int(food.index), section: section + 2)
        tableView.insertRows(at: [indexPath], with: .automatic)
        reloadTableViewHeader(section: section + 2)
    }
}

extension DiaryViewController: UpdateFoodDetailViewControllerDelegate {
    func updateFoodDetailViewController(_ viewController: UpdateFoodDetailViewController, didUpdateFood food: FoodEntry) {
        guard let meal = food.meal,
              let section = mealPlan.meals.firstIndex(of: meal)
        else { return }
        let indexPath = IndexPath(row: Int(food.index), section: section + 2)
        tableView.reloadRows(at: [indexPath, IndexPath(row: 0, section: 0), IndexPath(row: 0, section: 1)], with: .automatic)
        reloadTableViewHeader(section: section + 2)
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
        let oldDate = mealPlan.date
        // When moving between dates, clean up empty meals
        if self.mealPlan.isEmpty {
            print("Deleting meal plan: \(date.formatted(date: .abbreviated, time: .omitted))")
            CoreDataStack.shared.context.delete(mealPlan)
            CoreDataStack.shared.saveContext()
        }
        
        if let existingMealPlan = foodService.getMealPlan(date: date) {
            print("Found meal plan: \(date.formatted(date: .abbreviated, time: .omitted))")
            self.mealPlan = existingMealPlan
        } else {
            do {
                print("Creating meal plan: \(date.formatted(date: .abbreviated, time: .omitted))")
                self.mealPlan = try foodService.createEmptyMealPlan(date: date, userProfile: userProfile)
            } catch {
                // useful for development, don't keep in prod
                fatalError("User profile is missing")
            }
        }
        
        updateUI()
        animateTableChange(direction: date > oldDate ? .left : .right)
        
        // Update search controller's meal
        delegate?.diaryViewController(self, mealPlanChanged: self.mealPlan)
    }
    
    enum TableAnimationDirection {
        case left, right
    }

    func animateTableChange(direction: TableAnimationDirection) {
        let transition = CATransition()
        transition.type = .push
        transition.subtype = direction == .left ? .fromRight : .fromLeft
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        tableView.layer.add(transition, forKey: kCATransition)

        tableView.reloadData()
    }
}

extension DiaryViewController: CalendarViewControllerDelegate {
    func calendarViewController(_ sender: CalendarViewController, didSelectDate date: Date) {
        guard let otherMealPlan = foodService.getMealPlan(date: date) else {
            return
        }
        
        do {
            self.mealPlan = try foodService.copyMeals(from: otherMealPlan, to: mealPlan)
        } catch {
            print("Error copying meal by date: \(error)")
        }
        updateUI()
    }
}

extension DiaryViewController: ReorderMealTableViewControllerDelegate {
    func reorderMealTableViewController(_ viewController: ReorderMealTableViewController, didReorderMeals: Bool) {
        updateUI()
    }
}

extension DiaryViewController: QuickAddTableViewControllerDelegate {
    func quickAddTableViewController(_ viewController: QuickAddTableViewController, didAddFoodEntry: FoodEntry) {
        updateUI()
    }
}

extension DiaryViewController: GoalTableViewControllerDelegate {
    func goalTableViewController(_ viewController: GoalTableViewController, didUpdateNutrientGoals nutrientGoals: [NutrientId : Float]) {
        updateUI()
    }
}

extension DiaryViewController: ResultTableViewCellDelegate {
    func resultTableViewCell(_ cell: ResultTableViewCell, didTapAddButton: Bool) {
        updateUI()
    }
}

extension Array where Element == FoodEntry {
    func updateIndexes() {
        for (index, foodEntry) in self.enumerated() {
            foodEntry.index = Int16(index)
        }
    }
}
