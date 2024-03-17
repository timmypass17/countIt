//
//  ResultTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/1/24.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var foods: [Food] = []
    let meal: Meal?
    let foodService: FoodService
        
    init(meal: Meal?, foodService: FoodService) {
        self.meal = meal
        self.foodService = foodService
        super.init(style: .insetGrouped)
    }
    
    weak var delegate: FoodDetailTableViewControllerDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as! SearchTableViewCell
        let food = foods[indexPath.row]
        cell.update(with: food)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = foods[indexPath.row]
        let foodDetailTableViewController = FoodDetailTableViewController(food: food, meal: meal, foodService: foodService)
        foodDetailTableViewController.dismissDelegate = self
        foodDetailTableViewController.delegate = delegate
        
        present(UINavigationController(rootViewController: foodDetailTableViewController), animated: true)
    }
}

extension ResultsTableViewController: FoodDetailTableViewControllerDismissDelegate {
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didDismiss: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
