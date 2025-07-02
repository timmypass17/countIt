//
//  AddFoodDetailViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/4/25.
//

import UIKit
import CoreData

protocol AddFoodDetailViewControllerDelegate: AnyObject {
    func addFoodDetailViewController(_ tableViewController: AddFoodDetailViewController, didAddFood food: FoodEntry)
}

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

    func didTapAddButton() -> UIAction {
        return UIAction { [self] _ in
            do {
                let foodContext: NSManagedObjectContext?
                if let foodEntry { // recipe
                    print("timmy using foodEntry's context: \(foodEntry.managedObjectContext)")
                    foodContext = foodEntry.managedObjectContext
                } else {
                    let childContext = CoreDataStack.shared.childContext()
                    print("timmy creating new context: \(childContext)")
                    foodContext = childContext
                }
                guard let foodContext else { return }
                let food = try foodService.addFood(fdcFood, foodEntry: foodEntry, with: fdcFood.selectedFoodPortion, quantity: fdcFood.quantity, to: meal, context: foodContext)
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
