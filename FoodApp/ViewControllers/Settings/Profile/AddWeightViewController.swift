//
//  AddWeightViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/6/25.
//

import UIKit
import CoreData
import SwiftUI

class AddWeightViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    enum Row: Int, CaseIterable {
        case date, amount
    }
    
    lazy var userWeight: UserWeight = {
        let userWeight = UserWeight(context: childContext)
        userWeight.date_ = .now
        return userWeight
    }()
    
    let childContext: NSManagedObjectContext = CoreDataStack.shared.childContext()
    lazy var saveButton: UIBarButtonItem = UIBarButtonItem(title: "Save", primaryAction: didTapSaveButton())

    let userProfile: UserProfile
    let foodService: FoodService

    init(userProfile: UserProfile, foodService: FoodService) {
        self.userProfile = userProfile
        self.foodService = foodService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DatePickerTableViewCell.self, forCellReuseIdentifier: DatePickerTableViewCell.reuseIdentifier)
        tableView.register(TextFieldInputTableViewCell.self, forCellReuseIdentifier: TextFieldInputTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", primaryAction: didTapCancelButton())
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func updateSaveButton() {
        guard userWeight.date_ != nil,
              let weightInKg = userWeight.weightInKg,
              weightInKg > 0 else {
            saveButton.isEnabled = false
            return
        }
        saveButton.isEnabled = true
    }
    
    func didTapSaveButton() -> UIAction {
        return UIAction { _ in
            do {
                try self.childContext.save()
                CoreDataStack.shared.saveContext()
            } catch {
                print("Error adding weight")
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func didTapCancelButton() -> UIAction {
        return UIAction { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension AddWeightViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = Row(rawValue: indexPath.row) else { return UITableViewCell() }
        switch row {
        case .date:
            let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableViewCell.reuseIdentifier, for: indexPath) as! DatePickerTableViewCell
            cell.delegate = self
            cell.update(title: "Date", date: .now)
            return cell
        case .amount:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldInputTableViewCell.reuseIdentifier, for: indexPath) as! TextFieldInputTableViewCell
            cell.delegate = self
            let weight: Double?
            let currentWeight: Double
            let currentUserWeight = foodService.getCurrentUserWeight()
            switch userProfile.weightUnit {
            case .pounds:
                guard let weightInKg = userWeight.weightInKg else {
                    weight = nil
                    currentWeight = 0
                    break
                }
                weight = convertKilogramsToPounds(weightInKg)
                currentWeight = convertKilogramsToPounds(currentUserWeight?.weightInKg ?? 0)
            case .kilograms:
                weight = userWeight.weightInKg
                currentWeight = currentUserWeight?.weightInKg ?? 0
            }
            
            cell.update(title: "Weight", valueText: weight?.trimmed, placeholderText: currentWeight.trimmed, unit: userProfile.weightUnit.singularSymbol)
            
            return cell
        }
    }
}

extension AddWeightViewController: DatePickerTableViewCellDelegate {
    func datePickerTableViewCell(_ cell: DatePickerTableViewCell, didUpdateDate date: Date) {
        userWeight.date_ = date
    }
}

extension AddWeightViewController: TextFieldInputTableViewCellDelegate {
    func textFieldInputTableViewCell(_ sender: TextFieldInputTableViewCell, textDidChange amountText: String?) {
        guard let weightText = amountText,
              let weight = Double(weightText)
        else {
            userWeight.weightInKg = nil
            return
        }
        let weightConverted: Double
        switch userProfile.weightUnit {
        case .pounds:
            weightConverted = convertPoundsToKilograms(weight)
        case .kilograms:
            weightConverted = weight
        }
        userWeight.weightInKg = weightConverted
    }
}

struct AddWeightView: UIViewControllerRepresentable {
    let userProfile: UserProfile
    let foodService: FoodService

    func makeUIViewController(context: Context) -> UINavigationController {
        let viewController = AddWeightViewController(userProfile: userProfile, foodService: foodService)
        viewController.title = "Add Weight"
        return UINavigationController(rootViewController: viewController)
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // Update if needed
    }
}
