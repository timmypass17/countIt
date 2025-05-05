//
//  ResultTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/1/24.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var bestMatchResponse: FoodSearchResponse = FoodSearchResponse(totalHits: 0, currentPage: 1, totalPages: 0, foods: [])
    var moreResultsResponse: FoodSearchResponse = FoodSearchResponse(totalHits: 0, currentPage: 1, totalPages: 0, foods: [])
    let meal: Meal?
    let foodService: FoodService
    var query: String?
    
    enum Section: Int, CaseIterable {
        case bestMatch, moreResults
        
        var description: String {
            switch self {
            case .bestMatch:
                return "Best Match"
            case .moreResults:
                return "More Results"
            }
        }
        
        var dataTypes: [DataType] {
            switch self {
            case .bestMatch:
                return [.foundation]
            case .moreResults:
                return [.survey, .branded]
            }
        }
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
        tableView.register(ResultsHeaderView.self, forHeaderFooterViewReuseIdentifier: ResultsHeaderView.reuseIdentifier)
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
            return bestMatchResponse.foods.count
        case .moreResults:
            return moreResultsResponse.foods.count
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
            foodItem = bestMatchResponse.foods[indexPath.row]
        case .moreResults:
            foodItem = moreResultsResponse.foods[indexPath.row]
        }
        cell.update(with: foodItem)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        let foodItem: SearchResultFood
        switch section {
        case .bestMatch:
            foodItem = bestMatchResponse.foods[indexPath.row]
        case .moreResults:
            foodItem = moreResultsResponse.foods[indexPath.row]
        }
        
        //        let foodDetailTableViewController = FoodDetailTableViewController(fdcFood: foodItem, meal: meal, foodService: foodService)
        //        foodDetailTableViewController.delegate = delegate
        //        foodDetailTableViewController.dismissDelegate = self
        //        foodDetailTableViewController.historyDelegate = historyDelegate
        //
        //        present(UINavigationController(rootViewController: foodDetailTableViewController), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = Section(rawValue: section) else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ResultsHeaderView.reuseIdentifier) as! ResultsHeaderView
        headerView.delegate = self
        headerView.section = section
        switch section {
        case .bestMatch:
            headerView.update(title: "Best Match (\(bestMatchResponse.totalHits))")
        case .moreResults:
            headerView.update(title: "More Results (\(moreResultsResponse.totalHits))")
        }
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
}

extension ResultsTableViewController: FoodDetailTableViewControllerDismissDelegate {
    func foodDetailTableViewController(_ tableViewController: FoodDetailTableViewController, didDismiss: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension ResultsTableViewController: ResultsHeaderViewDelegate {

    func resultsHeaderView(_ sender: ResultsHeaderView, didTapInSection section: Section) {
        guard let query else { return }
        let resultsPaginatedViewController = ResultsPaginatedViewController(query: query, section: section)
        resultsPaginatedViewController.foodService = foodService
        present(UINavigationController(rootViewController: resultsPaginatedViewController), animated: true)
    }
    
}
