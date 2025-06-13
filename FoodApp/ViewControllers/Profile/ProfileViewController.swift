//
//  ProfileViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/10/25.
//

import UIKit

class ProfileViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    enum Section: Int, CaseIterable {
        case goals, nutritionGoals, deleteAccount
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

        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        title = "Goals"
        
        goalModels[0].description = "na \(userProfile.weightUnit.pluralSymbol)"
        goalModels[1].description = "0 \(userProfile.weightUnit.pluralSymbol)"  // current weight
        goalModels[2].description = "\(userProfile.goalWeight?.trimmed ?? "") \(userProfile.weightUnit.pluralSymbol)"
        goalModels[3].description = userProfile.weeklyGoal.displayName(unit: userProfile.weightUnit)
        goalModels[4].description = userProfile.activityLevel.displayName
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
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .goals:
            return goalModels.count
        case .nutritionGoals:
            return 0
        case .deleteAccount:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .goals:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSelectableTableViewCell.reuseIdentifier, for: indexPath) as! ProfileSelectableTableViewCell
            let model = goalModels[indexPath.row]
            cell.update(title: model.title, description: model.description)
            return cell
        case .nutritionGoals:
            return UITableViewCell()
        case .deleteAccount:
            let cell = tableView.dequeueReusableCell(withIdentifier: DeleteAccountTableViewCell.reuseIdentifier, for: indexPath) as! DeleteAccountTableViewCell
            return cell
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
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
        case .deleteAccount:
            showDeleteAccountAlert()
        }
    }
}
