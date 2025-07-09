//
//  SearchIngredientViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/26/25.
//

import UIKit

class SearchIngredientViewController: SearchItemTableViewController {
        
    var recipeEntry: FoodEntry
    
    init(
        recipeEntry: FoodEntry,
        foodService: FoodService,
        userProfile: UserProfile
    ) {
        self.recipeEntry = recipeEntry
        super.init(foodService: foodService, userProfile: userProfile, visibleTabs: [.all, .myFoods], visibleButtonTypes: [.barcode, .quickAdd, .addFood])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Ingredient"
        
        resultsPaginatedViewController = IngredientsResultViewController(recipeEntry: recipeEntry, userProfile: userProfile, foodService: foodService)
        resultsPaginatedViewController.addFoodDelegate = addFoodDelegate
//        resultsPaginatedViewController.resultDelegate = resultDelegate
//        
        searchController = UISearchController(searchResultsController: resultsPaginatedViewController)
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.placeholder = "Search ingredients"
        
        navigationItem.searchController = searchController
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension SearchIngredientViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let history = fetchedResultsController.object(at: indexPath)
        guard let foodEntry = history.foodEntry,
              var food = foodEntry.convertToFDCFood(),
              let selectedFoodPortion = food.foodPortions.first(where: { $0.id == foodEntry.portionId })
        else { return }
        
        food.selectedFoodPortion = selectedFoodPortion
        let addIngredientDetailViewController = AddIngredientViewController(recipeEntry: recipeEntry, foodEntry: foodEntry, fdcFood: food, userProfile: userProfile, foodService: foodService)
        addIngredientDetailViewController.delegate = addFoodDelegate
        addIngredientDetailViewController.dismissDelegate = self
        present(UINavigationController(rootViewController: addIngredientDetailViewController), animated: true)
    }
}
