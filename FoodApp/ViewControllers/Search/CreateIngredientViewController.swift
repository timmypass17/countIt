//
//  CreateIngredientViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/10/25.
//

import UIKit

protocol CreateIngredientViewControllerDelegate: AnyObject {
    func createIngredientViewController(_ viewController: CreateIngredientViewController, didCreateIngredient ingredient: FoodEntry)
}

class CreateIngredientViewController: CreateItemViewController {
    
    let recipeEntry: FoodEntry
    
    weak var addFoodDelegate: AddFoodDetailViewControllerDelegate?
    
    init(recipeEntry: FoodEntry) {
        self.recipeEntry = recipeEntry
        super.init(context: recipeEntry.managedObjectContext!)
        foodEntry.index = Int16(recipeEntry.ingredients.count)
        foodEntry.parent = recipeEntry
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.action = #selector(didTapSaveButton)
    }
    
    @objc func didTapSaveButton() {
        do {
            // Remove grams, custom foods don't follow base 100g, they use their own
            let foodPortion = FoodInfoPortion(context: recipeEntry.managedObjectContext!)
            foodPortion.id = self.foodEntry.portionId
            foodPortion.gramWeight = self.foodEntry.gramWeight
            foodPortion.amount = self.foodEntry.amount
            foodPortion.modifier = self.foodEntry.modifier
            foodPortion.foodInfo = self.foodEntry.foodInfo
                        
            if let fdcFood = self.foodEntry.convertToFDCFood() {
                self.foodService.addHistoryIfNeeded(fdcFood: fdcFood, context: CoreDataStack.shared.context)
                CoreDataStack.shared.saveContext()
                addFoodDelegate?.addFoodDetailViewController(self, didAddFood: foodEntry)
            }

            self.dismiss(animated: true)
        } catch {
            print("Error saving food entry")
        }
    }
    
}
