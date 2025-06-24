//
//  UpdateFoodDetailViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/4/25.
//

import UIKit

protocol UpdateFoodDetailViewControllerDelegate: AnyObject {
    func updateFoodDetailViewController(_ viewController: UpdateFoodDetailViewController, didUpdateFood food: FoodEntry)
}

class UpdateFoodDetailViewController: FoodDetailTableViewController {

    weak var delegate: UpdateFoodDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .save, primaryAction: updateButtonTapped())
    }
    
    func updateButtonTapped() -> UIAction {
        return UIAction { [self] _ in
            guard let foodEntry else { return }
            do {
                let updatedFood = try foodService.updateFood(foodEntry, foodPortion: fdcFood.selectedFoodPortion, quantity: fdcFood.quantity)
                delegate?.updateFoodDetailViewController(self, didUpdateFood: updatedFood)
                NotificationCenter.default.post(name: .reloadDiary, object: nil)    // propogate changes from ingredient change

            } catch {
                print("Error updating food: \(error)")
            }
            dismiss(animated: true)


//            if let foodEntry {
//                let updatedFoodEntry = CoreDataStack.shared.updateFoodEntry(
//                    foodEntry: foodEntry,
//                    servingSize: selectedFoodPortion,
//                    numberOfServings: numberOfServings
//                )
//                delegate?.foodDetailTableViewController(self, didUpdateFoodEntry: updatedFoodEntry)
//
//                if let food = foodEntry.food {
//                    food.updatedAt = .now
//                    historyDelegate?.foodDetailTableViewController(self, didUpdateHistoryWithFood: food)
//                }
//            }
//            let generator = UIImpactFeedbackGenerator(style: .medium)
//            generator.impactOccurred()
//            dismiss(animated: true)
        }
    }
    

}
