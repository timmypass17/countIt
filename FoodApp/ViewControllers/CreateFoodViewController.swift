//
//  AddFoodViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/16/25.
//

import UIKit
import CoreData

class CreateFoodViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = UIColor(hex: "#1c1c1e")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    enum Section: Int, CaseIterable {
        case name, macro, vitamins, minerals
    }
    
    lazy var foodEntry: FoodEntry = {
        var foodEntry = FoodEntry(context: childContext)
        foodEntry.quantity = 1
        foodEntry.gramWeight = 100
        foodEntry.amount = nil
        foodEntry.modifier = nil
        foodEntry.portionId = 0
        foodEntry.isCustom = true
        foodEntry.isRecipe = false
        
        let foodInfo = FoodInfo(context: childContext)
        foodInfo.fdcId = Int64.random(in: Int64.min..<0)
        foodInfo.brandName_ = nil
        foodEntry.foodInfo = foodInfo
        
        for nutrientId in NutrientId.allCases {
            let foodInfoNutrient = FoodInfoNutrient(context: childContext)
            foodInfoNutrient.nutrientId = nutrientId
            foodInfo.addToNutrients_(foodInfoNutrient)
        }
        
        let foodPortion = FoodInfoPortion(context: childContext)
        foodPortion.id = 0
        foodPortion.gramWeight = 100
        foodPortion.amount = nil
        foodPortion.modifier = nil
        foodPortion.foodInfo = foodInfo
        
        return foodEntry
    }()
    
    var childContext: NSManagedObjectContext = CoreDataStack.shared.childContext()
    
    
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", primaryAction: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", primaryAction: nil)
    }
}

extension CreateFoodViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .name:
            return 3
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
            let cell = tableView.dequeueReusableCell(withIdentifier: CreateFoodInfoTableViewCell.reuseIdentifier, for: indexPath) as! CreateFoodInfoTableViewCell
            if indexPath.row == 0 {
                cell.update(title: "Name", description: "Required*", placeholderText: "e.g. Peanut Butter")
            } else if indexPath.row == 1 {
                cell.update(title: "Brand Name", description: "Optional", placeholderText: "e.g. Skippy")
            } else if indexPath.row == 2 {
                cell.update(title: "Serving Size", description: "Required*", placeholderText: "e.g. 2 tbsp")
            }
            cell.backgroundColor = UIColor(hex: "#252525")
            return cell
        case .macro:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTextFieldTableViewCell
            let nutrientId = NutrientId.macronutrients[indexPath.row]
            print("\(nutrientId.description) \(foodEntry.foodInfo?.nutrients[nutrientId]?.value)")
            cell.update(nutrientId, value: foodEntry.foodInfo?.nutrients[nutrientId]?.value) { valueText in
                guard let valueText, let value = Double(valueText) else {
                    self.foodEntry.foodInfo?.nutrients[nutrientId]?.value = nil
                    return
                }
                
                self.foodEntry.foodInfo?.nutrients[nutrientId]?.value = value
            }
            cell.backgroundColor = UIColor(hex: "#252525")
            return cell
        case .vitamins:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTextFieldTableViewCell
            let nutrientId = NutrientId.vitamins[indexPath.row]
            print("\(nutrientId.description) \(foodEntry.foodInfo?.nutrients[nutrientId]?.value)")
            cell.update(nutrientId, value: foodEntry.foodInfo?.nutrients[nutrientId]?.value) { valueText in
                guard let valueText, let value = Double(valueText) else {
                    self.foodEntry.foodInfo?.nutrients[nutrientId]?.value = nil
                    return
                }
                
                self.foodEntry.foodInfo?.nutrients[nutrientId]?.value = value
            }
            cell.backgroundColor = UIColor(hex: "#252525")
            return cell
        case .minerals:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTextFieldTableViewCell
            let nutrientId = NutrientId.minerals[indexPath.row]
            print("\(nutrientId.description) \(foodEntry.foodInfo?.nutrients[nutrientId]?.value)")
            cell.update(nutrientId, value: foodEntry.foodInfo?.nutrients[nutrientId]?.value) { valueText in
                guard let valueText, let value = Double(valueText) else {
                    self.foodEntry.foodInfo?.nutrients[nutrientId]?.value = nil
                    return
                }
                
                self.foodEntry.foodInfo?.nutrients[nutrientId]?.value = value
            }
            cell.backgroundColor = UIColor(hex: "#252525")
            return cell
        }
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
