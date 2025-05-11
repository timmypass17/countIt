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

protocol FoodDetailTableViewControllerDelegate: AnyObject {
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didAddFoodEntry foodEntry: Food)
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didUpdateFoodEntry foodEntry: Food)
}

protocol FoodDetailTableViewControllerHistoryDelegate: AnyObject {
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didUpdateHistoryWithFood food: Food)
}

class FoodDetailTableViewController: UITableViewController {

    var fdcFood: SearchResultFood
    var foodEntry: Food?
    let meal: Meal?
    var selectedFoodPortion: SearchResultFoodMeasurement
    var numberOfServings: Int
    let foodService: FoodService
    let state: State
    weak var delegate: FoodDetailTableViewControllerDelegate?
    weak var dismissDelegate: FoodDetailTableViewControllerDismissDelegate?
    weak var historyDelegate: FoodDetailTableViewControllerHistoryDelegate?
    var macronutrients: [SearchResultFoodNutrient] = []
    var vitamins: [SearchResultFoodNutrient] = []
    var minerals: [SearchResultFoodNutrient] = []

    let servingSizeIndexPath = IndexPath(row: 0, section: 0)
    let quantityIndexPath = IndexPath(row: 1, section: 0)

    enum Section: Int, CaseIterable {
        case servingSize
        case charts
        case ingredients
        case macros
        case vitamins
        case minerals
    }
    
    enum State {
        case add, edit
    }

    init(fdcFood: SearchResultFood, meal: Meal?, foodService: FoodService, selectedFoodPortion: SearchResultFoodMeasurement? = nil, numberOfServings: Int = 1, state: State = .add) {
        self.fdcFood = fdcFood
        self.meal = meal
        self.foodService = foodService
        self.numberOfServings = numberOfServings
        self.state = state
        if let selectedFoodPortion {
            self.selectedFoodPortion = selectedFoodPortion
        } else {
            if let householdServingFullText = fdcFood.householdServingFullText,
               let foodMeasure = fdcFood.foodMeasures.first(where: { $0.disseminationText == householdServingFullText }) {
                self.selectedFoodPortion = foodMeasure
            } else {
                self.selectedFoodPortion = fdcFood.foodMeasures[(fdcFood.foodMeasures.count - 1) / 2]
            }
        }
        
        for (index, nutrientId) in NutrientId.macronutrients.enumerated() {
            var foodNutrient = fdcFood.foodNutrients[nutrientId] ?? SearchResultFoodNutrient.empty(nutrientId)
            macronutrients.append(foodNutrient)
        }
        
        for (index, nutrientId) in NutrientId.vitamins.enumerated() {
            var foodNutrient = fdcFood.foodNutrients[nutrientId] ?? SearchResultFoodNutrient.empty(nutrientId)
            vitamins.append(foodNutrient)
        }
        
        for (index, nutrientId) in NutrientId.minerals.enumerated() {
            var foodNutrient = fdcFood.foodNutrients[nutrientId] ?? SearchResultFoodNutrient.empty(nutrientId)
            minerals.append(foodNutrient)
        }

        super.init(style: .insetGrouped)
//        print("Timmy food")
//        print(fdcFood)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(fdcFood.description) \(fdcFood.fdcId)"
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelButtonTapped())
        switch state {
        case .add:
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", primaryAction: addButtonTapped())
        case .edit:
            navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .save, primaryAction: updateButtonTapped())
        }
        tableView.register(SelectTableViewCell.self, forCellReuseIdentifier: SelectTableViewCell.reuseIdentifier)
        tableView.register(NutritionTableViewCell.self, forCellReuseIdentifier: NutritionTableViewCell.reuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MacrosView.reuseIdentifier)
        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: IngredientTableViewCell.reuseIdentifier)
        
        print("Timmy banana")
//        print("ingredients: \(fdcFood.inputFoods.count)")
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
        case .ingredients:
            return 0
//            return fdcFood.inputFoods.count
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
                    secondaryText: selectedFoodPortion.servingSizeDescription,
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
        case .ingredients:
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientTableViewCell.reuseIdentifier, for: indexPath) as! IngredientTableViewCell
//            let ingredient = fdcFood.inputFoods[indexPath.row]
//            cell.update(ingredient: ingredient)
            return cell
        case .charts:
            let cell = tableView.dequeueReusableCell(withIdentifier: MacrosView.reuseIdentifier, for: indexPath)
//            let calories = fdcFood.getNutrientPerServing(.calories, foodPortion: selectedFoodPortion) * Float(numberOfServings)
//            let carbs = fdcFood.getNutrientPerServing(.carbs, foodPortion: selectedFoodPortion) * Float(numberOfServings)
//            let protein = fdcFood.getNutrientPerServing(.protein, foodPortion: selectedFoodPortion) * Float(numberOfServings)
//            let fats = fdcFood.getNutrientPerServing(.totalFat, foodPortion: selectedFoodPortion) * Float(numberOfServings)
//            cell.contentConfiguration = UIHostingConfiguration {
//                MacrosView(
//                    calories: MacroData(amount: calories, goal: Settings.shared.userDailyValues[.calories, default: 0.0]),
//                    carbs: MacroData(amount: carbs, goal: Settings.shared.userDailyValues[.carbs, default: 0.0]),
//                    protein: MacroData(amount: protein, goal: Settings.shared.userDailyValues[.protein, default: 0.0]),
//                    fats: MacroData(amount: fats, goal: Settings.shared.userDailyValues[.totalFat, default: 0.0])
//                )
//            }
//            cell.selectionStyle = .none
            return cell
        case .macros:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTableViewCell
            let nutrient = macronutrients[indexPath.row]
            cell.update(with: nutrient, foodPortion: selectedFoodPortion, quantity: numberOfServings)
            cell.progressView.tintColor = .systemBlue
            cell.selectionStyle = .none
            return cell
        case .vitamins:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTableViewCell
            let vitamin = vitamins[indexPath.row]
            cell.update(with: vitamin, foodPortion: selectedFoodPortion, quantity: numberOfServings)
            cell.progressView.tintColor = .systemOrange
            cell.selectionStyle = .none
            return cell
        case .minerals:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTableViewCell
            let mineral = minerals[indexPath.row]
            cell.update(with: mineral, foodPortion: selectedFoodPortion, quantity: numberOfServings)
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
        case .ingredients:
            return "Ingredients"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if navigationController?.isBeingDismissed ?? isBeingDismissed {
            dismissDelegate?.foodDetailTableViewController(self, didDismiss: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == servingSizeIndexPath {
            let selectTableViewController = ServingSizeTableViewController(fdcFood: fdcFood, foodPortions: fdcFood.foodMeasures, selectedFoodMeasurement: selectedFoodPortion)
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
    
    func addButtonTapped() -> UIAction {
        return UIAction { [self] _ in
            if let meal {
//                let foodEntry = CoreDataStack.shared.addFoodEntry(food, to: meal, servingSize: selectedFoodPortion, numberOfServings: numberOfServings, servingSizeUnit: food.servingSizeUnit ?? "g")
//                delegate?.foodDetailTableViewController(self, didAddFoodEntry: foodEntry)
//                
//                if let food = foodEntry.food {
//                    print(food)
//                    food.updatedAt = .now
//                    historyDelegate?.foodDetailTableViewController(self, didUpdateHistoryWithFood: food)
//                }
            }
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            dismiss(animated: true)
        }
    }
    
    func updateButtonTapped() -> UIAction {
        return UIAction { [self] _ in
//            if let foodEntry {
//                let updatedFoodEntry = CoreDataStack.shared.updateFoodEntry(
//                    foodEntry: foodEntry,
//                    servingSize: selectedFoodPortion,
//                    numberOfServings: numberOfServings
//                )
//                delegate?.foodDetailTableViewController(self, didUpdateFoodEntry: updatedFoodEntry)
//                
//                if let food = foodEntry.food {
//                    food.updatedAt = .now
//                    historyDelegate?.foodDetailTableViewController(self, didUpdateHistoryWithFood: food)
//                }
//            }
//            let generator = UIImpactFeedbackGenerator(style: .medium)
//            generator.impactOccurred()
//            dismiss(animated: true)
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
//        selectedFoodPortion = foodPortion
//        tableView.reloadData()
    }
}

extension FoodDetailTableViewController: QuantityTableViewControllerDelegate {
    func quantityTableViewController(_ sender: QuantityViewController, didSelectQuantity quantity: Int) {
        numberOfServings = quantity
        tableView.reloadData()
    }
}
