//
//  HomeTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/16/24.
//

import UIKit
import SwiftUI
import CoreData

// Can't use FRC, doesn't detect relationship changes properly. E.g. FRC<Meal>, if you insert food to meal, doesn't see it as "insert" but as an "update" to meal. So doesn't know when to insert/delete rows and crashes
class DiaryViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var userProfile: UserProfile
    var mealPlan: MealPlan!
    let foodService: FoodService
    let goalIndexPath = IndexPath(row: 0, section: 0)
    
    enum Section: Int, CaseIterable {
        case goal
        case meals
    }
    
    init(userProfile: UserProfile, foodService: FoodService) {
        if let existingMealPlan = foodService.getMealPlan(date: .now) {
            self.mealPlan = existingMealPlan
        } else {
            do {
                self.mealPlan = try foodService.createEmptyMealPlan(date: .now)
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
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showToast(message: "Hello World", in: tableView)
    }
    
    func updateUI() {
        let optionsButton = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), menu: buildMenu())
        let profileBarButton = UIBarButtonItem(image: UIImage(systemName: "person.fill"), primaryAction: nil)

        navigationItem.leftBarButtonItem = optionsButton
        navigationItem.rightBarButtonItem = profileBarButton
        
        
        tableView.reloadData()
    }
    
    func buildMenu() -> UIMenu {
        let copyMenu = UIMenu(title: "Copy Meal Plan",
                              image: UIImage(systemName: "doc.on.doc"),
                              children: [copyLatestAction(), copyDateAction()])
        
        let menu = UIMenu(children: [editFoodsAction(), editMealsAction(), copyMenu])
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
        return (meal.foods.count) + addFoodButton
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let mealPlan else { return UITableViewCell() }
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CaloriesConsumedView.reuseIdentifier, for: indexPath)
                        
            cell.contentConfiguration = UIHostingConfiguration {
                CaloriesConsumedView(mealPlan: mealPlan)
                    .environment(\.managedObjectContext, CoreDataStack.shared.context)
            }
            
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MacrosView.reuseIdentifier, for: indexPath)
            
            cell.contentConfiguration = UIHostingConfiguration {
                MacrosView(mealPlan: mealPlan)  // uses coredata fetch, updated automatically when core data changes
                    .environment(\.managedObjectContext, CoreDataStack.shared.context)
            }
            
            return cell
        }
        
        let meal = mealPlan.meals[indexPath.section - 2]
        if indexPath.row == meal.foods.count {
            // Add Button
            let cell = tableView.dequeueReusableCell(withIdentifier: AddFoodTableViewCell.reuseIdentifier, for: indexPath) as! AddFoodTableViewCell
            return cell
        }
        
        let food = meal.foods[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodEntryTableViewCell.reuseIdentifier, for: indexPath) as! FoodEntryTableViewCell
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
        let isAddFoodButton = indexPath.row == meal.foods.count
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
        
        let food: Food = meal.foods[indexPath.row]
        guard let fdcFood = food.convertToFDCFood() else { return }
        let selectedPortion = food.foodInfo?.convertToFoodPortions().first { $0.id == food.portionId }
        let updateFoodDetailTableViewController = UpdateFoodDetailViewController(food: food, fdcFood: fdcFood, meal: meal, foodService: foodService, selectedFoodPortion: selectedPortion, numberOfServings: Int(food.quantity))
        updateFoodDetailTableViewController.delegate = self
        present(UINavigationController(rootViewController: updateFoodDetailTableViewController), animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let meal = mealPlan.meals[indexPath.section - 2]
            do {
                let foodToDelete: Food = meal.foods.remove(at: indexPath.row)
                try foodService.deleteFood(foodToDelete)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
                for (index, food) in meal.foods.enumerated() {
                    food.index = Int16(index)
                }
                
                CoreDataStack.shared.saveContext()
                let indexPaths = meal.foods.map { IndexPath(row: Int($0.index), section: indexPath.section) }
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
        let isFood = indexPath.row < mealPlan.meals[indexPath.section - 2].foods.count
        return isFood
    }
    
    
    // TODO: Bug with reordering
    // Called when a user moves a row (cell) in a table view while it's in editing mode
    // - update your data model to reflect the new position of a moved row
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard destinationIndexPath.section > 1 else { return }

        let sourceMeal = mealPlan.meals[sourceIndexPath.section - 2]
        let destinationMeal = mealPlan.meals[destinationIndexPath.section - 2]
        let food = sourceMeal.foods[sourceIndexPath.row]

        if sourceMeal != destinationMeal {
            // Moving across meals
            sourceMeal.removeFromFoods_(food)   // does update sourceMeal.foods
            destinationMeal.addToFoods_(food)
            food.meal = destinationMeal

            // Reindex source
            let sourceFoods = sourceMeal.foods
            for (i, item) in sourceFoods.enumerated() {
                item.index = Int16(i)
            }

            // Shift destination indices
            let destinationFoods = destinationMeal.foods
            for item in destinationFoods {
                if item.index >= Int16(destinationIndexPath.row) {
                    item.index += 1
                }
            }
        } else {
            // Moving within the same meal
            let sourceFoods = sourceMeal.foods
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
        var isAddButtonRow = mealPlan.meals[proposedDestinationIndexPath.section - 2].foods.count
        if sourceIndexPath.section != proposedDestinationIndexPath.section {
            // When moving between different meals (sections), the Add Food row shifts down by 1. This adjusts for the layout difference that happens when a row is being dragged into a new section.
            isAddButtonRow += 1
        }
        guard proposedDestinationIndexPath.row != isAddButtonRow else { return sourceIndexPath }
        return proposedDestinationIndexPath
    }
}

extension DiaryViewController: AddFoodDetailViewControllerDelegate {
    func addFoodDetailViewController(_ tableViewController: AddFoodDetailViewController, didAddFood food: Food) {
        guard let meal = food.meal,
              let section = mealPlan.meals.firstIndex(of: meal)
        else { return }
        let indexPath = IndexPath(row: Int(food.index), section: section + 2)
        tableView.insertRows(at: [indexPath], with: .automatic)
        reloadTableViewHeader(section: section + 2)
    }
}

extension DiaryViewController: UpdateFoodDetailViewControllerDelegate {
    func updateFoodDetailViewController(_ viewController: UpdateFoodDetailViewController, didUpdateFood food: Food) {
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
        // When moving between dates, clean up empty meals
        if self.mealPlan.isEmpty {
            print("Deleting meal plan: \(date.formatted(date: .abbreviated, time: .omitted))")
            CoreDataStack.shared.context.delete(mealPlan)
        }
        
        if let existingMealPlan = foodService.getMealPlan(date: date) {
            print("Found meal plan: \(date.formatted(date: .abbreviated, time: .omitted))")
            self.mealPlan = existingMealPlan
        } else {
            do {
                print("Creating meal plan: \(date.formatted(date: .abbreviated, time: .omitted))")
                self.mealPlan = try foodService.createEmptyMealPlan(date: date)
            } catch {
                // useful for development, don't keep in prod
                fatalError("User profile is missing")
            }
        }
        
        updateUI()
    }
}

extension DiaryViewController: CalendarViewControllerDelegate {
    func calendarViewController(_ sender: CalendarViewController, didSelectDate date: Date) {
        //        self.mealPlan = CoreDataStack.shared.copy(mealPlanAt: date, into: self.mealPlan)
        //        updateUI()
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

extension Array where Element == Food {
    func updateIndexes() {
        for (index, foodEntry) in self.enumerated() {
            foodEntry.index = Int16(index)
        }
    }
}

func showToast(message: String, in view: UIView) {
    let toastLabel = UILabel()
    toastLabel.text = message
    toastLabel.textColor = .white
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    toastLabel.textAlignment = .center
    toastLabel.font = UIFont.systemFont(ofSize: 14)
    toastLabel.numberOfLines = 0
    toastLabel.alpha = 0.0
    toastLabel.layer.cornerRadius = 10
    toastLabel.clipsToBounds = true

    let padding: CGFloat = 16
    let maxWidth = view.frame.width - padding * 2
    let textSize = toastLabel.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
    toastLabel.frame = CGRect(x: padding,
                              y: view.safeAreaInsets.top + 10,
                              width: maxWidth,
                              height: textSize.height + 20)

    view.addSubview(toastLabel)

    UIView.animate(withDuration: 0.5, animations: {
        toastLabel.alpha = 1.0
    }) { _ in
        UIView.animate(withDuration: 0.5, delay: 2.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }) { _ in
            toastLabel.removeFromSuperview()
        }
    }
}
