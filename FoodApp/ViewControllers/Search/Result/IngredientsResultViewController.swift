//
//  IngredientsResultViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/3/25.
//

import UIKit
import CoreData

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
    }
    
    override func resultTableViewCell(_ cell: ResultTableViewCell, didTapAddButton: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }

        do {
            guard let recipeContext: NSManagedObjectContext = recipeEntry.managedObjectContext else { return }
            let fdcFood = foodResponse.foods[indexPath.row]
            
            let ingredientEntry = try foodService.addFood(fdcFood, with: fdcFood.selectedFoodPortion, quantity: fdcFood.quantity , context: recipeContext)   // add to recipe box
            ingredientEntry.index = Int16(recipeEntry.ingredients.count)   // setting relationship does change size of relationship
            ingredientEntry.parent = recipeEntry
            recipeEntry.addToIngredients_(ingredientEntry)  // maybe unnecessarry
            
            // add to history in main
            foodService.addHistoryIfNeeded(fdcFood: fdcFood, context: CoreDataStack.shared.context)
            CoreDataStack.shared.saveContext() // save history
            
            self.addFoodDelegate?.addFoodDetailViewController(self, didAddFood: ingredientEntry)
        } catch {
            print("Error adding food: \(error)")
        }
    }
}

extension IngredientsResultViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if foodResponse.currentPage < foodResponse.totalPages && indexPath.row == foodResponse.foods.count {
            didTapLoadMoreButton()
            return
        }
                
        let foodItem = foodResponse.foods[indexPath.row]
        let addIngredientDetailViewController = AddIngredientDetailViewController(recipeEntry: recipeEntry, foodEntry: nil, fdcFood: foodItem, userProfile: userProfile, foodService: foodService)
        addIngredientDetailViewController.addFoodDelegate = addFoodDelegate
        addIngredientDetailViewController.dismissDelegate = self

        present(UINavigationController(rootViewController: addIngredientDetailViewController), animated: true)
    }
}
