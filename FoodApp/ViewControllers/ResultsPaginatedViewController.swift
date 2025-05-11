//
//  ResultsPaginatedViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/5/25.
//

import UIKit

// Don’t need explicit DispatchQueue.main.async calls, updates UI on main thread (if u try to update ui from background thread like making network request, app can crash)
@MainActor
class ResultsPaginatedViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        spinner.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        return spinner
    }()
    
    var foodResponse = FoodSearchResponse(
        totalHits: 0,
        currentPage: 1,
        totalPages: 0,
        foods: []
    )
    
    var isLoading = false {
        didSet {
            if self.isLoading {
                self.spinner.startAnimating()
            } else  {
                self.spinner.stopAnimating()
            }
        }
    }

    let query: String
    var section: ResultsTableViewController.Section
    var foodService: FoodService!
    
    init(query: String, section: ResultsTableViewController.Section) {
        self.query = query
        self.section = section
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(section.description) for \"\(query)\""
        tableView.dataSource = self
        tableView.tableFooterView = spinner
        tableView.prefetchDataSource = self
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.reuseIdentifier)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: didTapCancelButton())
        Task {
            await loadFood()
        }
    }
    
    // MARK: - Data Fetching
    func loadFood() async {
        let isInitialLoad = foodResponse.currentPage == 1
        guard !isLoading, isInitialLoad || foodResponse.currentPage <= foodResponse.totalPages else { return }
        
        isLoading = true

        defer {
            isLoading = false
        }
        
        do {
            let response = try await foodService.getFoods(
                query: query,
                dataTypes: section.dataTypes,
                pageSize: 20,
                pageNumber: foodResponse.currentPage
            )
            
            let start = foodResponse.foods.count
            let newItems = response.foods
            let end = start + newItems.count
            
            foodResponse.foods.append(contentsOf: newItems)
            foodResponse.currentPage += 1
            foodResponse.totalPages  = response.totalPages
            
            let paths = (start..<end).map { IndexPath(row: $0, section: 0) }
            
            if isInitialLoad {
              tableView.reloadData()
            } else {
              tableView.insertRows(at: paths, with: .automatic)
            }
        } catch {
            print("Error loading food:", error)
        }
    }
    
    func didTapCancelButton() -> UIAction {
        return UIAction { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDataSource
extension ResultsPaginatedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodResponse.foods.count
    }
    
    func tableView(_ tv: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tv.dequeueReusableCell(withIdentifier: ResultTableViewCell.reuseIdentifier, for: indexPath) as! ResultTableViewCell
        let item = foodResponse.foods[indexPath.row]
        cell.update(with: item)
        return cell
    }
}

extension ResultsPaginatedViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: { $0.row >= foodResponse.foods.count - 3 }) {
            Task { await loadFood() }
        }
    }
}
