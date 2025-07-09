//
//  QuickAddTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 4/3/24.
//

import UIKit
import CoreData

protocol QuickAddViewControllerDelegate: AnyObject {
    func quickAddViewController(_ viewController: QuickAddFoodViewController, didAddFoodEntry foodEntry: FoodEntry)
}

class QuickAddFoodViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var foodEntry: FoodEntry = {
        var foodEntry = FoodEntry(context: childContext)
        foodEntry.quantity = 1
        foodEntry.gramWeight = nil
        foodEntry.amount = 1
        foodEntry.modifier = "serving"
        foodEntry.portionId = 0
        foodEntry.isCustom = true
        foodEntry.isRecipe = false
        
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
        foodPortion.gramWeight = nil
        foodPortion.amount = 1
        foodPortion.modifier = "serving"
        foodPortion.foodInfo = foodInfo
        
        return foodEntry
    }()
    
    var childContext: NSManagedObjectContext = CoreDataStack.shared.childContext()
    
    let nutrientIds: [NutrientId] = [.calories, .carbs, .protein, .fatTotal]
    
    let foodService = FoodService()
    weak var delegate: QuickAddViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TextFieldInputTableViewCell.self, forCellReuseIdentifier: TextFieldInputTableViewCell.reuseIdentifier)
        tableView.register(NutritionTextFieldTableViewCell.self, forCellReuseIdentifier: NutritionTextFieldTableViewCell.reuseIdentifier)
        navigationItem.title = "Quick Add"
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: didTapCancelButton())
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", primaryAction: didTapAddButton())
        tableView.dataSource = self
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        updateUI()
    }
    
    func didTapCancelButton() -> UIAction {
        return UIAction { _ in
            self.dismiss(animated: true)
        }
    }
    
    
    func didTapAddButton() -> UIAction {
        return UIAction { [self] _ in
            let nutrients = foodEntry.foodInfo?.nutrients ?? []
            // fill in nil values
            for nutrient in nutrients {
                if nutrient.value == nil {
                    nutrient.value = 0
                }
            }
            
            do {
                // We just adding to history, (does not log to any meals)
                let history = History(context: self.childContext)
                history.fdcId = self.foodEntry.foodInfo!.fdcId
                history.createdAt_ = .now
                history.foodEntry = self.foodEntry
                
                try self.childContext.save()
                CoreDataStack.shared.saveContext()
                self.dismiss(animated: true)
            } catch {
                print("Error quick add: \(error)")
            }
        }
    }
    
    func updateUI() {
        let shouldEnableAddButton = foodEntry.foodInfo?.name != "" && foodEntry.foodInfo?.nutrients[.calories]?.value != nil
        navigationItem.rightBarButtonItem?.isEnabled = shouldEnableAddButton
    }
}

extension QuickAddFoodViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldInputTableViewCell.reuseIdentifier, for: indexPath) as! TextFieldInputTableViewCell
            cell.update(title: "Name", valueText: foodEntry.foodInfo?.name_, placeholderText: "Required", unit: "")
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTextFieldTableViewCell
            
            let nutrientId = nutrientIds[indexPath.row - 1]
            cell.update(
                title: nutrientId.description,
                unit: nutrientId.unitName,
                value: foodEntry.foodInfo?.nutrients[nutrientId]?.value,
                placeholder: nutrientId.isRequired ? "Required" : "Optional") { valueText in
                    guard let valueText, let value = Double(valueText) else {
                        self.foodEntry.foodInfo?.nutrients[nutrientId]?.value = nil
                        self.updateUI()
                        return
                    }
                    
                    self.foodEntry.foodInfo?.nutrients[nutrientId]?.value = value
                    self.updateUI()
                }
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension QuickAddFoodViewController: QuickAddTableViewCellDelegate {
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

extension QuickAddFoodViewController: TextFieldInputTableViewCellDelegate {
    func textFieldInputTableViewCell(_ sender: TextFieldInputTableViewCell, textDidChange text: String?) {
        foodEntry.foodInfo?.name_ = text
        updateUI()
    }
}
