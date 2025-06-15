//
//  ProfileViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/10/25.
//

import UIKit

class GoalsViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    enum Section: Int, CaseIterable {
        case goals, nutritionGoals
    }
    
    struct GoalModel {
        var title: String
        var description: String
    }
    
    var goalModels: [GoalModel] = [
        GoalModel(title: "Starting Weight", description: ""),
        GoalModel(title: "Current Weight", description: ""),
        GoalModel(title: "Goal Weight", description: ""),
        GoalModel(title: "Weekly Goal", description: ""),
        GoalModel(title: "Activity Level", description: ""),
    ]
    
    let userProfile: UserProfile
    let foodService = FoodService()
    
    init(userProfile: UserProfile) {
        self.userProfile = userProfile
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ProfileSelectableTableViewCell.self, forCellReuseIdentifier: ProfileSelectableTableViewCell.reuseIdentifier)
        tableView.register(DeleteAccountTableViewCell.self, forCellReuseIdentifier: DeleteAccountTableViewCell.reuseIdentifier)
        tableView.register(MenuPickerTableViewCell<ActivityLevel>.self, forCellReuseIdentifier: MenuPickerTableViewCell<ActivityLevel>.reuseIdentifier)
        tableView.register(MenuPickerTableViewCell<WeeklyWeightGoal>.self, forCellReuseIdentifier: MenuPickerTableViewCell<WeeklyWeightGoal>.reuseIdentifier)
        tableView.register(UnitPreferenceFooterView.self, forHeaderFooterViewReuseIdentifier: UnitPreferenceFooterView.reuseIdentifier)

        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        title = "Nutrition Goals"
        
        guard let startingUserWeight = foodService.getStartingUserWeight(),
              let currentUserWeight = foodService.getCurrentUserWeight()
        else { return }
        goalModels[0].description = "\(startingUserWeight.getWeight(userProfile.weightUnit).trimmed) \(userProfile.weightUnit.pluralSymbol)"
        goalModels[1].description = "\(currentUserWeight.getWeight(userProfile.weightUnit).trimmed) \(userProfile.weightUnit.pluralSymbol)"  // current weight
        goalModels[2].description = "\(userProfile.goalWeight?.trimmed ?? "") \(userProfile.weightUnit.pluralSymbol)"
        goalModels[3].description = userProfile.weeklyGoal.displayName(unit: userProfile.weightUnit)
        goalModels[4].description = userProfile.activityLevel.displayName
    }

}

extension GoalsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .goals:
            return goalModels.count
        case .nutritionGoals:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .goals:
            if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: MenuPickerTableViewCell<WeeklyWeightGoal>.reuseIdentifier, for: indexPath) as! MenuPickerTableViewCell<WeeklyWeightGoal>
                let options: [WeeklyWeightGoal]
                switch userProfile.weightGoal {
                case .loseWeight:
                    options = WeeklyWeightGoal.lossGoals
                case .gainWeight:
                    options = WeeklyWeightGoal.gainGoals
                case .maintainWeight:
                    options = WeeklyWeightGoal.maintainGoal
                }

                cell.update(title: "Weekly Goal", options: options, selected: userProfile.weeklyGoal) { weeklyGoal in
                    return weeklyGoal.displayName(unit: self.userProfile.weightUnit)
                } descriptionProvider: { weeklyGoal in
                    return weeklyGoal.description(unit: self.userProfile.weightUnit)
                } onSelect: { selectedWeeklyGoal in
                    self.userProfile.weeklyGoal = selectedWeeklyGoal
                }
                return cell
            }
            
            if indexPath.row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: MenuPickerTableViewCell<ActivityLevel>.reuseIdentifier, for: indexPath) as! MenuPickerTableViewCell<ActivityLevel>

                cell.update(title: "Activity Level", options: ActivityLevel.allCases, selected: userProfile.activityLevel) { activityLevel in
                    return activityLevel.displayName
                } descriptionProvider: { activityLevel in
                    return activityLevel.description
                } onSelect: { selectedActivityLevel in
                    self.userProfile.activityLevel = selectedActivityLevel
                }
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSelectableTableViewCell.reuseIdentifier, for: indexPath) as! ProfileSelectableTableViewCell
            let model = goalModels[indexPath.row]
            cell.update(title: model.title, description: model.description)
            cell.accessoryType = .disclosureIndicator
            return cell
        case .nutritionGoals:
            return UITableViewCell()
        }
    }
}

extension GoalsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        
        switch section {
        case .goals:
            if indexPath.row == 1 {
                // TODO: Add weight model to Core Data (e.g. Jun 12, 100 kg)
                // TODO: Remove current weight (Store user's weight, initialize first item from onboarding)
                // TODO: Add "Starting Weight" by fetching first weight user inputted
                let weightViewController = CurrentWeightEditViewController(currentWeight: 0, weightUnit: userProfile.weightUnit)
                present(UINavigationController(rootViewController: weightViewController), animated: true)
            }
        case .nutritionGoals:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let section = Section(rawValue: section), section == .goals else { return nil }

        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: UnitPreferenceFooterView.reuseIdentifier) as! UnitPreferenceFooterView
        footer.update(currentUnit: userProfile.weightUnit)
        footer.delegate = self
        return footer
    }
    
    func tableView(_ tv: UITableView, heightForFooterInSection sec: Int) -> CGFloat {
        return 42
    }
}

extension GoalsViewController: UnitPreferenceFooterViewDelegate {
    func unitPreferenceFooterView(_ footerView: UnitPreferenceFooterView, didUpdateUnitPreference weightUnit: WeightUnit) {
        userProfile.weightUnit = weightUnit
        tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
    }
}
