//
//  QuickAddFoodViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/10/25.
//

import UIKit

class QuickAddFoodViewController: QuickAddItemViewController {
    
    var meal: Meal
    weak var addFoodDelegate: AddFoodDetailViewControllerDelegate?
    
    let childContext = CoreDataStack.shared.childContext()
    
    init(meal: Meal) {
        let mealInChildContext = childContext.object(with: meal.objectID) as! Meal
        self.meal = mealInChildContext
        super.init(context: childContext)
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
        let nutrients = foodEntry.foodInfo?.nutrients ?? []
        // fill in nil values
        for nutrient in nutrients {
            if nutrient.value == nil {
                nutrient.value = 0
            }
        }
        
        do {
            if let fdcFood = self.foodEntry.convertToFDCFood() {
                self.foodService.addHistoryIfNeeded(fdcFood: fdcFood, context: CoreDataStack.shared.context)
                try childContext.save()
                CoreDataStack.shared.saveContext()
                
                addFoodDelegate?.addFoodDetailViewController(self, didAddFood: foodEntry)
            }
            self.dismiss(animated: true)
        } catch {
            print("Error quick add: \(error)")
        }
    }

}
