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
        let childContext = CoreDataStack.shared.childContext(parentContext: recipeEntry.managedObjectContext)
        let recipeEntryInChildContext = childContext.object(with: recipeEntry.objectID) as! FoodEntry
        self.recipeEntry = recipeEntryInChildContext
        super.init(childContext: childContext)
        foodEntry.index = Int16(recipeEntryInChildContext.ingredients.count)
        foodEntry.parent = recipeEntryInChildContext
        recipeEntryInChildContext.addToIngredients_(foodEntry)
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
            let foodPortion = FoodInfoPortion(context: childContext)
            foodPortion.id = self.foodEntry.portionId
            foodPortion.gramWeight = self.foodEntry.gramWeight
            foodPortion.amount = self.foodEntry.amount
            foodPortion.modifier = self.foodEntry.modifier
            foodPortion.foodInfo = self.foodEntry.foodInfo
                        
            if let fdcFood = self.foodEntry.convertToFDCFood() {
                self.foodService.addHistoryIfNeeded(fdcFood: fdcFood, context: CoreDataStack.shared.context)
                CoreDataStack.shared.saveContext()
            }

            try childContext.save() // save to recipe
            addFoodDelegate?.addFoodDetailViewController(self, didAddFood: foodEntry)
            self.dismiss(animated: true)
        } catch {
            print("Error saving food entry")
        }
    }
    
}
