//
//  AddIngredientViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/3/25.
//

import UIKit
import CoreData

class AddIngredientDetailViewController: FoodDetailTableViewController {
    let recipeEntry: FoodEntry

    weak var addFoodDelegate: AddFoodDetailViewControllerDelegate?
    
    init(recipeEntry: FoodEntry, foodEntry: FoodEntry?, fdcFood: FoodItem, userProfile: UserProfile, foodService: FoodService) {
        self.recipeEntry = recipeEntry
        super.init(foodEntry: foodEntry, fdcFood: fdcFood, meal: nil, userProfile: userProfile, foodService: foodService)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Ingredient", primaryAction: didTapAddButton())
    }
    

    func didTapAddButton() -> UIAction {
        return UIAction { [self] _ in
            do {
                guard let recipeContext: NSManagedObjectContext = recipeEntry.managedObjectContext else { return }
                
                let ingredientEntry = try foodService.addFood(fdcFood, foodEntry: foodEntry, with: fdcFood.selectedFoodPortion, quantity: fdcFood.quantity, to: nil, context: recipeContext)   // add to recipe box
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
            
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            dismiss(animated: true)
        }
    }
}
