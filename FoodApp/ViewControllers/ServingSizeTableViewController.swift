//
//  SelectTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/5/24.
//

import UIKit

protocol SelectTableViewControllerDelegate: AnyObject {
    func selectTableViewController(_ sender: ServingSizeTableViewController, didSelectPortion foodPortion: FoodPortion)
}

class ServingSizeTableViewController: UITableViewController {
    let fdcFood: FoodItem
    let foodPortions: [FoodPortion]
    var selectedFoodPortion: FoodPortion
    
    weak var delegate: SelectTableViewControllerDelegate?
    let reuseIdentifier = "SelectCell"
    
    init(fdcFood: FoodItem, foodPortions: [FoodPortion], selectedFoodPortion: FoodPortion) {
        self.fdcFood = fdcFood
        self.foodPortions = foodPortions
        self.selectedFoodPortion =  selectedFoodPortion
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose a Size"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        let cancelButton = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelButtonTapped())
        let createButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), primaryAction: createButtonTapped())
        let doneButton = UIBarButtonItem(systemItem: .done, primaryAction: doneButtonTapped())
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItems = [doneButton, createButton]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodPortions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let foodPortion = foodPortions[indexPath.row]
        var config = cell.defaultContentConfiguration()
//        config.text = fdcFood.getServingSizeFormatted(foodPortion: foodPortion)
        cell.contentConfiguration = config
        cell.accessoryType = foodPortion == selectedFoodPortion ? .checkmark : .none

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousRow =  foodPortions.firstIndex(where: { $0 == selectedFoodPortion }) {
            let previousIndexPath = IndexPath(row: previousRow, section: 0)
            tableView.reloadRows(at: [previousIndexPath], with: .automatic)
            selectedFoodPortion = foodPortions[indexPath.row]
            tableView.reloadRows(at: [previousIndexPath, indexPath], with: .automatic)
            return
        }
        
        selectedFoodPortion = foodPortions[indexPath.row]
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Serving Size"
    }
    
    
    func doneButtonTapped() -> UIAction {
        return UIAction { [self] _ in
            delegate?.selectTableViewController(self, didSelectPortion: selectedFoodPortion)
            dismiss(animated: true)
        }
    }
    
    func cancelButtonTapped() -> UIAction {
        return UIAction { [self] _ in
            dismiss(animated: true)
        }
    }
    
    func createButtonTapped() -> UIAction {
        return UIAction { _ in
            self.showAlert()
        }
    }
    
    func showAlert() {
//        let servingSizeUnit = food.servingSizeUnit ?? "g"
        let servingSizeUnit = "g"
        let alert = UIAlertController(title: "Custom Serving Size", message: "Enter your own serving size (\(servingSizeUnit)) below", preferredStyle: .alert)

        alert.addTextField { textField in
//            textField.placeholder = "Ex. 100"
//            textField.keyboardType = .decimalPad
//            let textChangedAction = UIAction { _ in
//                alert.actions[1].isEnabled = textField.text!.count > 0 && textField.text!.isNumeric
//            }
//            textField.addAction(textChangedAction, for: .allEditingEvents)
        }
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            guard let gramString = alert.textFields?.first?.text,
                  let gramWeight = Float(gramString)
            else { return }
            let customServingSize = FoodPortion(gramWeight: gramWeight, modifier: "", sequenceNumber: 0, portionDescription: "", measureUnit: MeasureUnit(id: 0, name: "", abbreviation: ""))
            self.delegate?.selectTableViewController(self, didSelectPortion: customServingSize)
            self.navigationController?.dismiss(animated: true)
        }))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension String {
    var isNumeric: Bool {
        return Float(self) != nil
    }
}
