//
//  OnboardingGoalViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/7/25.
//

import UIKit

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
        tableView.backgroundColor = .charcoal
        return tableView
    }()
    
    let weightGoals = WeightGoal.allCases
    let userInfo: UserInfo
    
    enum Section: Int, CaseIterable {
        case goal, weightInput
    }
    
    init(userInfo: UserInfo) {
        self.userInfo = userInfo
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
        tableView.register(WeightInputTableViewCell.self, forCellReuseIdentifier: WeightInputTableViewCell.reuseIdentifier)
        tableView.register(MenuPickerTableViewCell<WeeklyWeightGoal>.self, forCellReuseIdentifier: MenuPickerTableViewCell<WeeklyWeightGoal>.reuseIdentifier)
        tableView.register(UnitPreferenceFooterView.self, forHeaderFooterViewReuseIdentifier: UnitPreferenceFooterView.reuseIdentifier)
        
        view.backgroundColor = .charcoal
        
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
            cell.accessoryType = userInfo.weightGoal == weightGoal ? .checkmark : .none
            return cell
        case .weightInput:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: WeightInputTableViewCell.reuseIdentifier, for: indexPath) as! WeightInputTableViewCell
                cell.update(title: "Current Weight", unit: userInfo.unitPreference.weightUnit, weightKg: userInfo.currentWeightKg) { weightText in
                    guard let weight = Double(weightText) else {
                        self.userInfo.currentWeightKg = nil
                        NotificationCenter.default.post(name: .userInfoUpdated, object: nil)
                        return
                    }
                    
                    self.userInfo.setCurrentWeight(weight: weight)
                    
                    if let currentWeightKg = self.userInfo.currentWeightKg,
                       let goalWeightKg = self.userInfo.goalWeightKg {
                        if currentWeightKg > goalWeightKg {
                            // Don't update weekly goal if user didn't change weightGoal
                            if self.userInfo.weightGoal != .loseWeight {
                                self.userInfo.weeklyGoal = .lose1_0
                            }
                            self.userInfo.weightGoal = .loseWeight
                        } else if currentWeightKg < goalWeightKg {
                            if self.userInfo.weightGoal != .gainWeight {
                                self.userInfo.weeklyGoal = .gain1_0
                            }
                            self.userInfo.weightGoal = .gainWeight
                        } else {
                            self.userInfo.weightGoal = .maintainWeight
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
                let cell = tableView.dequeueReusableCell(withIdentifier: WeightInputTableViewCell.reuseIdentifier, for: indexPath) as! WeightInputTableViewCell
                cell.update(title: "Goal Weight", unit: userInfo.unitPreference.weightUnit, weightKg: userInfo.goalWeightKg) { weightText in
                    guard let weight = Double(weightText) else {
                        self.userInfo.goalWeightKg = nil
                        NotificationCenter.default.post(name: .userInfoUpdated, object: nil)
                        return
                    }
                    
                    self.userInfo.setGoalWeight(weight: weight)
                    
                    if let currentWeightKg = self.userInfo.currentWeightKg,
                       let goalWeightKg = self.userInfo.goalWeightKg {
                        if currentWeightKg > goalWeightKg {
                            // Don't update weekly goal if user didn't change weightGoal
                            if self.userInfo.weightGoal != .loseWeight {
                                self.userInfo.weeklyGoal = .lose1_0
                            }
                            self.userInfo.weightGoal = .loseWeight
                        } else if currentWeightKg < goalWeightKg {
                            if self.userInfo.weightGoal != .gainWeight {
                                self.userInfo.weeklyGoal = .gain1_0
                            }
                            self.userInfo.weightGoal = .gainWeight
                        } else {
                            self.userInfo.weightGoal = .maintainWeight
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
                switch userInfo.weightGoal {
                case .loseWeight:
                    options = WeeklyWeightGoal.lossGoals
                case .gainWeight:
                    options = WeeklyWeightGoal.gainGoals
                case .maintainWeight:
                    options = WeeklyWeightGoal.maintainGoal
                }

                cell.update(title: "Weekly Goal", options: options, selected: userInfo.weeklyGoal) { weeklyGoal in
                    return weeklyGoal.displayName(unit: self.userInfo.unitPreference.weightUnit)
                } descriptionProvider: { weeklyGoal in
                    return weeklyGoal.description(unit: self.userInfo.unitPreference.weightUnit)
                } onSelect: { selectedWeeklyGoal in
                    self.userInfo.weeklyGoal = selectedWeeklyGoal
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
        
        if newSelectedGoal == userInfo.weightGoal {
            return
        }

        let previousIndex = weightGoals.firstIndex(of: userInfo.weightGoal)!
        let previousIndexPath = IndexPath(row: previousIndex, section: section.rawValue)
        
        userInfo.weightGoal = newSelectedGoal
        
        switch newSelectedGoal {
        case .loseWeight:
            userInfo.weeklyGoal = .lose1_0
        case .gainWeight:
            userInfo.weeklyGoal = .gain1_0
        case .maintainWeight:
            userInfo.weeklyGoal = .maintain
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
        footer.update(currentUnit: userInfo.unitPreference.weightUnit)
        footer.delegate = self
        return footer
    }
    
    func tableView(_ tv: UITableView, heightForFooterInSection sec: Int) -> CGFloat {
        return 42
    }
}

extension OnboardingGoalViewController: UnitPreferenceFooterViewDelegate {
    func unitPreferenceFooterView(_ footerView: UnitPreferenceFooterView, didUpdateUnitPreference weightUnit: WeightUnit) {
        userInfo.unitPreference.weightUnit = weightUnit
        tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
    }
}

class UserInfo {
    var weightGoal: WeightGoal
    var currentWeightKg: Double?
    var goalWeightKg: Double?
    var weeklyGoal: WeeklyWeightGoal
    var activityLevel: ActivityLevel
    var unitPreference: UnitPreference
    var heightCm: Int?
    var dateOfBirth: Date
    var dailyCalories: Int
    var macroSplit: MacroSplit
    var sex: Gender?
    
    init(weightGoal: WeightGoal, currentWeight: Double?, goalWeight: Double?, weeklyGoal: WeeklyWeightGoal, unitPreference: UnitPreference, activityLevel: ActivityLevel, heightCm: Int?, dateOfBirth: Date, dailyCalories: Int, macroSplit: MacroSplit, sex: Gender?) {
        self.weightGoal = weightGoal
        self.currentWeightKg = currentWeight
        self.goalWeightKg = goalWeight
        self.weeklyGoal = weeklyGoal
        self.unitPreference = unitPreference
        self.activityLevel = activityLevel
        self.heightCm = heightCm
        self.dateOfBirth = dateOfBirth
        self.dailyCalories = dailyCalories
        self.macroSplit = macroSplit
        self.sex = sex
    }
    
    var heightInFeetAndInches: (feet: Int, inches: Int)? {
        guard let cm = heightCm else { return nil }
        let totalInches = Double(cm) / 2.54
        let feet = Int(totalInches / 12)
        let inches = Int(round(totalInches.truncatingRemainder(dividingBy: 12)))
        return (feet, inches)
    }
    
    func setHeight(feet: Int, inches: Int) {
        let totalInches = feet * 12 + inches
        let heightInCm = Double(totalInches) * 2.54
        self.heightCm = Int(round(heightInCm))
    }
    
    func setCurrentWeight(weight: Double) {
        switch unitPreference.weightUnit {
        case .pounds:
            currentWeightKg = convertPoundsToKilograms(weight)
        case .kilograms:
            currentWeightKg = weight
        }
    }
    
    func setGoalWeight(weight: Double) {
        switch unitPreference.weightUnit {
        case .pounds:
            goalWeightKg = convertPoundsToKilograms(weight)
        case .kilograms:
            goalWeightKg = weight
        }
    }
}

extension UserInfo: ReflectedStringConvertible { }

// https://medium.com/swift-programming/struct-style-printing-of-classes-in-swift-7ee34f1c975a
public protocol ReflectedStringConvertible : CustomStringConvertible { }

extension ReflectedStringConvertible {
    public var description: String {
        let mirror = Mirror(reflecting: self)
        
        var str = "\(mirror.subjectType)("
        var first = true
        for (label, value) in mirror.children {
            if let label = label {
                if first {
                    first = false
                } else {
                    str += ", "
                }
                str += label
                str += ": "
                str += "\(value)"
            }
        }
        str += ")"
        
        return str
    }
}

func convertPoundsToKilograms(_ pounds: Double) -> Double {
    return pounds * 0.453592
}

func convertKilogramsToPounds(_ kilograms: Double) -> Double {
    return kilograms / 0.453592
}

struct UnitPreference {
    var weightUnit: WeightUnit
    var heightUnit: HeightUnit
}

struct MacroSplit {
    var carbs: Int
    var protein: Int
    var fats: Int
}

enum WeightGoal: CaseIterable {
    case loseWeight, gainWeight, maintainWeight
    
    var description: String {
        switch self {
        case .loseWeight:
            return "Lose Weight"
        case .gainWeight:
            return "Gain Weight"
        case .maintainWeight:
            return "Maintain Weight"
        }
    }
}

enum WeeklyWeightGoal: CaseIterable {
    case lose0_25, lose0_5, lose0_75, lose1_0, lose1_25, lose1_5, lose1_75, lose2_0
    case maintain
    case gain0_25, gain0_5, gain0_75, gain1_0, gain1_25, gain1_5, gain1_75, gain2_0
    
    var poundsPerWeek: Double {
        switch self {
        case .lose2_0: return -2.0
        case .lose1_75: return -1.75
        case .lose1_5: return -1.5
        case .lose1_25: return -1.25
        case .lose1_0: return -1.0
        case .lose0_75: return -0.75
        case .lose0_5: return -0.5
        case .lose0_25: return -0.25
        case .maintain: return 0.0
        case .gain0_25: return 0.25
        case .gain0_5: return 0.5
        case .gain0_75: return 0.75
        case .gain1_0: return 1.0
        case .gain1_25: return 1.25
        case .gain1_5: return 1.5
        case .gain1_75: return 1.75
        case .gain2_0: return 2.0
        }
    }
    
    var kilogramsPerWeek: Double {
        switch self {
        case .lose2_0: return -1.0
        case .lose1_75: return -0.8
        case .lose1_5: return -0.7
        case .lose1_25: return -0.6
        case .lose1_0: return -0.5
        case .lose0_75: return -0.35
        case .lose0_5: return -0.25
        case .lose0_25: return -0.1
        case .maintain: return 0.0
        case .gain0_25: return 0.1
        case .gain0_5: return 0.25
        case .gain0_75: return 0.35
        case .gain1_0: return 0.5
        case .gain1_25: return 0.6
        case .gain1_5: return 0.7
        case .gain1_75: return 0.8
        case .gain2_0: return 1.0
        }
    }
    
    func displayName(unit: WeightUnit) -> String {
        switch unit {
        case .pounds:
            let absValue = abs(poundsPerWeek).trimmed
            return poundsPerWeek == 0 ? "Maintenance" :
                poundsPerWeek < 0 ? "-\(absValue) lb/week" : "+\(absValue) lb/week"
        case .kilograms:
            let kg = kilogramsPerWeek
            let absValue = abs(kg).trimmed
            return kg == 0 ? "Maintenance" :
                kg < 0 ? "-\(absValue) kg/week" : "+\(absValue) kg/week"
        }
    }
    
    func description(unit: WeightUnit) -> String {
        func trimmed(_ value: Double) -> String {
            let formatted = String(format: "%.2f", value)
            return formatted.replacingOccurrences(of: #"(\.0+|(?<=\.\d)0)$"#, with: "", options: .regularExpression)
        }
        
        switch unit {
        case .pounds:
            let absValue = abs(poundsPerWeek).trimmed
            return poundsPerWeek == 0 ? "Maintain current weight" :
                poundsPerWeek < 0 ? "Lose \(absValue) lb per week" : "Gain \(absValue) lb per week"
        case .kilograms:
            let kg = kilogramsPerWeek
            let absValue = abs(kg).trimmed
            return kg == 0 ? "Maintain current weight" :
                kg < 0 ? "Lose \(absValue) kg per week" : "Gain \(absValue) kg per week"
        }
    }
    
    static let lossGoals: [WeeklyWeightGoal] = [
        .lose2_0, .lose1_75, .lose1_5, .lose1_25, .lose1_0, .lose0_75, .lose0_5, .lose0_25
    ]

    static let gainGoals: [WeeklyWeightGoal] = [
        .gain0_25, .gain0_5, .gain0_75, .gain1_0, .gain1_25, .gain1_5, .gain1_75, .gain2_0
    ]

    static let maintainGoal: [WeeklyWeightGoal] = [.maintain]
}

extension Double {
    var trimmed: String {
        let formatted = String(format: "%.2f", self)
        return formatted.replacingOccurrences(of: #"(\.0+|(?<=\.\d)0)$"#, with: "", options: .regularExpression)
    }
    
}

enum WeightUnit {
    case pounds
    case kilograms
    
    var shortSymbol: String {
        switch self {
        case .pounds:
            return "lb"
        case .kilograms:
            return "kg"
        }
    }
}

enum HeightUnit {
    case feet
    case cm
}

enum ActivityLevel: CaseIterable {
    case sedentary, lightlyActive, moderatelyActive, veryActive, extremelyActive

    var displayName: String {
        switch self {
        case .sedentary:
            return "Sedentary"
        case .lightlyActive:
            return "Lightly Active"
        case .moderatelyActive:
            return "Moderately Active"
        case .veryActive:
            return "Very Active"
        case .extremelyActive:
            return "Extremely Active"
        }
    }
    
    var description: String {
        switch self {
        case .sedentary:
            return "Little to no exercise"
        case .lightlyActive:
            return "Light exercise 1–3 days per week"
        case .moderatelyActive:
            return "Moderate exercise 3–5 days per week"
        case .veryActive:
            return "Hard exercise 6–7 days per week"
        case .extremelyActive:
            return "Very intense daily exercise or physical job"
        }
    }
}
