//
//  CurrentWeightEditViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/12/25.
//

import UIKit

class CurrentWeightEditViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let currentWeight: Double
    let weightUnit: WeightUnit

    init(currentWeight: Double, weightUnit: WeightUnit) {
        self.currentWeight = currentWeight
        self.weightUnit = weightUnit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Set Current Weight"
        tableView.register(CurrentWeightEditTableViewCell.self, forCellReuseIdentifier: CurrentWeightEditTableViewCell.reuseIdentifier)
        tableView.dataSource = self

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", primaryAction: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", primaryAction: nil)

    }

}

extension CurrentWeightEditViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeightEditTableViewCell.reuseIdentifier, for: indexPath) as! CurrentWeightEditTableViewCell
        cell.update(weightPlaceholderText: currentWeight.trimmed, weightUnit: weightUnit)
        return cell
    }
    
    
}
