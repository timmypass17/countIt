//
//  ReorderMealTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/21/24.
//

import UIKit

protocol ReorderMealTableViewControllerDelegate: AnyObject {
    func reorderMealTableViewController(_ viewController: ReorderMealTableViewController, didReorderMeals: Bool)
}

class ReorderMealTableViewController: UITableViewController {

    var mealPlan: MealPlan
    weak var delegate: ReorderMealTableViewControllerDelegate?
    private let reuseIdentifier = "ReorderCell"
    
    init(mealPlan: MealPlan) {
        self.mealPlan = mealPlan
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        navigationItem.title = "Edit Meals"
        tableView.setEditing(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", primaryAction: didTapCancelButton())
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", primaryAction: didTapDoneButton())
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealPlan.meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let meal = mealPlan.meals[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = meal.name
        config.secondaryText = meal.foodEntries.compactMap { $0.foodInfo?.name }.joined(separator: " ,")
        config.secondaryTextProperties.numberOfLines = 1
        config.secondaryTextProperties.color = .secondaryLabel
        cell.contentConfiguration = config
        return cell
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let meals = mealPlan.meals
        let meal = mealPlan.meals[sourceIndexPath.row]
        if sourceIndexPath.row < destinationIndexPath.row {
            // Shift affected items left
            for meal in meals {
                if meal.index > Int16(sourceIndexPath.row) && meal.index <= Int16(destinationIndexPath.row) {
                    meal.index -= 1
                }
            }
        } else if sourceIndexPath.row > destinationIndexPath.row {
            // Shift affected items right
            for meal in meals {
                if meal.index >= Int16(destinationIndexPath.row) && meal.index < Int16(sourceIndexPath.row) {
                    meal.index += 1
                }
            }
        }
        
        meal.index = Int16(destinationIndexPath.row)
        CoreDataStack.shared.saveContext()
        delegate?.reorderMealTableViewController(self, didReorderMeals: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var meals = mealPlan.meals
            let mealToRemove = meals.remove(at: indexPath.row)
            mealPlan.removeFromMeals_(mealToRemove) // doesn't remove from "meals" array
            
            for (i, meal) in meals.enumerated() {
                meal.index = Int16(i)
            }
            
            CoreDataStack.shared.context.delete(mealToRemove)
            CoreDataStack.shared.saveContext()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            delegate?.reorderMealTableViewController(self, didReorderMeals: true)
        }
    }
    
    func didTapCancelButton() -> UIAction {
        return UIAction { _ in
            self.dismiss(animated: true)
        }
    }
    
    func didTapDoneButton() -> UIAction {
        return UIAction { _ in
            self.dismiss(animated: true)
        }
    }
}
