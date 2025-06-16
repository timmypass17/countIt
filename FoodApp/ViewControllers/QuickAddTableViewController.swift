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

class QuickAddTableViewController: UITableViewController {

    lazy var foodEntry: FoodEntry = {
        var foodEntry = FoodEntry(context: childContext)
        foodEntry.quantity = 1
        foodEntry.gramWeight = 100
        foodEntry.amount = 1
        foodEntry.modifier = "serving"
        foodEntry.portionId = 0
        
        let foodInfo = FoodInfo(context: childContext)
        foodInfo.fdcId = Int64.random(in: Int64.min..<0)
        foodInfo.brandName_ = "Quick Add"
        foodEntry.foodInfo = foodInfo
        
        for nutrientId in NutrientId.allCases {
            let foodInfoNutrient = FoodInfoNutrient(context: childContext)
            foodInfoNutrient.nutrientId = nutrientId
            foodInfo.addToNutrients_(foodInfoNutrient)
        }
        
        let foodPortion = FoodInfoPortion(context: childContext)
        foodPortion.id = 0
        foodPortion.gramWeight = 100
        foodPortion.amount = 1
        foodPortion.modifier = "serving"
        foodPortion.foodInfo = foodInfo
        
        return foodEntry
    }()
    
    var childContext: NSManagedObjectContext = CoreDataStack.shared.childContext()
    
    enum Section {
        case main, extra
    }
    
    let nutrientIds: [NutrientId] = [.calories, .carbs, .protein, .fatTotal]

    let meal: Meal
    let foodService = FoodService()
    weak var delegate: QuickAddTableViewControllerDelegate?

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
        return 5
//        guard let foodNutrients = foodEntry.food?.foodNutrients else { return 0 }
//        return 1 + foodNutrients.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuickAddTableViewCell.reuseIdentifier, for: indexPath) as! QuickAddTableViewCell
        cell.delegate = self
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            cell.update(title: foodEntry.foodInfo?.name)
            return cell
        }
        
        let nutrientId = nutrientIds[indexPath.row - 1]
        guard let nutrient = foodEntry.foodInfo?.nutrients[nutrientId] else { return UITableViewCell() }
        cell.update(foodNutrient: nutrient)
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
            let nutrients = foodEntry.foodInfo?.nutrients ?? []
            for nutrient in nutrients {
                if nutrient.value == nil {
                    nutrient.value = 0
                }
            }
            
            let mealInChildContext = childContext.object(with: meal.objectID) as! Meal
            foodEntry.index = Int16(mealInChildContext.foodEntries.count)
            foodEntry.meal = mealInChildContext
            foodService.updateFoodHistoryIfNeeded(food: foodEntry, context: childContext)
            try? childContext.save()
            CoreDataStack.shared.saveContext()
            delegate?.quickAddTableViewController(self, didAddFoodEntry: foodEntry)
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            dismiss(animated: true)
        }
    }
    
    func updateUI() {
        let shouldEnableAddButton = foodEntry.foodInfo?.name != "" && foodEntry.foodInfo?.nutrients[.calories]?.value != nil
        navigationItem.rightBarButtonItem?.isEnabled = shouldEnableAddButton
    }
}

extension QuickAddTableViewController: QuickAddTableViewCellDelegate {
    func quickAddTableViewCell(_ cell: QuickAddTableViewCell, textFieldValueChanged text: String?) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        if indexPath == IndexPath(row: 0, section: 0) {
            foodEntry.foodInfo?.name_ = text
        } else {
            let nutrientId = nutrientIds[indexPath.row - 1]
            if let text, let nutrientAmount = Double(text) {
                foodEntry.foodInfo?.nutrients[nutrientId]?.value = nutrientAmount
            } else {
                foodEntry.foodInfo?.nutrients[nutrientId]?.value = nil
            }
        }
        updateUI()
    }

}
