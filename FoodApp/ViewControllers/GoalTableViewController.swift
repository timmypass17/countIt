//
//  GoalTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/24/24.
//

import UIKit

class GoalTableViewController: UITableViewController {
    
    var nutrientGoals: [NutrientID: Float]
    
    enum Section: CaseIterable {
        static var allCases: [GoalTableViewController.Section] =
            [.nutrients(NutrientID.mainNutrients), .vitamins(NutrientID.vitamins), .minerals(NutrientID.minerals) ]
        
        case nutrients([NutrientID]), vitamins([NutrientID]), minerals([NutrientID])
    }
    
    init(nutrientGoals: [NutrientID : Float]) {
        self.nutrientGoals = nutrientGoals
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(GoalTableViewCell.self, forCellReuseIdentifier: GoalTableViewCell.reuseIdentifier)
        title = "My Goals"
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
        let nutrientID: NutrientID
        switch section {
        case .nutrients(let nutrients):
            nutrientID = nutrients[indexPath.row]
        case .vitamins(let vitamins):
            nutrientID = vitamins[indexPath.row]
        case .minerals(let minerals):
            nutrientID = minerals[indexPath.row]
        }
        
        let nutrientGoal = Int(nutrientGoals[nutrientID] ?? 0)
        cell.update(primaryText: nutrientID.description, secondaryText: "\(nutrientGoal) \(nutrientID.unit)")
        cell.accessoryType = .disclosureIndicator
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

}
