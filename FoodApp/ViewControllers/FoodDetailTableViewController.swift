//
//  FoodDetailTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/3/24.
//

import UIKit

protocol FoodDetailTableViewControllerDelegate: AnyObject {
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didDismiss: Bool)
}

class FoodDetailTableViewController: UITableViewController {

    var food: SearchResultFood
    let foodService = FoodService()
    weak var delegate: FoodDetailTableViewControllerDelegate?
    
    let selectedServingSizeIndexPath = IndexPath(row: 0, section: 0)
    
    enum Section: Int, CaseIterable {
        case servingSize   // servingSize, number of servings
        case macros         // protein, carbs, fats
        case dailyValue
        case nutrition
    }

    init(food: SearchResultFood) {
        self.food = food
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = food.description
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelButtonTapped())
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", primaryAction: addButtonTapped())
        tableView.register(NutritionTableViewCell.self, forCellReuseIdentifier: NutritionTableViewCell.reuseIdentifier)
        tableView.register(SelectTableViewCell.self, forCellReuseIdentifier: SelectTableViewCell.reuseIdentifier)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .servingSize:
            return 2
        case .macros:
            return 0    // 1
        case .dailyValue:
            return 0    // 1
        case .nutrition:
            return food.foodNutrients.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .servingSize:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectTableViewCell.reuseIdentifier, for: indexPath) as! SelectTableViewCell
            if indexPath.row == 0 {
                cell.update(
                    primaryText: "Serving Size",
                    secondaryText: "[Serving Size here]",
                    image: UIImage(systemName: "square.and.pencil"),
                    bgColor: UIColor.systemBlue)
            }
            return cell
        case .macros:
            return UITableViewCell()
        case .dailyValue:
            return UITableViewCell()
        case .nutrition:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionTableViewCell.reuseIdentifier, for: indexPath) as! NutritionTableViewCell
            let nutrient = food.foodNutrients[indexPath.row]
                cell.update(with: nutrient)
        
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return nil }
        switch section {
        case .servingSize:
            return "Serving Size"
        case .macros:
            return "Macros"
        case .dailyValue:
            return "Daily Values"
        case .nutrition:
            return "Nutrition Facts"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if navigationController?.isBeingDismissed ?? isBeingDismissed {
            delegate?.foodDetailTableViewController(self, didDismiss: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let selectTableViewController = SelectTableViewController(options: options)
                present(UINavigationController(rootViewController: selectTableViewController), animated: true)
            }
        }
    }
    
    func addButtonTapped() -> UIAction {
        return UIAction { [self] _ in
            // TODO: Add to user's meal plan
            dismiss(animated: true)
        }
    }
    
    func cancelButtonTapped() -> UIAction {
        return UIAction { [self] _ in
            dismiss(animated: true)
        }
    }
}
