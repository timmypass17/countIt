//
//  FoodDetailTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/3/24.
//

import UIKit
import SwiftUI

protocol FoodDetailTableViewControllerDelegate: AnyObject {
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didDismiss: Bool)
}

class FoodDetailTableViewController: UITableViewController {

    var food: Food
    var selectedFoodPortion: FoodPortion
    var numberOfServings = 1
    let foodService = FoodService()
    weak var delegate: FoodDetailTableViewControllerDelegate?
    var mainNutrients: [FoodNutrient] = []
    var vitamins: [FoodNutrient] = []
    var minerals: [FoodNutrient] = []

    let servingSizeIndexPath = IndexPath(row: 0, section: 0)
    let quantityIndexPath = IndexPath(row: 1, section: 0)

    enum Section: Int, CaseIterable {
        case servingSize   // servingSize, number of servings
        case macros         // protein, carbs, fats
        case nutrients  // TODO: Maybe split into nutrients, minerals, vitamins..
        case vitamins
        case minerals
        // TODO: all nutrition, minerals, vitamins..
    }

    init(food: Food) {
        self.food = food
        self.selectedFoodPortion = food.foodPortions[(food.foodPortions.count - 1) / 2]
        for nutrientID in NutrientID.mainNutrients {
            let emptyNutrient = FoodNutrient(nutrient: Nutrient(id: nutrientID, name: nutrientID.description, unitName: nutrientID.unit), amount: 0)
            let foodNutrient = food.getNutrient(nutrientID) ?? emptyNutrient
            mainNutrients.append(foodNutrient)
        }
        for nutrientID in NutrientID.vitamins {
            let emptyNutrient = FoodNutrient(nutrient: Nutrient(id: nutrientID, name: nutrientID.description, unitName: nutrientID.unit), amount: 0)
            let foodNutrient = food.getNutrient(nutrientID) ?? emptyNutrient
            vitamins.append(foodNutrient)
        }
        for nutrientID in NutrientID.minerals {
            let emptyNutrient = FoodNutrient(nutrient: Nutrient(id: nutrientID, name: nutrientID.description, unitName: nutrientID.unit), amount: 0)
            let foodNutrient = food.getNutrient(nutrientID) ?? emptyNutrient
            minerals.append(foodNutrient)
        }
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = food.description
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelButtonTapped())
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", primaryAction: addButtonTapped())
        tableView.register(SelectTableViewCell.self, forCellReuseIdentifier: SelectTableViewCell.reuseIdentifier)
        tableView.register(NutritionTableViewCell.self, forCellReuseIdentifier: NutritionTableViewCell.reuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MacrosView.reuseIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .servingSize:
            return 2
        case .macros:
            return 1
        case .nutrients:
            return mainNutrients.count
        case .vitamins:
            return vitamins.count
        case .minerals:
            return minerals.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .servingSize:
            if indexPath == servingSizeIndexPath {
                let cell = tableView.dequeueReusableCell(withIdentifier: SelectTableViewCell.reuseIdentifier, for: indexPath) as! SelectTableViewCell
                cell.update(
                    primaryText: "Serving Size",
                    secondaryText: selectedFoodPortion.getServingSizeFormatted(),
                    image: UIImage(systemName: "square.and.pencil"),
                    bgColor: UIColor.systemBlue)
                return cell
            } else if indexPath == quantityIndexPath {
                let cell = tableView.dequeueReusableCell(withIdentifier: SelectTableViewCell.reuseIdentifier, for: indexPath) as! SelectTableViewCell
                cell.update(
                    primaryText: "Number of Servings",
                    secondaryText: "\(numberOfServings)",
                    image: UIImage(systemName: "number"),
                    bgColor: UIColor.systemBlue)
                return cell
            }
            
            return UITableViewCell()
        case .macros:
            let cell = tableView.dequeueReusableCell(withIdentifier: MacrosView.reuseIdentifier, for: indexPath)
            let calories = calculateNutrientPerServing(
                nutrientPer100g: food.getNutrient(.calories)?.amount ?? 0.0,
                servingSizeGramWeight: selectedFoodPortion.gramWeight) * Float(numberOfServings)
            let carbs = calculateNutrientPerServing(
                nutrientPer100g: food.getNutrient(.carbs)?.amount ?? 0.0,
                servingSizeGramWeight: selectedFoodPortion.gramWeight) * Float(numberOfServings)
            let protein = calculateNutrientPerServing(
                nutrientPer100g: food.getNutrient(.protein)?.amount ?? 0.0,
                servingSizeGramWeight: selectedFoodPortion.gramWeight) * Float(numberOfServings)
            let fats = calculateNutrientPerServing(
                nutrientPer100g: food.getNutrient(.totalFat)?.amount ?? 0.0,
                servingSizeGramWeight: selectedFoodPortion.gramWeight) * Float(numberOfServings)
            
            cell.contentConfiguration = UIHostingConfiguration {
                MacrosView(
                    calories: (calories, Settings.shared.userDailyValues.calories),
                    carbs: (carbs, Settings.shared.userDailyValues.carbs),
                    protein: (protein, Settings.shared.userDailyValues.protein),
                    fats: (fats, Settings.shared.userDailyValues.fat)
                )
            }
            
            return cell
        case .nutrients:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTableViewCell
            let nutrient = mainNutrients[indexPath.row]
            cell.update(with: nutrient, foodPortion: selectedFoodPortion, quantity: numberOfServings)
            cell.progressView.tintColor = .systemIndigo
            return cell
        case .vitamins:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTableViewCell
            let vitamin = vitamins[indexPath.row]
            cell.update(with: vitamin, foodPortion: selectedFoodPortion, quantity: numberOfServings)
            cell.progressView.tintColor = .orange
            return cell
        case .minerals:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTableViewCell
            let mineral = minerals[indexPath.row]
            cell.update(with: mineral, foodPortion: selectedFoodPortion, quantity: numberOfServings)
            cell.progressView.tintColor = .white
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return nil }
        switch section {
        case .servingSize:
            return "Serving Size"
        case .macros:
            return "Macros"
        case .nutrients:
            return "Nutrition"
        case .vitamins:
            return "Vitamins"
        case .minerals:
            return "Minerals"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if navigationController?.isBeingDismissed ?? isBeingDismissed {
            delegate?.foodDetailTableViewController(self, didDismiss: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == servingSizeIndexPath {
            let selectTableViewController = ServingSizeTableViewController(foodPortions: food.foodPortions, selectedFoodPortion: selectedFoodPortion)
            selectTableViewController.delegate = self
            present(UINavigationController(rootViewController: selectTableViewController), animated: true)
        } else if indexPath == quantityIndexPath {
            let quantityTableViewController = QuantityViewController()
            quantityTableViewController.delegate = self
            let vc = UINavigationController(rootViewController: quantityTableViewController)
            vc.sheetPresentationController?.detents = [.medium(), .large()]
            present(vc, animated: true)
        }
    }
    
    func addButtonTapped() -> UIAction {
        return UIAction { [self] _ in
            // TODO: Add to user's meal plan
            dismiss(animated: true)
        }
    }
    
    func cancelButtonTapped() -> UIAction {
        return UIAction { [self] _ in
            dismiss(animated: true)
        }
    }
}

extension FoodDetailTableViewController: SelectTableViewControllerDelegate {
    func selectTableViewController(_ sender: ServingSizeTableViewController, didSelectPortion foodPortion: FoodPortion) {
        selectedFoodPortion = foodPortion
        tableView.reloadData()
    }
}

extension FoodDetailTableViewController: QuantityTableViewControllerDelegate {
    func quantityTableViewController(_ sender: QuantityViewController, didSelectQuantity quantity: Int) {
        numberOfServings = quantity
        tableView.reloadData()
    }
}
