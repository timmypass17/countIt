//
//  OnboardingUserViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/8/25.
//

import UIKit

class OnboardingUserViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tell me about yourself"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "You can update these later in settings."
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
    let userProfile: UserProfile
    
    enum Section: Int, CaseIterable {
        case user
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
        tableView.register(OnboardingSegmentedTableViewCell.self, forCellReuseIdentifier: OnboardingSegmentedTableViewCell.reuseIdentifier)
        tableView.register(HeightTableViewCell.self, forCellReuseIdentifier: HeightTableViewCell.reuseIdentifier)
        tableView.register(DateOfBirthTableViewCell.self, forCellReuseIdentifier: DateOfBirthTableViewCell.reuseIdentifier)
        tableView.register(MenuPickerTableViewCell<ActivityLevel>.self, forCellReuseIdentifier: MenuPickerTableViewCell<ActivityLevel>.reuseIdentifier)
        tableView.register(HeightPreferenceFooterView.self, forHeaderFooterViewReuseIdentifier: HeightPreferenceFooterView.reuseIdentifier)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), primaryAction: didTapBackButton())
        
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
    
    func didTapBackButton() -> UIAction {
        return UIAction { _ in
            NotificationCenter.default.post(name: .onboardingBackButton, object: nil)
        }
    }
}

extension OnboardingUserViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .user:
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .user:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: OnboardingSegmentedTableViewCell.reuseIdentifier) as! OnboardingSegmentedTableViewCell
                cell.update(title: "Sex", sex: userProfile.sex)
                cell.delegate = self
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: HeightTableViewCell.reuseIdentifier) as! HeightTableViewCell
                cell.update(title: "Height", heightCm: userProfile.heightCm, heightUnit: userProfile.unitPreference.heightUnit)
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: DateOfBirthTableViewCell.reuseIdentifier) as! DateOfBirthTableViewCell
                cell.delegate = self
                cell.update(title: "Date of Birth", date: userProfile.dateOfBirth)
                return cell
            } else if indexPath.row == 3 {
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
            return UITableViewCell()
        }
    }
}

extension OnboardingUserViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let section = Section(rawValue: indexPath.section), section == .user else { return }
        
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let section = Section(rawValue: indexPath.section), section == .user
        else { return nil }
        
        if indexPath.row == 1 {
            switch userProfile.unitPreference.heightUnit {
            case .feet:
                let heightFeetPickerViewController = HeightFeetPickerViewController(heightCm: userProfile.heightCm ?? 167)
                heightFeetPickerViewController.delegate = self

                let navigationController = UINavigationController(rootViewController: heightFeetPickerViewController)
                
                if let sheet = navigationController.sheetPresentationController {
                    sheet.detents = [.medium()]
                }

                self.present(navigationController, animated: true)
            case .cm:
                let heightCmPickerViewController = HeightCmPickerViewController(heightCm: userProfile.heightCm ?? 167)
                heightCmPickerViewController.delegate = self

                let navigationController = UINavigationController(rootViewController: heightCmPickerViewController)
                
                if let sheet = navigationController.sheetPresentationController {
                    sheet.detents = [.medium()]
                }

                self.present(navigationController, animated: true)
            }
        }
        
        return indexPath
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeightPreferenceFooterView.reuseIdentifier) as! HeightPreferenceFooterView
        footer.update(heightUnit: userProfile.unitPreference.heightUnit)
        footer.delegate = self
        return footer
    }
    
    func tableView(_ tv: UITableView, heightForFooterInSection sec: Int) -> CGFloat {
        return 42
    }
}

extension OnboardingUserViewController: HeightFeetPickerViewControllerDelegate {
    func heightFeetPickerViewController(_ viewController: HeightFeetPickerViewController, didUpdateHeight height: (feet: Int, inches: Int)) {
        self.userProfile.heightCm = convertToCentimeters(feet: height.feet, inches: height.inches)
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
        NotificationCenter.default.post(name: .userInfoUpdated, object: nil)
    }
}

extension OnboardingUserViewController: HeightCmPickerViewControllerDelegate {
    func heightCmPickerViewController(_ viewController: HeightCmPickerViewController, didUpdateHeight heightCm: Int) {
        self.userProfile.heightCm = heightCm
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
        NotificationCenter.default.post(name: .userInfoUpdated, object: nil)
    }
}

extension OnboardingUserViewController: HeightPreferenceFooterViewDelegate {
    func heightPreferenceFooterView(_ footerView: HeightPreferenceFooterView, didUpdateHeightPreference heightUnit: HeightUnit) {
        userProfile.unitPreference.heightUnit = heightUnit
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
    }
}

extension OnboardingUserViewController: OnboardingSegmentedTableViewCellDelegate {
    func onboardingSegmentedTableViewCell(_ cell: OnboardingSegmentedTableViewCell, didSelectSex sex: Gender) {
        userProfile.sex = sex
        NotificationCenter.default.post(name: .userInfoUpdated, object: nil)
    }
}

extension OnboardingUserViewController: DateOfBirthTableViewCellDelegate {
    func dateOfBirthTableViewCell(_ cell: DateOfBirthTableViewCell, didUpdateDateOfBirth date: Date) {
        userProfile.dateOfBirth = date
    }
}
