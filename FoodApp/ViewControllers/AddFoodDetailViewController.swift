//
//  AddFoodDetailViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/4/25.
//

import UIKit

protocol AddFoodDetailViewControllerDelegate: AnyObject {
    func addFoodDetailViewController(_ tableViewController: AddFoodDetailViewController, didAddFood food: FoodEntry)
}

class AddFoodDetailViewController: FoodDetailTableViewController {

    weak var delegate: AddFoodDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            guard let meal else { return }
            do {
                let food = try foodService.addFood(fdcFood, with: selectedFoodPortion, quantity: numberOfServings, to: meal)
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
