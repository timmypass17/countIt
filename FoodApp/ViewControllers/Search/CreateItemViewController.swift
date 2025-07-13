//
//  AddFoodViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/16/25.
//

import UIKit
import CoreData

// TODO: Make CreateItem, CreateFood (meal), CreateIngredient (recipe entry)
// TODO: Do for all food logging, currently it just creates, it should create AND log to corresponidng meal or recipe. Use has to create and then manually add again, inefficient

protocol CreateItemViewControllerDelegate: AnyObject {
    func createItemViewController(_ viewController: CreateItemViewController, didCreateFood foodEntry: FoodEntry)
}

class CreateItemViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = Settings.shared.currentTheme.background.uiColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    enum Section: Int, CaseIterable {
        case name, macro, vitamins, minerals
    }
    
    lazy var foodEntry: FoodEntry = {
        var foodEntry = FoodEntry(context: childContext)
        foodEntry.quantity = 1
        foodEntry.gramWeight = nil
        foodEntry.amount = nil
        foodEntry.modifier = nil
        foodEntry.portionId = 0 // 0 means user generated
        foodEntry.isCustom = true
        foodEntry.isRecipe = false
        
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
    
    let childContext: NSManagedObjectContext
    
    init(childContext: NSManagedObjectContext) {
        self.childContext = childContext
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let foodService = FoodService()
    
    lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Cancel", primaryAction: didTapCancelButton())
        return button
    }()
    
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Save", style: .plain, target: self, action: nil)
        button.isEnabled = false
        return button
    }()
    
    weak var delegate: CreateItemViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Food"
        tableView.register(CreateFoodInfoTableViewCell.self, forCellReuseIdentifier: CreateFoodInfoTableViewCell.reuseIdentifier)
        tableView.register(NutritionTextFieldTableViewCell.self, forCellReuseIdentifier: NutritionTextFieldTableViewCell.reuseIdentifier)

        tableView.dataSource = self
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func updateSaveButton() {
        let isFormComplete =
        foodEntry.foodInfo?.name != "" &&
        foodEntry.amount != nil &&
        foodEntry.modifier != nil &&
        foodEntry.foodInfo?.nutrients[.calories]?.value != nil
        
        saveButton.isEnabled = isFormComplete
    }
    
    func didTapCancelButton() -> UIAction {
        return UIAction { _ in
            self.dismiss(animated: true)
        }
    }
    
//    func didTapSaveButton() -> UIAction {
//        return UIAction { _ in
//            do {
//                // TODO: Remove grams, custom foods don't follow base 100g, they use their own
//                let foodPortion = FoodInfoPortion(context: self.childContext)
//                foodPortion.id = self.foodEntry.portionId
//                foodPortion.gramWeight = self.foodEntry.gramWeight
//                foodPortion.amount = self.foodEntry.amount
//                foodPortion.modifier = self.foodEntry.modifier
//                foodPortion.foodInfo = self.foodEntry.foodInfo
//                
//                if let fdcFood = self.foodEntry.convertToFDCFood() {
//                    self.foodService.addHistoryIfNeeded(fdcFood: fdcFood, context: self.childContext)
//                }
//
//                try self.childContext.save()
//                CoreDataStack.shared.saveContext()
//                self.dismiss(animated: true)
//                self.delegate?.createItemViewController(self, didCreateFood: self.foodEntry)
//            } catch {
//                print("Error saving food entry")
//            }
//        }
//    }
}

extension CreateItemViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .name:
            return 4
        case .macro:
            return NutrientId.macronutrients.count
        case .vitamins:
            return NutrientId.vitamins.count
        case .minerals:
            return NutrientId.minerals.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .name:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: CreateFoodInfoTableViewCell.reuseIdentifier, for: indexPath) as! CreateFoodInfoTableViewCell
                cell.update(title: "Name", description: "Required*", placeholderText: "e.g. Peanut Butter") { name in
                    self.foodEntry.foodInfo?.name = name ?? ""
                    self.updateSaveButton()
                }
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: CreateFoodInfoTableViewCell.reuseIdentifier, for: indexPath) as! CreateFoodInfoTableViewCell
                cell.update(title: "Brand Name", description: "Optional", placeholderText: "e.g. Skippy") { brandName in
                    self.foodEntry.foodInfo?.brandName_ = brandName
                }
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: CreateFoodInfoTableViewCell.reuseIdentifier, for: indexPath) as! CreateFoodInfoTableViewCell
                cell.update(title: "Serving Size", description: "Required*", placeholderText: "e.g. 2 tbsp") { servingSize in
                    guard let servingSize else {
                        self.foodEntry.amount = nil
                        self.foodEntry.modifier = nil
                        self.updateSaveButton()
                        return
                    }
                    let (amount, modifier) = self.extractAmountAndUnit(from: servingSize)
                    guard let amount else {
                        self.foodEntry.amount = nil
                        self.foodEntry.modifier = nil
                        self.updateSaveButton()
                        return
                    }
                    self.foodEntry.amount = amount
                    self.foodEntry.modifier = modifier
                    self.updateSaveButton()
                }
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTextFieldTableViewCell
                cell.update(title: "Gram Weight", unit: "g", value: foodEntry.gramWeight, placeholder: "Optional") { gramWeight in
                    guard let gramWeight else {
                        self.foodEntry.gramWeight = nil
                        return
                    }

                    self.foodEntry.gramWeight = Double(gramWeight)
                }
                cell.selectionStyle = .none
                return cell
            }
        case .macro:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTextFieldTableViewCell
            let nutrientId = NutrientId.macronutrients[indexPath.row]
            cell.update(
                title: nutrientId.description,
                unit: nutrientId.unitName,
                value: foodEntry.foodInfo?.nutrients[nutrientId]?.value,
                placeholder: nutrientId.isRequired ? "Required" : "Optional") { valueText in
                    guard let valueText, let value = Double(valueText) else {
                        self.foodEntry.foodInfo?.nutrients[nutrientId]?.value = nil
                        self.updateSaveButton()
                        return
                    }
                    
                    self.foodEntry.foodInfo?.nutrients[nutrientId]?.value = value
                    self.updateSaveButton()
                }
            cell.selectionStyle = .none
            return cell
        case .vitamins:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTextFieldTableViewCell
            let nutrientId = NutrientId.vitamins[indexPath.row]
            cell.update(
                title: nutrientId.description,
                unit: nutrientId.unitName,
                value: foodEntry.foodInfo?.nutrients[nutrientId]?.value,
                placeholder: nutrientId.isRequired ? "Required" : "Optional") { valueText in
                    guard let valueText, let value = Double(valueText) else {
                        self.foodEntry.foodInfo?.nutrients[nutrientId]?.value = nil
                        return
                    }
                    
                    self.foodEntry.foodInfo?.nutrients[nutrientId]?.value = value
                }
            cell.selectionStyle = .none
            return cell
        case .minerals:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTextFieldTableViewCell
            let nutrientId = NutrientId.minerals[indexPath.row]
            cell.update(
                title: nutrientId.description,
                unit: nutrientId.unitName,
                value: foodEntry.foodInfo?.nutrients[nutrientId]?.value,
                placeholder: nutrientId.isRequired ? "Required" : "Optional") { valueText in
                    guard let valueText, let value = Double(valueText) else {
                        self.foodEntry.foodInfo?.nutrients[nutrientId]?.value = nil
                        return
                    }
                    
                    self.foodEntry.foodInfo?.nutrients[nutrientId]?.value = value
                }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func extractAmountAndUnit(from string: String) -> (amount: Double?, unit: String?) {
        let scanner = Scanner(string: string)
        var number: Double = 0.0

        let foundNumber = scanner.scanDouble(&number)
        let remaining = string[scanner.currentIndex...].trimmingCharacters(in: .whitespaces)
        
        let unit = remaining.isEmpty ? nil : remaining
        return (foundNumber ? number : nil, unit)
    }
}

/**
 name
 brandName
 servingSize "1 serving"   (extract modifier)
 
 nutritions
 - calories (
 - carbs
 - proteins
 - fats
 
 additional
 */

