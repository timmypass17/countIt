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
    init(recipeEntry: FoodEntry, fdcFood: FoodItem, userProfile: UserProfile, foodService: FoodService) {
        print("timmy: \(fdcFood.selectedFoodPortion)")
        self.recipeEntry = recipeEntry
        super.init(fdcFood: fdcFood, meal: nil, userProfile: userProfile, foodService: foodService)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("timmy ingredients count: \(foodEntry?.ingredients.map { $0.foodInfo?.name ?? "" })")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Ingredient", primaryAction: didTapAddButton())
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // TODO: This add button should do something
    func didTapAddButton() -> UIAction {
        return UIAction { [self] _ in
            do {
                guard let recipeContext: NSManagedObjectContext = recipeEntry.managedObjectContext else { return }
                
                let ingredientEntry = try foodService.addFood(fdcFood, foodEntry: foodEntry, with: fdcFood.selectedFoodPortion, quantity: fdcFood.quantity, to: meal, context: recipeContext)
                foodService.addHistoryIfNeeded(fdcFood: fdcFood, context: recipeContext)
//                try recipeContext.save()
//                CoreDataStack.shared.saveContext()
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
