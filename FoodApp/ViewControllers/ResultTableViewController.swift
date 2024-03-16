//
//  ResultTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/1/24.
//

import UIKit

//struct FoodItem {
//    var foodSearchResults: FoodSearchResults
//    var food: Food
//    
//    var caloriesPerServing: Int? {
//        guard let caloriesPer100g = foodSearchResults.caloriesPer100g else { return nil }
//        guard let servingSize = foodSearchResults.servingSize
//        else {
//            let otherServingSize = food.averageFoodPortionSize.gramWeight
//            return (caloriesPer100g * Int(otherServingSize)) / 100
//        }
//        
//        return (caloriesPer100g * Int(servingSize)) / 100
//    }
//}
//
//extension FoodItem {
//    func getCaloriesPerServingFormatted() -> String? {
//        guard let caloriesPerServing else { return nil }
//        return "\(caloriesPerServing) cal"
//    }
//}

class ResultsTableViewController: UITableViewController {
    
    var foods: [Food] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as! SearchTableViewCell
        let food = foods[indexPath.row]
        cell.update(with: food)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = foods[indexPath.row]
        let foodDetailTableViewController = FoodDetailTableViewController(food: food)
        foodDetailTableViewController.delegate = self
        present(UINavigationController(rootViewController: foodDetailTableViewController), animated: true)
    }
}

extension ResultsTableViewController: FoodDetailTableViewControllerDelegate {
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didDismiss: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
