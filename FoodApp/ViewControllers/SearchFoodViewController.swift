//
//  SearchFoodViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/2/25.
//

import UIKit

class SearchFoodViewController: SearchItemTableViewController {
    
    // Initally meal can mealplan not loaded yet
    var meal: Meal?
    
    init(
        meal: Meal?,
        foodService: FoodService,
        userProfile: UserProfile
    ) {
        self.meal = meal
        super.init(foodService: foodService, userProfile: userProfile, visibleTabs: [.all, .myRecipes, .myFoods], visibleButtonTypes: [.barcode, .quickAdd, .addRecipe, .addFood])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: Change result to foodResults and ingredientResults?
        let foodResultsViewController = FoodResultsViewController(meal: meal, foodService: foodService, userProfile: userProfile)
        foodResultsViewController.addFoodDelegate = addFoodDelegate
        resultsPaginatedViewController = foodResultsViewController
//        resultsPaginatedViewController.resultDelegate = resultDelegate
        
        searchController = UISearchController(searchResultsController: resultsPaginatedViewController)
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.placeholder = "Search food"
        
        navigationItem.searchController = searchController
        
        if let meal, let meals = meal.mealPlan?.meals {
            let titleView = SearchTitleView(selectedMeal: meal, meals: meals)
            titleView.delegate = self
            navigationItem.titleView = titleView
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchFoodViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let history = fetchedResultsController.object(at: indexPath)
        guard let foodEntry = history.foodEntry,
              var food = foodEntry.convertToFDCFood(),
              let selectedFoodPortion = food.foodPortions.first(where: { $0.id == foodEntry.portionId })
        else { return }
        
        food.selectedFoodPortion = selectedFoodPortion
        let addFoodDetailViewController = AddFoodDetailViewController(foodEntry: history.foodEntry, fdcFood: food, meal: meal, userProfile: userProfile, foodService: foodService)
        addFoodDetailViewController.delegate = addFoodDelegate
        addFoodDetailViewController.dismissDelegate = self
        present(UINavigationController(rootViewController: addFoodDetailViewController), animated: true)
    }
}

extension SearchFoodViewController: SearchTitleViewDelegate {
    func searchTitleView(_ sender: SearchTitleView, didSelectMeal meal: Meal) {
        self.meal = meal
    }
}

extension SearchFoodViewController: DiaryViewControllerDelegate {
    func diaryViewController(_ viewController: DiaryViewController, mealPlanChanged mealPlan: MealPlan) {
        guard let meal = mealPlan.meals.first else { return }
        self.meal = meal

        let titleView = SearchTitleView(selectedMeal: meal, meals: mealPlan.meals)
        titleView.delegate = self
        navigationItem.titleView = titleView
    }
    
}
