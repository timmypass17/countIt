//
//  HomeTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/16/24.
//

import UIKit
import SwiftUI

class HomeTableViewController: UITableViewController {
        
    let mealPlan: MealPlan
    let foodService: FoodService
    
    enum Section: Int, CaseIterable {
        case goal
        case meals
    }
    
    init(foodService: FoodService) {
        self.mealPlan = CoreDataStack.shared.getMealPlan(for: .now) ?? MealPlan.sample
        self.foodService = foodService
        mealPlan.printPrettyString()
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = HomeTitleView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MacrosView.reuseIdentifier)
        tableView.register(FoodEntryTableViewCell.self, forCellReuseIdentifier: FoodEntryTableViewCell.reuseIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + mealPlan.meals.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.mealPlan.meals[section - 1].foodEntries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MacrosView.reuseIdentifier, for: indexPath)
            let calories: Float = 0.0
            let carbs: Float = 0.0
            let protein: Float = 0.0
            let fats: Float = 0.0
            
            cell.contentConfiguration = UIHostingConfiguration {
                MacrosView(
                    calories: (calories, Settings.shared.userDailyValues.calories),
                    carbs: (carbs, Settings.shared.userDailyValues.carbs),
                    protein: (protein, Settings.shared.userDailyValues.protein),
                    fats: (fats, Settings.shared.userDailyValues.fat)
                )
            }
            return cell
        }
        
        let foodEntry = mealPlan.meals[indexPath.section - 1].foodEntries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodEntryTableViewCell.reuseIdentifier, for: indexPath) as! FoodEntryTableViewCell
        if let food = foodEntry.food {
            print("Has food")
            cell.update(with: food.convertToFDCFood())
        } else {
            print("No food")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Goals"
        }
        return mealPlan.meals[section - 1].name
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section != Section.goal.rawValue else { return nil }
        let cell = AddFoodButton(section: section)
        cell.update(title: "Add Food")
        cell.delegate = self
        return cell
    }
}

extension HomeTableViewController: AddFoodButtonDelegate {
    func addFoodButton(_ sender: AddFoodButton, didTapButton: Bool, forSectionAt section: Int) {
        let meal = mealPlan.meals[section - 1]
        let searchFoodTableViewController = SearchFoodTableViewController(foodService: foodService, meal: meal)
        searchFoodTableViewController.delegate = self
        let vc = UINavigationController(rootViewController: searchFoodTableViewController)
        searchFoodTableViewController.navigationItem.title = meal.name
        present(vc, animated: true)
    }

}

extension HomeTableViewController: FoodDetailTableViewControllerDelegate {
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didAddFoodEntry foodEntry: FoodEntry) {
        guard let mealIndex = foodEntry.meal?.index else { return }
        print(foodEntry.meal?.name)
        let index = Int(mealIndex)
        mealPlan.meals[index].foodEntries.append(foodEntry)   // local
        mealPlan.meals[index].addToFoodEntries_(foodEntry)    // core data
        print("Reloading section at : \(index + 1)")
        tableView.reloadSections(IndexSet(integer: index + 1), with: .automatic)
    }
}
