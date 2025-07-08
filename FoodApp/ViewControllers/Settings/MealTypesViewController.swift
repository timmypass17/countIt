//
//  MealTypesViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/7/25.
//

import UIKit

class MealTypesViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
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
        title = "Meal Types"
        tableView.backgroundColor = .background

        tableView.register(MealTypeTableViewCell.self, forCellReuseIdentifier: MealTypeTableViewCell.reuseIdentifier)
        tableView.register(AddItemTableViewCell.self, forCellReuseIdentifier: AddItemTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
}

extension MealTypesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userProfile.userMealTypes.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == userProfile.userMealTypes.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddItemTableViewCell.reuseIdentifier, for: indexPath) as! AddItemTableViewCell
            cell.update(title: "Add Meal Type")
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MealTypeTableViewCell.reuseIdentifier, for: indexPath) as! MealTypeTableViewCell
        let mealType = userProfile.userMealTypes[indexPath.row]
        cell.update(title: mealType.name)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension MealTypesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < userProfile.userMealTypes.count {
            let mealType = userProfile.userMealTypes[indexPath.row]
            let editMealTypeViewController = EditMealTypeViewController(userMealType: mealType)
            editMealTypeViewController.delegate = self
            present(UINavigationController(rootViewController: editMealTypeViewController), animated: true)
        } else {
            showAddMealPlanAlert()
        }
    }
    
    func showAddMealPlanAlert() {
        let alert = UIAlertController(title: "Add Meal Type", message: "Enter a name", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Dinner"
            textField.autocapitalizationType = .words
            
            let textChangedAction = UIAction { _ in
                alert.actions[1].isEnabled = textField.text!.count > 0
            }
            textField.addAction(textChangedAction, for: .allEditingEvents)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let self,
                  let name = alert.textFields?.first?.text else { return }
        
            let userMealType = UserMealType(context: CoreDataStack.shared.context)
            userMealType.name = name
            userMealType.index = Int16(userProfile.userMealTypes.count)
            userMealType.userProfile = userProfile
            CoreDataStack.shared.saveContext()
            tableView.insertRows(at: [IndexPath(row: userProfile.userMealTypes.count - 1, section: 0)], with: .automatic)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true)
    }
    
    // called when user taps delete icon
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteMealType(forRowAt: indexPath)
        }
    }
    
    func deleteMealType(forRowAt indexPath: IndexPath) {
        // 1. Get the meal type
        let mealTypeToDelete = userProfile.userMealTypes[indexPath.row]

        // 2. Delete from context
        CoreDataStack.shared.context.delete(mealTypeToDelete)

        // 3. Save changes to persist deletion
        CoreDataStack.shared.saveContext()

        // 4. Recalculate indices for remaining items
        for (index, mealType) in userProfile.userMealTypes.enumerated() {
            mealType.index = Int16(index)
        }

        // 5. Save updated indices
        CoreDataStack.shared.saveContext()

        // 6. Reload entire section (cleanest option) or just affected rows
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    // which rows can be edited? (e.g. delete, reordered)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row < userProfile.userMealTypes.count
    }
    
    // Called when user reorder cells
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Moving within the same meal
        let mealType = userProfile.userMealTypes[sourceIndexPath.row]
        let mealTypes = userProfile.userMealTypes
        if sourceIndexPath.row < destinationIndexPath.row {
            // Shift affected items left
            for item in mealTypes {
                if item.index > Int16(sourceIndexPath.row) && item.index <= Int16(destinationIndexPath.row) {
                    item.index -= 1
                }
            }
        } else if sourceIndexPath.row > destinationIndexPath.row {
            // Shift affected items right
            for item in mealTypes {
                if item.index >= Int16(destinationIndexPath.row) && item.index < Int16(sourceIndexPath.row) {
                    item.index += 1
                }
            }
        }
        
        mealType.index = Int16(destinationIndexPath.row)
        CoreDataStack.shared.saveContext()
    }
    
    // Lets you control where a row is allowed to be moved (e.g. Don't let users move food item under "add button")
    // “Can I drop the row at this new location?”
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        var addButtonIndexPath = userProfile.userMealTypes.count
        guard proposedDestinationIndexPath.row != addButtonIndexPath else { return sourceIndexPath }
        return proposedDestinationIndexPath
    }
    
}

extension MealTypesViewController: EditMealTypeViewControllerDelegate {
    func editMealTypeViewController(_ viewController: EditMealTypeViewController, didUpdateMealType userMealType: UserMealType) {
        guard let row = userProfile.userMealTypes.firstIndex(where: { $0.objectID == userMealType.objectID }) else { return }
        tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
    }
}
