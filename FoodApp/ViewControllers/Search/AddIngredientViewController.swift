//
//  AddIngredientViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/3/25.
//

import UIKit
import CoreData

class AddIngredientViewController: FoodDetailTableViewController {
    let recipeEntry: FoodEntry

    weak var delegate: AddFoodDetailViewControllerDelegate?
    
    init(recipeEntry: FoodEntry, foodEntry: FoodEntry?, fdcFood: FoodItem, userProfile: UserProfile, foodService: FoodService) {
        self.recipeEntry = recipeEntry
        super.init(foodEntry: foodEntry, fdcFood: fdcFood, meal: nil, userProfile: userProfile, foodService: foodService)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("timmy ingredients count: \(foodEntry?.ingredients.map { $0.foodInfo?.name ?? "" })")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Ingredient", primaryAction: didTapAddButton())
    }
    

    func didTapAddButton() -> UIAction {
        return UIAction { [self] _ in
            do {
                print("timmy tap add ingredient button")
                guard let recipeContext: NSManagedObjectContext = recipeEntry.managedObjectContext else { return }
                
                let ingredientEntry = try foodService.addFood(fdcFood, foodEntry: foodEntry, with: fdcFood.selectedFoodPortion, quantity: fdcFood.quantity, to: meal, context: recipeContext)   // add to recipe box
                
                // add to history in main
                foodService.addHistoryIfNeeded(fdcFood: fdcFood, context: CoreDataStack.shared.context)
                CoreDataStack.shared.saveContext()
                
                self.delegate?.addFoodDetailViewController(self, didAddFood: ingredientEntry)
            } catch {
                print("Error adding food: \(error)")
            }
            
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            dismiss(animated: true)
        }
    }
}
