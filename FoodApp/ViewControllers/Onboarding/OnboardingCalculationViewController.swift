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
    let userInfo: UserInfo
    
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
        tableView.register(DailyCaloriesTableViewCell.self, forCellReuseIdentifier: DailyCaloriesTableViewCell.reuseIdentifier)
        tableView.register(MacroSplitTableViewCell.self, forCellReuseIdentifier: MacroSplitTableViewCell.reuseIdentifier)

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
       return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DailyCaloriesTableViewCell.reuseIdentifier, for: indexPath) as! DailyCaloriesTableViewCell
            cell.update(caloriesText: String(userInfo.dailyCalories)) { caloriesText in
                guard let calories = Int(caloriesText) else { return }
                self.userInfo.dailyCalories = calories
            }
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MacroSplitTableViewCell.reuseIdentifier, for: indexPath) as! MacroSplitTableViewCell
            cell.update(carbs: userInfo.macroSplit.carbs, proteins: userInfo.macroSplit.protein, fats: userInfo.macroSplit.fats)
            return cell
        }
        
        return UITableViewCell()
    }
}

extension OnboardingCalculationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 1 {
            
            let macrosSplitViewController = MacrosSplitViewController()

            let navigationController = UINavigationController(rootViewController: macrosSplitViewController)
            
            if let sheet = navigationController.sheetPresentationController {
                sheet.detents = [.medium()]
            }

            self.present(navigationController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == 0 {
            return nil
        }
        return indexPath
    }
}
