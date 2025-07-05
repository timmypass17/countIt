//
//  FoodResultsViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/4/25.
//

import UIKit

class FoodResultsViewController: ResultsPaginatedViewController {

    let meal: Meal?
    
    init(meal: Meal?, foodService: FoodService, userProfile: UserProfile) {
        self.meal = meal
        super.init(foodService: foodService, userProfile: userProfile)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if foodResponse.currentPage < foodResponse.totalPages && indexPath.row == foodResponse.foods.count {
            didTapLoadMoreButton()
            return
        }

        let foodItem = foodResponse.foods[indexPath.row]
        let addFoodDetailViewController = AddFoodDetailViewController(foodEntry: nil, fdcFood: foodItem, meal: meal, userProfile: userProfile, foodService: foodService)
        addFoodDetailViewController.delegate = addFoodDelegate
        addFoodDetailViewController.dismissDelegate = self

        present(UINavigationController(rootViewController: addFoodDetailViewController), animated: true)
    }
    
}
