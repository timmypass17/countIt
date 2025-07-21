//
//  CreateFoodViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/10/25.
//

import UIKit

class CreateFoodViewController: CreateItemViewController {
    
    var meal: Meal
    
    weak var addFoodDelegate: AddFoodDetailViewControllerDelegate?
    

    init(meal: Meal) {
        let childContext = CoreDataStack.shared.childContext()
        let mealInChildContext = childContext.object(with: meal.objectID) as! Meal
        self.meal = mealInChildContext
        super.init(childContext: childContext)
        foodEntry.index = Int16(mealInChildContext.foodEntries.count)
        foodEntry.meal = mealInChildContext
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
                try childContext.save()
                CoreDataStack.shared.saveContext()
                addFoodDelegate?.addFoodDetailViewController(self, didAddFood: foodEntry)
            }
            self.dismiss(animated: true)
        } catch {
            print("Error saving food entry")
        }
    }
}
