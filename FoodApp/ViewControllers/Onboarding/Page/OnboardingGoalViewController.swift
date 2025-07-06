//
//  OnboardingGoalViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/7/25.
//

import UIKit

protocol OnboardingGoalViewControllerDelegate: AnyObject {
    func onboardingGoalViewController(_ viewController: OnboardingGoalViewController, didUpdateCurrentWeightKg weightKg: Double?)
}

class OnboardingGoalViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Personalize Your Goals ✨"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "You can update these later in settings."
//        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    let titleContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .background
        return tableView
    }()
    
    let weightGoals = WeightGoal.allCases
    let userProfile: UserProfile
    var startingWeightKg: Double? = nil
    weak var delegate: OnboardingGoalViewControllerDelegate?
    
    enum Section: Int, CaseIterable {
        case goal, weightInput
    }
    
    init(userProfile: UserProfile) {
        self.userProfile = userProfile
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SelectableTableViewCell.self, forCellReuseIdentifier: SelectableTableViewCell.reuseIdentifier)
        tableView.register(WeightTextFieldTableViewCell.self, forCellReuseIdentifier: WeightTextFieldTableViewCell.reuseIdentifier)
        tableView.register(MenuPickerTableViewCell<WeeklyWeightGoal>.self, forCellReuseIdentifier: MenuPickerTableViewCell<WeeklyWeightGoal>.reuseIdentifier)
        tableView.register(UnitPreferenceFooterView.self, forHeaderFooterViewReuseIdentifier: UnitPreferenceFooterView.reuseIdentifier)
        
        view.backgroundColor = .background
        
        titleContainer.addArrangedSubview(titleLabel)
        titleContainer.addArrangedSubview(descriptionLabel)
        
        view.addSubview(titleContainer)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleContainer.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            titleContainer.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension OnboardingGoalViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .goal:
            return WeightGoal.allCases.count
        case .weightInput:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .goal:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectableTableViewCell.reuseIdentifier, for: indexPath) as! SelectableTableViewCell
            let weightGoal = weightGoals[indexPath.row]
            cell.update(title: weightGoal.description)
            cell.accessoryType = userProfile.weightGoal == weightGoal ? .checkmark : .none
            return cell
        case .weightInput:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: WeightTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! WeightTextFieldTableViewCell
                cell.update(title: "Current Weight", unit: userProfile.weightUnit, weightKg: startingWeightKg) { weightText in
                    guard let weightText, let weight = Double(weightText) else {
                        self.startingWeightKg = nil
                        self.delegate?.onboardingGoalViewController(self, didUpdateCurrentWeightKg: self.startingWeightKg)
                        NotificationCenter.default.post(name: .userInfoUpdated, object: nil)
                        return
                    }
                                        
                    switch self.userProfile.weightUnit {
                    case .pounds:
                        self.startingWeightKg = convertPoundsToKilograms(weight)
                    case .kilograms:
                        self.startingWeightKg = weight
                    }
                    self.delegate?.onboardingGoalViewController(self, didUpdateCurrentWeightKg: self.startingWeightKg)
                    
                    if let currentWeightKg = self.startingWeightKg,
                       let goalWeightKg = self.userProfile.goalWeightKg {
                        if currentWeightKg > goalWeightKg {
                            // Don't update weekly goal if user didn't change weightGoal
                            if self.userProfile.weightGoal != .loseWeight {
                                self.userProfile.weeklyGoal = .lose1_0
                            }
                            self.userProfile.weightGoal = .loseWeight
                        } else if currentWeightKg < goalWeightKg {
                            if self.userProfile.weightGoal != .gainWeight {
                                self.userProfile.weeklyGoal = .gain1_0
                            }
                            self.userProfile.weightGoal = .gainWeight
                        } else {
                            self.userProfile.weightGoal = .maintainWeight
                        }
                        
                        UIView.performWithoutAnimation {
                            tableView.reloadSections(IndexSet(integer: 0), with: .none)
                            tableView.reloadRows(at: [IndexPath(row: 2, section: 1)], with: .automatic)
                        }
                        
                    }
                    NotificationCenter.default.post(name: .userInfoUpdated, object: nil)
                }
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: WeightTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! WeightTextFieldTableViewCell
                cell.update(title: "Goal Weight", unit: userProfile.weightUnit, weightKg: userProfile.goalWeightKg) { weightText in
                    guard let weightText, let weight = Double(weightText) else {
                        self.userProfile.goalWeightKg = 0
                        NotificationCenter.default.post(name: .userInfoUpdated, object: nil)
                        return
                    }
                    
                    self.userProfile.setGoalWeight(weight: weight)
                    
                    if let currentWeightKg = self.startingWeightKg,
                       let goalWeightKg = self.userProfile.goalWeightKg {
                        if currentWeightKg > goalWeightKg {
                            // Don't update weekly goal if user didn't change weightGoal
                            if self.userProfile.weightGoal != .loseWeight {
                                self.userProfile.weeklyGoal = .lose1_0
                            }
                            self.userProfile.weightGoal = .loseWeight
                        } else if currentWeightKg < goalWeightKg {
                            if self.userProfile.weightGoal != .gainWeight {
                                self.userProfile.weeklyGoal = .gain1_0
                            }
                            self.userProfile.weightGoal = .gainWeight
                        } else {
                            self.userProfile.weightGoal = .maintainWeight
                        }
                        UIView.performWithoutAnimation {
                            tableView.reloadSections(IndexSet(integer: 0), with: .none)
                            tableView.reloadRows(at: [IndexPath(row: 2, section: 1)], with: .automatic)
                        }
                    }
                    
                    NotificationCenter.default.post(name: .userInfoUpdated, object: nil)
                }
                return cell
            } else if indexPath.row == 2 {
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
            } else {
                return UITableViewCell()
            }
        }
    }

}

extension OnboardingGoalViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let section = Section(rawValue: indexPath.section), section == .goal else { return }

        let newSelectedGoal = weightGoals[indexPath.row]
        
        if newSelectedGoal == userProfile.weightGoal {
            return
        }

        let previousIndex = weightGoals.firstIndex(of: userProfile.weightGoal)!
        let previousIndexPath = IndexPath(row: previousIndex, section: section.rawValue)
        
        userProfile.weightGoal = newSelectedGoal
        
        switch newSelectedGoal {
        case .loseWeight:
            userProfile.weeklyGoal = .lose1_0
        case .gainWeight:
            userProfile.weeklyGoal = .gain1_0
        case .maintainWeight:
            userProfile.weeklyGoal = .maintain
        }
        
        // Reload both old and new selections
        tableView.reloadRows(at: [previousIndexPath, indexPath], with: .automatic)
        
        tableView.reloadRows(at: [IndexPath(row: 2, section: 1)], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let section = Section(rawValue: indexPath.section), section == .goal else { return nil }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard Section(rawValue: section) == .weightInput else { return nil }
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: UnitPreferenceFooterView.reuseIdentifier) as! UnitPreferenceFooterView
        footer.update(currentUnit: userProfile.weightUnit)
        footer.delegate = self
        return footer
    }
    
    func tableView(_ tv: UITableView, heightForFooterInSection sec: Int) -> CGFloat {
        return 42
    }
}

extension OnboardingGoalViewController: UnitPreferenceFooterViewDelegate {
    func unitPreferenceFooterView(_ footerView: UnitPreferenceFooterView, didUpdateUnitPreference weightUnit: WeightUnit) {
        userProfile.weightUnit = weightUnit
        tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
    }
}
