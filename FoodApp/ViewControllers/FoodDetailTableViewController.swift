//
//  FoodDetailTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/3/24.
//

import UIKit
import SwiftUI

protocol FoodDetailTableViewControllerDismissDelegate: AnyObject {
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didDismiss: Bool)
}

protocol FoodDetailTableViewControllerHistoryDelegate: AnyObject {
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didUpdateHistoryWithFood food: Food)
}

class FoodDetailTableViewController: UITableViewController {

    var fdcFood: FoodItem
    var food: Food?
    var fdcFoodAdditional: FoodItem?
    let meal: Meal?
    var selectedFoodPortion: FoodPortion    // never optional (always have atleast 100g)
    var numberOfServings: Int
    let foodService: FoodService
    let state: State
    weak var dismissDelegate: FoodDetailTableViewControllerDismissDelegate?
    weak var historyDelegate: FoodDetailTableViewControllerHistoryDelegate?
    var macronutrients: [FoodNutrient] = []
    var vitamins: [FoodNutrient] = []
    var minerals: [FoodNutrient] = []

    let servingSizeIndexPath = IndexPath(row: 0, section: 0)
    let quantityIndexPath = IndexPath(row: 1, section: 0)

    enum Section: Int, CaseIterable {
        case servingSize
        case charts
        case macros
        case vitamins
        case minerals
    }
    
    enum State {
        case add, edit
    }
    
    init(food: Food? = nil, fdcFood: FoodItem, meal: Meal?, foodService: FoodService, selectedFoodPortion: FoodPortion? = nil, numberOfServings: Int = 1, state: State = .add) {
        self.food = food
        self.fdcFood = fdcFood
        self.meal = meal
        self.foodService = foodService
        self.numberOfServings = numberOfServings
        self.state = state
        if let selectedFoodPortion {
            self.selectedFoodPortion = selectedFoodPortion
        } else {
//            if let householdServingFullText = fdcFood.householdServingFullText,
//               let foodMeasure = fdcFood.foodMeasures.first(where: { $0.disseminationText == householdServingFullText }) {
//                self.selectedFoodPortion = foodMeasure
//            } else {
            self.selectedFoodPortion = fdcFood.foodPortions[(fdcFood.foodPortions.count - 1) / 2]

//            }
        }
        
        for nutrientId in NutrientId.macronutrients {
            let foodNutrient = fdcFood.foodNutrients[nutrientId] ?? FoodNutrient.empty(nutrientId)
            macronutrients.append(foodNutrient)
        }
        
        for nutrientId in NutrientId.vitamins {
            let foodNutrient = fdcFood.foodNutrients[nutrientId] ?? FoodNutrient.empty(nutrientId)
            vitamins.append(foodNutrient)
        }
        
        for nutrientId in NutrientId.minerals {
            let foodNutrient = fdcFood.foodNutrients[nutrientId] ?? FoodNutrient.empty(nutrientId)
            minerals.append(foodNutrient)
        }
        
        print("fdcId: \(fdcFood.fdcId)")
        for nutrient in fdcFood.foodNutrients {
            print("\(nutrient.description) \(nutrient.amount ?? 0)")
        }

        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(fdcFood.description) \(fdcFood.fdcId)"
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelButtonTapped())
        tableView.register(SelectTableViewCell.self, forCellReuseIdentifier: SelectTableViewCell.reuseIdentifier)
        tableView.register(NutritionTableViewCell.self, forCellReuseIdentifier: NutritionTableViewCell.reuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MacrosView.reuseIdentifier)
        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: IngredientTableViewCell.reuseIdentifier)
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
        case .charts:
            return 1
        case .macros:
            return macronutrients.count
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
                    secondaryText: fdcFood.getServingSizeFormatted(foodPortion: selectedFoodPortion),
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
        case .charts:
            let cell = tableView.dequeueReusableCell(withIdentifier: MacrosView.reuseIdentifier, for: indexPath)
            let calories = fdcFood.getNutrientAmount(.calories, using: selectedFoodPortion, quantity: numberOfServings)
            let carbs = fdcFood.getNutrientAmount(.carbs, using: selectedFoodPortion, quantity: numberOfServings)
            let protein = fdcFood.getNutrientAmount(.protein, using: selectedFoodPortion, quantity: numberOfServings)
            let fats = fdcFood.getNutrientAmount(.fatTotal, using: selectedFoodPortion, quantity: numberOfServings)
            let nutrients: [NutrientId: Double] = [
                .calories: calories,
                .carbs: carbs,
                .protein: protein,
                .fatTotal: fats
            ]

            cell.contentConfiguration = UIHostingConfiguration {    // tableView.reloadData() or use swiftui state mangement
                MacrosView(mealPlan: meal?.mealPlan, nutrients: nutrients)
            }
            cell.selectionStyle = .none
            return cell
        case .macros:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTableViewCell
            let nutrient = macronutrients[indexPath.row]
            let goal = meal?.mealPlan?.nutrientGoals[nutrient.nutrientId]?.value ?? 0
            cell.update(with: nutrient, foodPortion: selectedFoodPortion, quantity: numberOfServings, goal: goal)
            cell.progressView.tintColor = .systemBlue
            cell.selectionStyle = .none
            return cell
        case .vitamins:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTableViewCell
            let vitamin = vitamins[indexPath.row]
            let goal = meal?.mealPlan?.nutrientGoals[vitamin.nutrientId]?.value ?? 0
            cell.update(with: vitamin, foodPortion: selectedFoodPortion, quantity: numberOfServings, goal: goal)
            cell.progressView.tintColor = .systemOrange
            cell.selectionStyle = .none
            return cell
        case .minerals:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTableViewCell
            let mineral = minerals[indexPath.row]
            let goal = meal?.mealPlan?.nutrientGoals[mineral.nutrientId]?.value ?? 0
            cell.update(with: mineral, foodPortion: selectedFoodPortion, quantity: numberOfServings, goal: goal)
            cell.progressView.tintColor = .white
            cell.selectionStyle = .none
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return nil }
        switch section {
        case .servingSize:
            return "Serving Size"
        case .charts:
            return "Macros"
        case .macros:
            return "Nutrition"
        case .vitamins:
            return "Vitamins"
        case .minerals:
            return "Minerals"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if navigationController?.isBeingDismissed ?? isBeingDismissed {
            dismissDelegate?.foodDetailTableViewController(self, didDismiss: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == servingSizeIndexPath {
            let selectTableViewController = ServingSizeTableViewController(fdcFood: fdcFood, foodPortions: fdcFood.foodPortions, selectedFoodPortion: selectedFoodPortion)
            selectTableViewController.delegate = self
            present(UINavigationController(rootViewController: selectTableViewController), animated: true)
        } else if indexPath == quantityIndexPath {
            let quantityTableViewController = QuantityViewController(selectedQuantity: numberOfServings)
            quantityTableViewController.delegate = self
            let vc = UINavigationController(rootViewController: quantityTableViewController)
            vc.sheetPresentationController?.detents = [.medium(), .large()]
            present(vc, animated: true)
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
