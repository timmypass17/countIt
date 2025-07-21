//
//  GoalTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/24/24.
//

import UIKit

protocol EditGoalTableViewControllerDelegate: AnyObject {
    // Note: Dictionarys in Swift are passed by value (i.e. creates a copy)
    func editGoalTableViewController(_ viewController: EditGoalTableViewController, didUpdateNutrientGoals nutrientGoals: [NutrientId: Float])
}

class EditGoalTableViewController: UITableViewController {
    
    var nutrientGoals: [NutrientId: Float]
    weak var delegate: EditGoalTableViewControllerDelegate?
    
    enum Section: CaseIterable {
        static var allCases: [EditGoalTableViewController.Section] = []
//            [.nutrients(NutrientId.mainNutrients), .vitamins(NutrientId.vitamins), .minerals(NutrientId.minerals) ]
        
        case nutrients([NutrientId]), vitamins([NutrientId]), minerals([NutrientId])
    }
    
    init(nutrientGoals: [NutrientId : Float]) {
        self.nutrientGoals = nutrientGoals
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(GoalTableViewCell.self, forCellReuseIdentifier: GoalTableViewCell.reuseIdentifier)
        navigationItem.title = "Edit Goals"
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: didTapCancelButton())
        let infoButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), primaryAction: didTapInfoButton())
        let doneButton = UIBarButtonItem(systemItem: .save, primaryAction: didTapSaveButton())
        navigationItem.rightBarButtonItems = [doneButton, infoButton]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Section.allCases[section]
        switch section {
        case .nutrients(let nutrients):
            return nutrients.count
        case .vitamins(let vitamins):
            return vitamins.count
        case .minerals(let minerals):
            return minerals.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GoalTableViewCell.reuseIdentifier, for: indexPath) as! GoalTableViewCell
        let section = Section.allCases[indexPath.section]
        let nutrientID: NutrientId
        switch section {
        case .nutrients(let nutrients):
            nutrientID = nutrients[indexPath.row]
        case .vitamins(let vitamins):
            nutrientID = vitamins[indexPath.row]
        case .minerals(let minerals):
            nutrientID = minerals[indexPath.row]
        }
        
        let nutrientGoal = Int(nutrientGoals[nutrientID] ?? 0)
        cell.update(nutrientID: nutrientID, goal: nutrientGoal)
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = Section.allCases[section]
        switch section {
        case .nutrients(_):
            return "Nutrients"
        case .vitamins(_):
            return "Vitamins"
        case .minerals(_):
            return "Minerals"
        }
    }
    
    func didTapCancelButton() -> UIAction {
        return UIAction { _ in
            self.dismiss(animated: true)
        }
    }
    
    func didTapSaveButton() -> UIAction {
        return UIAction { [self] _ in
            delegate?.editGoalTableViewController(self, didUpdateNutrientGoals: nutrientGoals)
            dismiss(animated: true)
        }
    }
    
    func didTapInfoButton() -> UIAction {
        return UIAction { _ in
            let url = URL(string: "https://www.nal.usda.gov/human-nutrition-and-food-safety/dri-calculator")!
            UIApplication.shared.open(url)
        }
    }
}

extension EditGoalTableViewController: GoalTableViewCellDelegate {
    func goalTableViewCell(_ cell: GoalTableViewCell, amountValueChanged: String) {
        guard let nutrientID = cell.nutrientID else { return }
        
        if amountValueChanged == "" {
            navigationItem.rightBarButtonItem?.isEnabled = false
            return
        }
        
        nutrientGoals[nutrientID] = Float(amountValueChanged) ?? 0
        navigationItem.rightBarButtonItem?.isEnabled = true
        
    }
}
