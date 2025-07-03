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
        
        resultsTableController = IngredientsResultViewController(recipeEntry: recipeEntry, userProfile: userProfile, foodService: foodService)
        resultsTableController.addFoodDelegate = addFoodDelegate
        resultsTableController.resultDelegate = resultDelegate
        
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.placeholder = "Search ingredients"
        
        navigationItem.searchController = searchController
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
