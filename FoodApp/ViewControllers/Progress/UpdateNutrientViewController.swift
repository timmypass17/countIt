//
//  UpdateNutrientViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/1/25.
//

import UIKit
import SwiftUI


class UpdateNutrientViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let primaryText: String
    let initialAmount: Double
    var amount: Double?
    let unit: String
    let didTapSaveGoal: (Double) -> Void
    
    init(primaryText: String, initialAmount: Double, unit: String, didTapSaveGoal: @escaping (Double) -> Void) {
        self.primaryText = primaryText
        self.initialAmount = initialAmount
        self.amount = initialAmount
        self.unit = unit
        self.didTapSaveGoal = didTapSaveGoal
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Set \(primaryText) Goal"
        tableView.register(UpdateNutrientTableViewCell.self, forCellReuseIdentifier: UpdateNutrientTableViewCell.reuseIdentifier)
        tableView.dataSource = self

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", primaryAction: didTapCancelButton())
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", primaryAction: didTapSave())
    }
    
    func didTapSave() -> UIAction {
        return UIAction { _ in
            guard let amount = self.amount else { return }
            self.didTapSaveGoal(amount)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func didTapCancelButton() -> UIAction {
        return UIAction { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension UpdateNutrientViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UpdateNutrientTableViewCell.reuseIdentifier, for: indexPath) as! UpdateNutrientTableViewCell
        cell.update(primaryText: primaryText, amount: amount, initialAmount: initialAmount, unit: unit)
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
}

extension UpdateNutrientViewController: UpdateNutrientTableViewCellDelegate {
    func updateNutrientTableViewCell(_ sender: UpdateNutrientTableViewCell, amountTextValueChanged amountText: String?) {
        guard let amountText else {
            amount = nil
            return
        }
        
        amount = Double(amountText)
    }
}

struct UpdateNutrientView: UIViewControllerRepresentable {
    let primaryText: String
    let initialAmount: Double
    let unit: String
    let didTapSaveGoal: (Double) -> Void

    func makeUIViewController(context: Context) -> UINavigationController {
        let viewController = UpdateNutrientViewController(primaryText: primaryText, initialAmount: initialAmount, unit: unit, didTapSaveGoal: didTapSaveGoal)
        return UINavigationController(rootViewController: viewController)
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // Update if needed
    }
}
