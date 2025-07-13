//
//  EditMealTypeViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/7/25.
//

import UIKit

protocol EditMealTypeViewControllerDelegate: AnyObject {
    func editMealTypeViewController(_ viewController: EditMealTypeViewController, didUpdateMealType userMealType: UserMealType)
}

class EditMealTypeViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Cancel", primaryAction: didTapCancelButton())
        return button
    }()
    
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Save", primaryAction: didTapSaveButton())
        button.isEnabled = false
        return button
    }()
    
    let userMealTypeDraft: UserMealType
    let childContext = CoreDataStack.shared.childContext()
    
    weak var delegate: EditMealTypeViewControllerDelegate?
        
    init(userMealType: UserMealType) {
        // object - always succeeds (fine for creating child object)
        self.userMealTypeDraft = childContext.object(with: userMealType.objectID) as! UserMealType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rename \"\(userMealTypeDraft.name)\""
        tableView.register(TextFieldInputTableViewCell.self, forCellReuseIdentifier: TextFieldInputTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.backgroundColor = Settings.shared.currentTheme.background.uiColor

        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
        updateSaveButton()
    }
    
    func didTapSaveButton() -> UIAction {
        return UIAction { [weak self] _ in
            guard let self else { return }
            do {
                try childContext.save()       // Push to parent
                CoreDataStack.shared.saveContext() // Persist to store
                do {
                    // existingObject - safer, throws error if object doesn't exist (use when loading object from another context safely)
                    let mainContextObject = try CoreDataStack.shared.context.existingObject(with: userMealTypeDraft.objectID) as! UserMealType
                    delegate?.editMealTypeViewController(self, didUpdateMealType: mainContextObject)
                } catch {
                    print("Failed to fetch object in main context: \(error)")
                }
            } catch {
                print("Failed to save context: \(error)")
            }
            dismiss(animated: true)
        }
    }
    
    func didTapCancelButton() -> UIAction {
        return UIAction { [weak self] _ in
            guard let self else { return }
            dismiss(animated: true)
        }
    }
    
    func updateSaveButton() {
        let isFormComplete = userMealTypeDraft.name != ""
        saveButton.isEnabled = isFormComplete
    }
}

extension EditMealTypeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldInputTableViewCell.reuseIdentifier, for: indexPath) as! TextFieldInputTableViewCell
        cell.update(title: "Name", valueText: userMealTypeDraft.name, placeholderText: userMealTypeDraft.name, unit: "")
        cell.delegate = self
        return cell
    }
}

extension EditMealTypeViewController: TextFieldInputTableViewCellDelegate {
    func textFieldInputTableViewCell(_ sender: TextFieldInputTableViewCell, textDidChange text: String?) {
        userMealTypeDraft.name_ = text
        updateSaveButton()
    }
}
