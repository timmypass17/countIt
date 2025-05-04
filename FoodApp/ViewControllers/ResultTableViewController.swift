//
//  ResultTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/1/24.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var bestMatchFoodItems: [SearchResultFood] = []
    var moreResultsFoodItems: [SearchResultFood] = []
    let meal: Meal?
    let foodService: FoodService
    
    enum Section: Int, CaseIterable {
        case bestMatch, moreResults
    }
    
    var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
        
    init(meal: Meal?, foodService: FoodService) {
        self.meal = meal
        self.foodService = foodService
        super.init(style: .grouped)
    }
    
    weak var delegate: FoodDetailTableViewControllerDelegate?
    weak var historyDelegate: FoodDetailTableViewControllerHistoryDelegate?
    weak var resultDelegate: ResultTableViewCellDelegate?
    weak var resultHistoryDelegate: ResultTableViewCellHistoryDelegate?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.reuseIdentifier)
        
        view.addSubview(spinner)
    
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ])
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .bestMatch:
            return bestMatchFoodItems.count
        case .moreResults:
            return moreResultsFoodItems.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.reuseIdentifier, for: indexPath) as! ResultTableViewCell
        cell.delegate = resultDelegate
        cell.historyDelegate =  resultHistoryDelegate
        let foodItem: SearchResultFood
        switch section {
        case .bestMatch:
            foodItem = bestMatchFoodItems[indexPath.row]
        case .moreResults:
            foodItem = moreResultsFoodItems[indexPath.row]
        }
        cell.update(with: foodItem)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        let foodItem: SearchResultFood
        switch section {
        case .bestMatch:
            foodItem = bestMatchFoodItems[indexPath.row]
        case .moreResults:
            foodItem = moreResultsFoodItems[indexPath.row]
        }
        
//        let foodDetailTableViewController = FoodDetailTableViewController(fdcFood: foodItem, meal: meal, foodService: foodService)
//        foodDetailTableViewController.delegate = delegate
//        foodDetailTableViewController.dismissDelegate = self
//        foodDetailTableViewController.historyDelegate = historyDelegate
//
//        present(UINavigationController(rootViewController: foodDetailTableViewController), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return nil }
        switch section {
        case .bestMatch:
            return "Recommended"
        case .moreResults:
            return "More Results"
        }
    }
}

extension ResultsTableViewController: FoodDetailTableViewControllerDismissDelegate {
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didDismiss: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
