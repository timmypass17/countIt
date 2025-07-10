//
//  QuickAddIngredientViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/10/25.
//

import UIKit

class QuickAddIngredientViewController: QuickAddItemViewController {

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
                CoreDataStack.shared.saveContext()
                addFoodDelegate?.addFoodDetailViewController(self, didAddFood: foodEntry)
            }
            self.dismiss(animated: true)
        } catch {
            print("Error quick add: \(error)")
        }
    }

}
