//
//  AddFoodDetailViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/4/25.
//

import UIKit
import CoreData

protocol AddFoodDetailViewControllerDelegate: AnyObject {
    func addFoodDetailViewController(_ tableViewController: FoodDetailTableViewController, didAddFood food: FoodEntry)
}

// TODO: Make a AddIngredientDetailViewController: FoodDetailTableViewController with addIngredientDelegate
class AddFoodDetailViewController: FoodDetailTableViewController {
    
    weak var delegate: AddFoodDetailViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
//        print("timmy ingredients count: \(foodEntry?.ingredients.map { $0.foodInfo?.name ?? "" })")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", primaryAction: didTapAddButton())
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
                // Add to main directly
                let food = try foodService.addFood(fdcFood, foodEntry: foodEntry, with: fdcFood.selectedFoodPortion, quantity: fdcFood.quantity, to: meal, context: CoreDataStack.shared.context)
                foodService.addHistoryIfNeeded(fdcFood: fdcFood, context: CoreDataStack.shared.context)
//                try foodContext.save()
//                CoreDataStack.shared.saveContext()
                self.delegate?.addFoodDetailViewController(self, didAddFood: food)
            } catch {
                print("Error adding food: \(error)")
            }
            
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            dismiss(animated: true)
        }
    }
}
