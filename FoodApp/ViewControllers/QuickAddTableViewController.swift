//
//  QuickAddTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 4/3/24.
//

import UIKit
import CoreData

protocol QuickAddTableViewControllerDelegate: AnyObject {
    func quickAddTableViewController(_ viewController: QuickAddTableViewController, didAddFoodEntry foodEntry: FoodEntry)
}

protocol QuickAddTableViewControllerHistoryDelegate: AnyObject {
    func quickAddTableViewController(_ viewController: QuickAddTableViewController, didUpdateHistoryWithFood food: CDFood)
}

class QuickAddTableViewController: UITableViewController {

    // lazy - item isn't created until it's called for the first time (able to use 'self' within property initalizer)
    lazy var foodEntry: FoodEntry = {
        var foodEntry = FoodEntry(context: childContext)
        foodEntry.numberOfServings = 1
        let foodPortion = FoodPortion(amount: 1, gramWeight: 100, modifier: "Quick Add")
        foodEntry.servingSize = foodPortion
        foodEntry.index = Int16(meal.foodEntries.count)

        var food = CDFood(context: childContext)
        food.updatedAt_ = .now
        food.servingSize = 1
        food.servingSizeUnit = "unspecified"
        food.foodPortions = [foodPortion]
        food.foodNutrients = [
            FoodNutrient(nutrient: Nutrient(id: .calories, name: "Calories", unitName: "kcal"), amount: nil),
            FoodNutrient(nutrient: Nutrient(id: .carbs, name: "Carbohydrates", unitName: "g"), amount: nil),
            FoodNutrient(nutrient: Nutrient(id: .protein, name: "Protein", unitName: "g"), amount: nil),
            FoodNutrient(nutrient: Nutrient(id: .totalFat, name: "Fats", unitName: "g"), amount: nil),
        ]
        food.fdcId = Int64.random(in: -2147483648...0)  // Using Int64.min doesn't work with core data predicates? Too low number maybe
        food.dataType = ""
        food.brandName = "Quick Add"
        
        foodEntry.food = food
        
        return foodEntry
    }()
    
    var childContext: NSManagedObjectContext = {
        var childContext = NSManagedObjectContext(.mainQueue)
        childContext.parent = CoreDataStack.shared.context
        return childContext
    }()

    let meal: Meal
    weak var delegate: QuickAddTableViewControllerDelegate?
    weak var historyDelegate: QuickAddTableViewControllerHistoryDelegate?

    init(meal: Meal) {
        self.meal = meal
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(QuickAddTableViewCell.self, forCellReuseIdentifier: QuickAddTableViewCell.reuseIdentifier)
        navigationItem.title = "Quick Add"
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: didTapCancelButton())
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", primaryAction: didTapAddButton())
        updateUI()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let foodNutrients = foodEntry.food?.foodNutrients else { return 0 }
        return 1 + foodNutrients.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuickAddTableViewCell.reuseIdentifier, for: indexPath) as! QuickAddTableViewCell
        cell.foodEntry = foodEntry
        cell.delegate = self
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            let title = foodEntry.food?.name ?? ""
            cell.update(title: title)
            return cell
        }
        
        guard let foodNutrient = foodEntry.food?.foodNutrients[indexPath.row - 1] else { return UITableViewCell() }
        cell.update(foodNutrient: foodNutrient)
        cell.textField.keyboardType = .numberPad
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Food Entry"
    }
    
    func didTapCancelButton() -> UIAction {
        return UIAction { _ in
            self.dismiss(animated: true)
        }
    }
    
    func didTapAddButton() -> UIAction {
        return UIAction { [self] _ in
            try? childContext.save()
            // fix illegal relationship (when setting foodEntry.meal) between multible contexts by updating the foodEntry child context with the main context
            let item = CoreDataStack.shared.context.object(with: foodEntry.objectID) as! FoodEntry
            item.meal = meal
            delegate?.quickAddTableViewController(self, didAddFoodEntry: item)
            if let food = item.food {
                historyDelegate?.quickAddTableViewController(self, didUpdateHistoryWithFood: food)
            }
            dismiss(animated: true)
            
        }
    }
    
    func updateUI() {
        let shouldEnableAddButton = foodEntry.food?.name != "" && foodEntry.food?.foodNutrients[0].amount != nil
        navigationItem.rightBarButtonItem?.isEnabled = shouldEnableAddButton
    }
}

extension QuickAddTableViewController: QuickAddTableViewCellDelegate {
    func quickAddTableViewCell(_ cell: QuickAddTableViewCell, textFieldValueChanged: String) {
        updateUI()
    }
}
