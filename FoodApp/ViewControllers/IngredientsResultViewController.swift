//
//  IngredientsResultViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/3/25.
//

import UIKit

class IngredientsResultViewController: ResultsTableViewController {

    let recipeEntry: FoodEntry
    
    init(recipeEntry: FoodEntry, userProfile: UserProfile, foodService: FoodService) {
        self.recipeEntry = recipeEntry
        super.init(meal: nil, foodEntry: recipeEntry, userProfile: userProfile, foodService: foodService)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension IngredientsResultViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        let foodItem = searchResponse.foods[indexPath.row]
        let addFoodDetailViewController = AddIngredientViewController(recipeEntry: recipeEntry, fdcFood: foodItem, userProfile: userProfile, foodService: foodService)
        addFoodDetailViewController.delegate = addFoodDelegate
        addFoodDetailViewController.dismissDelegate = self
        addFoodDetailViewController.historyDelegate = historyDelegate

        present(UINavigationController(rootViewController: addFoodDetailViewController), animated: true)
    }
}
