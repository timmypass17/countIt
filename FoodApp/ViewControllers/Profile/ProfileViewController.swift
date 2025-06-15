//
//  ProfileViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/13/25.
//

import UIKit

class ProfileViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    enum Section: Int, CaseIterable {
        case profile, goals, delete
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
        title = "My Profile"
        tableView.register(OnboardingSegmentedTableViewCell.self, forCellReuseIdentifier: OnboardingSegmentedTableViewCell.reuseIdentifier)
        tableView.register(HeightTableViewCell.self, forCellReuseIdentifier: HeightTableViewCell.reuseIdentifier)
        tableView.register(DateOfBirthTableViewCell.self, forCellReuseIdentifier: DateOfBirthTableViewCell.reuseIdentifier)
        tableView.register(HeightPreferenceFooterView.self, forHeaderFooterViewReuseIdentifier: HeightPreferenceFooterView.reuseIdentifier)
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
    }
    
    func showDeleteAccountAlert() {
        let message = "Are you sure you want to delete your account and all your data? This action is permanent and cannot be undone."
        let alertController = UIAlertController(
            title: "Delete Account?",
            message: message,
            preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            do {
                try self.foodService.deleteAccount()
                self.showOnboarding()
            } catch {
                print("Failed to delete account: \(error)")
            }
        }))

        self.present(alertController, animated: true, completion: nil)
    }
    
    func showOnboarding() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = OnboardingViewController()
            window.makeKeyAndVisible()
        }
    }
}


extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .profile:
            return 3
        case .goals:
            return 5
        case .delete:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .profile:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: OnboardingSegmentedTableViewCell.reuseIdentifier) as! OnboardingSegmentedTableViewCell
                cell.update(title: "Sex", sex: userProfile.sex)
                cell.delegate = self
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: HeightTableViewCell.reuseIdentifier) as! HeightTableViewCell
                cell.update(title: "Height", heightCm: userProfile.heightCm, heightUnit: userProfile.heightUnit)
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: DateOfBirthTableViewCell.reuseIdentifier) as! DateOfBirthTableViewCell
                cell.delegate = self
                cell.update(title: "Date of Birth", date: userProfile.dateOfBirth)
                return cell
            } else {
                return UITableViewCell()
            }
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
        case .delete:
            let cell = tableView.dequeueReusableCell(withIdentifier: DeleteAccountTableViewCell.reuseIdentifier, for: indexPath) as! DeleteAccountTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return nil }
        switch section {
        case .profile:
            return "Personal Info"
        case .goals:
            return "Goals"
        case .delete:
            return nil
        }
    }
}


extension ProfileViewController: OnboardingSegmentedTableViewCellDelegate {
    func onboardingSegmentedTableViewCell(_ cell: OnboardingSegmentedTableViewCell, didSelectSex sex: Sex) {
        userProfile.sex = sex
    }
}

extension ProfileViewController: DateOfBirthTableViewCellDelegate {
    func dateOfBirthTableViewCell(_ cell: DateOfBirthTableViewCell, didUpdateDateOfBirth date: Date) {
        userProfile.dateOfBirth = date
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath)
        if indexPath == IndexPath(row: 0, section: 2) {
            showDeleteAccountAlert()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
//        guard let section = Section(rawValue: indexPath.section), section == .profile else { return nil }
//        
//        if indexPath.row == 1 {
//            switch userProfile.heightUnit {
//            case .feet:
//                let heightFeetPickerViewController = HeightFeetPickerViewController(heightCm: Int(userProfile.heightCm ?? 167))
//                heightFeetPickerViewController.delegate = self
//
//                let navigationController = UINavigationController(rootViewController: heightFeetPickerViewController)
//                
//                if let sheet = navigationController.sheetPresentationController {
//                    sheet.detents = [.medium()]
//                }
//
//                self.present(navigationController, animated: true)
//            case .cm:
//                let heightCmPickerViewController = HeightCmPickerViewController(heightCm: Int(userProfile.heightCm ?? 167))
//                heightCmPickerViewController.delegate = self
//
//                let navigationController = UINavigationController(rootViewController: heightCmPickerViewController)
//                
//                if let sheet = navigationController.sheetPresentationController {
//                    sheet.detents = [.medium()]
//                }
//
//                self.present(navigationController, animated: true)
//            }
//        }
//        
//        return indexPath
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let section = Section(rawValue: section) else { return nil }

        switch section {
        case .profile:
            let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeightPreferenceFooterView.reuseIdentifier) as! HeightPreferenceFooterView
            footer.update(heightUnit: userProfile.heightUnit)
            footer.delegate = self
            return footer
        case .goals:
            let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: UnitPreferenceFooterView.reuseIdentifier) as! UnitPreferenceFooterView
            footer.update(currentUnit: userProfile.weightUnit)
            footer.delegate = self
            return footer
        case .delete:
            return nil
        }
    }
    
    func tableView(_ tv: UITableView, heightForFooterInSection sec: Int) -> CGFloat {
        return 42
    }
}


extension ProfileViewController: HeightPreferenceFooterViewDelegate {
    func heightPreferenceFooterView(_ footerView: HeightPreferenceFooterView, didUpdateHeightPreference heightUnit: HeightUnit) {
        userProfile.heightUnit = heightUnit
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
    }
}

extension ProfileViewController: HeightFeetPickerViewControllerDelegate {
    func heightFeetPickerViewController(_ viewController: HeightFeetPickerViewController, didUpdateHeight height: (feet: Int, inches: Int)) {
        self.userProfile.heightCm = Int16(convertToCentimeters(feet: height.feet, inches: height.inches))
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
    }
}


extension ProfileViewController: HeightCmPickerViewControllerDelegate {
    func heightCmPickerViewController(_ viewController: HeightCmPickerViewController, didUpdateHeight heightCm: Int) {
        self.userProfile.heightCm = Int16(heightCm)
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
    }
}

extension ProfileViewController: UnitPreferenceFooterViewDelegate {
    func unitPreferenceFooterView(_ footerView: UnitPreferenceFooterView, didUpdateUnitPreference weightUnit: WeightUnit) {
        userProfile.weightUnit = weightUnit
        tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
    }
}
