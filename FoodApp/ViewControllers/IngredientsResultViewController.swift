//
//  IngredientsResultViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/3/25.
//

import UIKit

class IngredientsResultViewController: ResultsPaginatedViewController {

    let recipeEntry: FoodEntry
    
    init(recipeEntry: FoodEntry, userProfile: UserProfile, foodService: FoodService) {
        self.recipeEntry = recipeEntry
        super.init(foodService: foodService, userProfile: userProfile)
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
        if foodResponse.currentPage < foodResponse.totalPages && indexPath.row == foodResponse.foods.count {
            didTapLoadMoreButton()
            return
        }
                
        let foodItem = foodResponse.foods[indexPath.row]
        let addIngredientDetailViewController = AddIngredientViewController(recipeEntry: recipeEntry, fdcFood: foodItem, userProfile: userProfile, foodService: foodService)
        addIngredientDetailViewController.delegate = addFoodDelegate
//        addIngredientDetailViewController.dismissDelegate = self
//        addIngredientDetailViewController.historyDelegate = historyDelegate

        present(UINavigationController(rootViewController: addIngredientDetailViewController), animated: true)
    }
}
