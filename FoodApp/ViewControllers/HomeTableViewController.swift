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
    
    enum Section: Int, CaseIterable {
        case goal
        case meals
    }
    
    init() {
        self.mealPlan = CoreDataStack.shared.getMealPlan(for: .now) ?? MealPlan.sample
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
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .goal:
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
        case .meals:
//            let foodEntryCount = mealPlan.meals[indexPath.section].foodEntries.count
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Goals"
        }
        return mealPlan.meals[section - 1].name
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section != Section.goal.rawValue else { return nil }
        let cell = AddFoodButton()
        cell.update(title: "Add Food")
        return cell
    }
}
