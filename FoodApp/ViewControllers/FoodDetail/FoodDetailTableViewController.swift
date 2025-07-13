//
//  FoodDetailTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/3/24.
//

import UIKit
import SwiftUI

protocol ViewControllerDismissDelegate: AnyObject {
    func viewControllerDidDismiss(_ viewController: UIViewController)
}

protocol FoodDetailTableViewControllerHistoryDelegate: AnyObject {
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didUpdateHistoryWithFood food: FoodEntry)
}

// TODO: Make title have badge icon
class FoodDetailTableViewController: UITableViewController {

    var fdcFood: FoodItem
    var foodEntry: FoodEntry?
    var fdcFoodAdditional: FoodItem?
    let meal: Meal?
    let userProfile: UserProfile
    let foodService: FoodService

    weak var historyDelegate: FoodDetailTableViewControllerHistoryDelegate?
    weak var dismissDelegate: ViewControllerDismissDelegate?
    var macronutrients: [FoodNutrient] = []
    var vitamins: [FoodNutrient] = []
    var minerals: [FoodNutrient] = []

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
    
    var visibleSections: [Section] {
        var sections: [Section] = Section.allCases
        if fdcFood.ingredients.isEmpty {
            sections = sections.filter { $0 != .ingredients }
        }
        return sections
    }

    init(foodEntry: FoodEntry? = nil,
         fdcFood: FoodItem,
         meal: Meal? = nil, // to populate goals via meal.mealPlan.nutrientGoals.. (addFood
         userProfile: UserProfile,
         foodService: FoodService
    ) {
        self.foodEntry = foodEntry
        self.fdcFood = fdcFood
        self.meal = meal
        self.userProfile = userProfile
        self.foodService = foodService
        
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

        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = Settings.shared.currentTheme.background.uiColor
        navigationItem.title = fdcFood.description
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelButtonTapped())
        tableView.register(SelectTableViewCell.self, forCellReuseIdentifier: SelectTableViewCell.reuseIdentifier)
        tableView.register(NutritionTableViewCell.self, forCellReuseIdentifier: NutritionTableViewCell.reuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MacrosView.reuseIdentifier)
        tableView.register(FoodEntryTableViewCell.self, forCellReuseIdentifier: FoodEntryTableViewCell.reuseIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return visibleSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch visibleSections[section] {
        case .servingSize:
            return 2
        case .charts:
            return 1
        case .macros:
            return macronutrients.count
        case .ingredients:
            return fdcFood.ingredients.count
        case .vitamins:
            return vitamins.count
        case .minerals:
            return minerals.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch visibleSections[indexPath.section] {
        case .servingSize:
            if indexPath == servingSizeIndexPath {
                let cell = tableView.dequeueReusableCell(withIdentifier: SelectTableViewCell.reuseIdentifier, for: indexPath) as! SelectTableViewCell
                cell.update(
                    primaryText: "Serving Size",
                    secondaryText: fdcFood.getServingSizeFormatted(foodPortion: fdcFood.selectedFoodPortion),
                    image: UIImage(systemName: "square.and.pencil"),
                    bgColor: UIColor.systemBlue)
                return cell
            } else if indexPath == quantityIndexPath {
                let cell = tableView.dequeueReusableCell(withIdentifier: SelectTableViewCell.reuseIdentifier, for: indexPath) as! SelectTableViewCell
                cell.update(
                    primaryText: "Number of Servings",
                    secondaryText: "\(fdcFood.quantity)",
                    image: UIImage(systemName: "number"),
                    bgColor: UIColor.systemBlue)
                return cell
            }
            
            return UITableViewCell()
        case .charts:
            let cell = tableView.dequeueReusableCell(withIdentifier: MacrosView.reuseIdentifier, for: indexPath)
            let calories = fdcFood.getNutrientAmount(.calories, quantity: fdcFood.quantity)
            let carbs = fdcFood.getNutrientAmount(.carbs, quantity: fdcFood.quantity)
            let protein = fdcFood.getNutrientAmount(.protein, quantity: fdcFood.quantity)
            let fats = fdcFood.getNutrientAmount(.fatTotal, quantity: fdcFood.quantity)
            let nutrients: [NutrientId: Double] = [
                .calories: calories,
                .carbs: carbs,
                .protein: protein,
                .fatTotal: fats
            ]

            cell.contentConfiguration = UIHostingConfiguration {    // tableView.reloadData() or use swiftui state mangement
                MacrosView(mealPlan: meal?.mealPlan, userProfile: userProfile, nutrients: nutrients)
            }
            cell.backgroundColor = Settings.shared.currentTheme.cellBackground.uiColor
            cell.selectionStyle = .none
            return cell
        case .ingredients:
            guard let foodEntry else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: FoodEntryTableViewCell.reuseIdentifier, for: indexPath) as! FoodEntryTableViewCell
            let ingredientEntry = foodEntry.ingredients[indexPath.row]
            cell.update(ingredientEntry)
            cell.accessoryType = .disclosureIndicator
            return cell
        case .macros:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTableViewCell
            let nutrient = macronutrients[indexPath.row]
            let goal: Double
            if let meal {
                // Use meal's goal
                goal = meal.mealPlan?.nutrientGoals[nutrient.nutrientId]?.value ?? 0
            } else {
                // Fallback on user's goal
                goal = userProfile.userNutrientGoals[nutrient.nutrientId]?.value ?? 0
            }
            cell.update(
                nutrientId: nutrient.nutrientId!,
                amount: fdcFood.getNutrientAmount(nutrient.nutrientId!, quantity: fdcFood.quantity),
                goal: goal
            )
            cell.progressView.tintColor = .systemBlue
            cell.selectionStyle = .none
            return cell
        case .vitamins:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTableViewCell
            let vitamin = vitamins[indexPath.row]
            let goal: Double
            if let meal {
                // Use meal's goal
                goal = meal.mealPlan?.nutrientGoals[vitamin.nutrientId]?.value ?? 0
            } else {
                // Fallback on user's goal
                goal = userProfile.userNutrientGoals[vitamin.nutrientId]?.value ?? 0
            }
            cell.update(
                nutrientId: vitamin.nutrientId!,
                amount: fdcFood.getNutrientAmount(vitamin.nutrientId!, quantity: fdcFood.quantity),
                goal: goal
            )
            cell.progressView.tintColor = .systemOrange
            cell.selectionStyle = .none
            return cell
        case .minerals:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTableViewCell
            let mineral = minerals[indexPath.row]
            let goal: Double
            if let meal {
                // Use meal's goal
                goal = meal.mealPlan?.nutrientGoals[mineral.nutrientId]?.value ?? 0
            } else {
                // Fallback on user's goal
                goal = userProfile.userNutrientGoals[mineral.nutrientId]?.value ?? 0
            }
            cell.update(
                nutrientId: mineral.nutrientId!,
                amount: fdcFood.getNutrientAmount(mineral.nutrientId!, quantity: fdcFood.quantity),
                goal: goal
            )
            cell.progressView.tintColor = .white
            cell.selectionStyle = .none
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch visibleSections[section] {
        case .servingSize:
            return "Serving Size"
        case .charts:
            return "Macros"
        case .ingredients:
            return "Ingredients"
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
            dismissDelegate?.viewControllerDidDismiss(self)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch visibleSections[indexPath.section] {
        case .servingSize:
            if indexPath.row == 0 {
                let selectTableViewController = ServingSizeTableViewController(fdcFood: fdcFood, foodPortions: fdcFood.foodPortions, selectedFoodPortion: fdcFood.selectedFoodPortion)
                selectTableViewController.delegate = self
                present(UINavigationController(rootViewController: selectTableViewController), animated: true)
            } else if indexPath.row == 1 {
                let quantityTableViewController = QuantityViewController(selectedQuantity: fdcFood.quantity)
                quantityTableViewController.delegate = self
                let vc = UINavigationController(rootViewController: quantityTableViewController)
                vc.sheetPresentationController?.detents = [.medium(), .large()]
                present(vc, animated: true)
            }
        case .charts:
            break
        case .ingredients:
            guard let foodEntry else { return  }
            let ingredientEntry = foodEntry.ingredients[indexPath.row]
            guard let fdcIngredient = ingredientEntry.convertToFDCFood() else { return }
            let updateFoodDetailViewController = UpdateFoodDetailViewController(
                foodEntry: ingredientEntry,
                fdcFood: fdcIngredient,
                meal: meal,
                userProfile: userProfile,
                foodService: foodService
//                selectedFoodPortion: fdcIngredient.selectedFoodPortion,
//                numberOfServings: Int(ingredientEntry.quantity)
            )
            updateFoodDetailViewController.updateDelegate = self
            updateFoodDetailViewController.dismissDelegate = self
            present(UINavigationController(rootViewController: updateFoodDetailViewController), animated: true)
            
        case .macros:
            break
        case .vitamins:
            break
        case .minerals:
            break
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
        fdcFood.selectedFoodPortion = foodPortion
        tableView.reloadData()
    }
}

extension FoodDetailTableViewController: QuantityTableViewControllerDelegate {
    func quantityTableViewController(_ sender: QuantityViewController, didSelectQuantity quantity: Int) {
        fdcFood.quantity = quantity
        tableView.reloadData()
    }
}

extension FoodDetailTableViewController: UpdateFoodDetailViewControllerDelegate {
    func updateFoodDetailViewController(_ viewController: UpdateFoodDetailViewController, didUpdateFood food: FoodEntry) {
        // Update local fdcFood after updating ingredient FoodEntry
        guard let fdcFood = foodEntry?.convertToFDCFood() else { return }
        self.fdcFood = fdcFood
        tableView.reloadData()
        // Updates current food detail
        // TODO: Should also update diary
    }
}

extension FoodDetailTableViewController: ViewControllerDismissDelegate {
    func viewControllerDidDismiss(_ viewController: UIViewController) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
