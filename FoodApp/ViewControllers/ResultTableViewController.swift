//
//  ResultTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/1/24.
//

import UIKit

class ResultsTableViewController: UIViewController {
    
    var searchResponse: FoodSearchResponse = FoodSearchResponse(totalHits: 0, currentPage: 1, totalPages: 0, foodParts: [])

    let meal: Meal?
    let foodEntry: FoodEntry?
    let userProfile: UserProfile
    let foodService: FoodService
    var query: String?
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
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
    
    var contentUnavailableView: UIContentUnavailableView = {
        var configuration = UIContentUnavailableConfiguration.empty()
        configuration.text = "No Foods Found"
        configuration.secondaryText = "Start by searching for a food above to see results here."
        configuration.image = UIImage(systemName: "magnifyingglass")
        
        let view = UIContentUnavailableView(configuration: configuration)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(meal: Meal?, foodEntry: FoodEntry?, userProfile: UserProfile, foodService: FoodService) {
        self.meal = meal
        self.foodEntry = foodEntry
        self.userProfile = userProfile
        self.foodService = foodService
        super.init(nibName: nil, bundle: nil)
    }
    
    weak var addFoodDelegate: AddFoodDetailViewControllerDelegate?
    weak var historyDelegate: FoodDetailTableViewControllerHistoryDelegate?
    weak var resultDelegate: ResultTableViewCellDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.reuseIdentifier)
        tableView.register(ResultsHeaderView.self, forHeaderFooterViewReuseIdentifier: ResultsHeaderView.reuseIdentifier)
        tableView.backgroundColor = UIColor(hex: "#1c1c1e")
        view.addSubview(tableView)
        view.addSubview(contentUnavailableView)
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentUnavailableView.topAnchor.constraint(equalTo: view.topAnchor),
            contentUnavailableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentUnavailableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentUnavailableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
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
//        guard let query else { return }
//        let resultsPaginatedViewController = ResultsPaginatedViewController(query: query, section: section)
//        resultsPaginatedViewController.foodService = foodService
//        present(UINavigationController(rootViewController: resultsPaginatedViewController), animated: true)
    }
    
}

extension ResultsTableViewController: ResultTableViewCellDelegate {
    func resultTableViewCell(_ cell: ResultTableViewCell, didTapAddButton: Bool) {
        guard let meal,
              let indexPath = tableView.indexPath(for: cell),
              let section = Section(rawValue: indexPath.section)
        else { return }
        
//        let foodItem: FoodItem
        let foodItem = searchResponse.foods[indexPath.row]

//        switch section {
//        case .bestMatch:
//            foodItem = bestMatchResponse.foods[indexPath.row]
//        case .moreResults:
//            foodItem = moreResultsResponse.foods[indexPath.row]
//        }
//        
        do {
            try foodService.addFood(foodItem, with: foodItem.selectedFoodPortion, quantity: 1, to: meal, context: CoreDataStack.shared.childContext())
        } catch {
            print("Error adding food: \(error)")
        }
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        resultDelegate?.resultTableViewCell(cell, didTapAddButton: didTapAddButton)
    }
}

extension ResultsTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
//        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse.foods.count
//        guard let section = Section(rawValue: section) else { return 0 }
//        switch section {
//        case .bestMatch:
//            return bestMatchResponse.foods.count
//        case .moreResults:
//            return moreResultsResponse.foods.count
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.reuseIdentifier, for: indexPath) as! ResultTableViewCell
        let foodItem = searchResponse.foods[indexPath.row]
//        let foodItem: FoodItem
//        switch section {
//        case .bestMatch:
//            foodItem = bestMatchResponse.foods[indexPath.row]
//        case .moreResults:
//            foodItem = moreResultsResponse.foods[indexPath.row]
//        }
        cell.delegate = self
        cell.update(with: foodItem)
        cell.backgroundColor = UIColor(hex: "#252525")

        return cell
    }
}

extension ResultsTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        
        let foodItem = searchResponse.foods[indexPath.row]
        let addFoodDetailViewController = AddFoodDetailViewController(foodEntry: foodEntry, fdcFood: foodItem, meal: meal, userProfile: userProfile, foodService: foodService)
        addFoodDetailViewController.delegate = addFoodDelegate
        addFoodDetailViewController.dismissDelegate = self
        addFoodDetailViewController.historyDelegate = historyDelegate

        present(UINavigationController(rootViewController: addFoodDetailViewController), animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard searchResponse.foods.count > 0 else { return nil }
        return "Results (\(searchResponse.totalHits))"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
}
