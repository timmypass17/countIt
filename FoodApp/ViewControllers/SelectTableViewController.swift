//
//  SelectTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/5/24.
//

import UIKit

class SelectTableViewController: UITableViewController {
    
    let food: SearchResultFood
    var selectedIndexPath: IndexPath?
    
    init(food: SearchResultFood) {
        self.food = food
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SelectCell")
        title = "Choose a Size"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .done, primaryAction: doneButtonTapped())
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelButtonTapped())
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return food.self
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectCell", for: indexPath)
        let foodPortion = foodPortion[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = foodPortion
        cell.contentConfiguration = config
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Serving Size"
    }
    
    func doneButtonTapped() -> UIAction {
        return UIAction { [self] _ in
            dismiss(animated: true)
        }
    }
    
    func cancelButtonTapped() -> UIAction {
        return UIAction { [self] _ in
            dismiss(animated: true)
        }
    }
}
