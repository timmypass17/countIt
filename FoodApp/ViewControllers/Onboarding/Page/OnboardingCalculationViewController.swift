//
//  OnboardingCalculationViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/9/25.
//

import UIKit

class OnboardingCalculationViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your estimated calorie goals"
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
        tableView.register(DailyCaloriesTableViewCell.self, forCellReuseIdentifier: DailyCaloriesTableViewCell.reuseIdentifier)
        tableView.register(MacroSplitTableViewCell.self, forCellReuseIdentifier: MacroSplitTableViewCell.reuseIdentifier)
        tableView.register(MacroInputTableViewCell.self, forCellReuseIdentifier: MacroInputTableViewCell.reuseIdentifier)
        
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

extension OnboardingCalculationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DailyCaloriesTableViewCell.reuseIdentifier, for: indexPath) as! DailyCaloriesTableViewCell
            cell.update(calories: userProfile.dailyCalories) { caloriesText in
                guard let calories = Int(caloriesText) else { return }
                self.userProfile.dailyCalories = calories
            }
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MacroSplitTableViewCell.reuseIdentifier, for: indexPath) as! MacroSplitTableViewCell
            cell.update(carbs: userProfile.macroSplit.carbsPercentage, proteins: userProfile.macroSplit.proteinPercentage, fats: userProfile.macroSplit.fatsPercentage)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MacroInputTableViewCell.reuseIdentifier, for: indexPath) as! MacroInputTableViewCell
            if indexPath.row == 2 {
                cell.update(title: "Carbs", grams: userProfile.macroSplit.carbsGrams) { carbsGramText in
                    guard let carbsGram = Int(carbsGramText) else {
                        self.userProfile.macroSplit.carbsGrams = nil
                        NotificationCenter.default.post(name: .userInfoUpdated, object: nil)
                        return
                    }
                    self.userProfile.macroSplit.carbsGrams = carbsGram
                    NotificationCenter.default.post(name: .userInfoUpdated, object: nil)
                }
            } else if indexPath.row == 3 {
                cell.update(title: "Protein", grams: userProfile.macroSplit.proteinGrams) { protienGramText in
                    guard let proteinGram = Int(protienGramText) else {
                        self.userProfile.macroSplit.proteinGrams = nil
                        NotificationCenter.default.post(name: .userInfoUpdated, object: nil)
                        return
                    }
                    self.userProfile.macroSplit.proteinGrams = proteinGram
                    NotificationCenter.default.post(name: .userInfoUpdated, object: nil)
                }
            } else if indexPath.row == 4 {
                cell.update(title: "Fats", grams: userProfile.macroSplit.fatsGrams) { fatsGramText in
                    guard let fatsGram = Int(fatsGramText) else {
                        self.userProfile.macroSplit.fatsGrams = nil
                        NotificationCenter.default.post(name: .userInfoUpdated, object: nil)
                        return
                    }
                    self.userProfile.macroSplit.fatsGrams = fatsGram
                    NotificationCenter.default.post(name: .userInfoUpdated, object: nil)
                }
            }
            return cell
        }
    }
}

extension OnboardingCalculationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
            
            let macrosSplitViewController = MacrosSplitViewController(selectedCarbs: userProfile.macroSplit.carbsPercentage, selectedProtein: userProfile.macroSplit.proteinPercentage, selectedFat: userProfile.macroSplit.fatsPercentage)
            macrosSplitViewController.delegate = self
            let navigationController = UINavigationController(rootViewController: macrosSplitViewController)
            
            if let sheet = navigationController.sheetPresentationController {
                sheet.detents = [.medium()]
            }

            self.present(navigationController, animated: true)
        }
    }
//    
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        if indexPath.row == 0 {
//            return nil
//        }
//        return indexPath
//    }
}

extension OnboardingCalculationViewController: MacrosSplitViewControllerDelegate {
    
    func macrosSplitViewController(_ viewController: MacrosSplitViewController, didUpdateSplit split: (carbsPercent: Int, proteinPercent: Int, fatPercent: Int)) {
        userProfile.macroSplit.carbsPercentage = split.carbsPercent
        userProfile.macroSplit.proteinPercentage = split.proteinPercent
        userProfile.macroSplit.fatsPercentage = split.fatPercent
        
        // Update grams after setting new split percentages
        userProfile.recalculateMacroSplitGrams()

        tableView.reloadData()
    }
}
