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

    var meals: [Meal]
    weak var delegate: ReorderMealTableViewControllerDelegate?
    private let reuseIdentifier = "ReorderCell"
    
    init(meals: [Meal]) {
        self.meals = meals
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        navigationItem.title = "Reorder Meals"
        tableView.setEditing(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", primaryAction: didTapCancelButton())
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", primaryAction: didTapDoneButton())
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let meal = meals[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = meal.name
        config.secondaryText = meal.foodEntries.compactMap { $0.food?.name }.joined(separator: " | ")
        config.secondaryTextProperties.color = .secondaryLabel
        cell.contentConfiguration = config
        return cell
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let foodEntry = meals.remove(at: sourceIndexPath.row)
        meals.insert(foodEntry, at: destinationIndexPath.row)
        meals.updateIndexes()
        delegate?.reorderMealTableViewController(self, didReorderMeals: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removedMeal = meals.remove(at: indexPath.row)
            CoreDataStack.shared.context.delete(removedMeal)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            meals.updateIndexes()
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
