//
//  ResultsPaginatedViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/5/25.
//

import UIKit

// Don’t need explicit DispatchQueue.main.async calls, updates UI on main thread (if u try to update ui from background thread like making network request, app can crash)
@MainActor
class ResultsPaginatedViewController: UIViewController, ResultTableViewCellDelegate {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .background
        return tableView
    }()
    
    var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    var loadMoreSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
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
    
    var foodResponse = FoodSearchResponse(
        totalHits: 0,
        currentPage: 1,
        totalPages: 0,
        foodParts: []
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
    
    var isLoadingMore = false {
        didSet {
            if self.isLoadingMore {
                self.loadMoreSpinner.startAnimating()
            } else  {
                self.loadMoreSpinner.stopAnimating()
            }
        }
    }

    var query: String?
    var foodService: FoodService
    let userProfile: UserProfile
    let dataTypes: [DataType] = [.foundation, .branded]
    private var currentLoadTask: Task<Void, Never>?
    weak var addFoodDelegate: AddFoodDetailViewControllerDelegate?

    init(foodService: FoodService, userProfile: UserProfile) {
        self.foodService = foodService
        self.userProfile = userProfile
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = loadMoreSpinner
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.reuseIdentifier)
        tableView.register(LoadMoreTableViewCell.self, forCellReuseIdentifier: LoadMoreTableViewCell.reuseIdentifier)

        view.addSubview(tableView)
        view.addSubview(contentUnavailableView)
        view.addSubview(spinner)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentUnavailableView.topAnchor.constraint(equalTo: view.topAnchor),
            contentUnavailableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentUnavailableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentUnavailableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        ])

        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: didTapCancelButton())
    }
    
    // MARK: - Data Fetching
    func loadFood(query: String) async {
        currentLoadTask?.cancel() // cancel any existing task
        currentLoadTask = Task {
            self.isLoading = true
            defer { self.isLoading = false }

            do {
                self.query = query
                self.foodResponse = try await foodService.getFoods(
                    query: query,
                    dataTypes: dataTypes,
                    pageSize: 8,
                    pageNumber: 1
                )
                self.foodResponse.currentPage += 1
            } catch is CancellationError {
                print("Initial load canceled")
                return
            } catch {
                self.foodResponse = FoodSearchResponse(totalHits: 0, currentPage: 1, totalPages: 0, foodParts: [])
                print("Error loading food:", error)
            }

            self.contentUnavailableView.isHidden = self.foodResponse.foods.count > 0
            self.tableView.reloadData()
        }
    }
        
    // MARK: - Data Fetching
    func loadMoreFood(query: String) {
        guard !isLoadingMore,
              foodResponse.currentPage <= foodResponse.totalPages else { return }

        currentLoadTask?.cancel() // cancel existing load
        currentLoadTask = Task {
            self.isLoadingMore = true
            defer { self.isLoadingMore = false }
            
            do {
                let response = try await foodService.getFoods(
                    query: query,
                    dataTypes: dataTypes,
                    pageSize: 8,
                    pageNumber: foodResponse.currentPage
                )
                
                let start = self.foodResponse.foods.count
                let newItems = response.foods
                let end = start + newItems.count
                
                self.foodResponse.foods.append(contentsOf: newItems)
                self.foodResponse.currentPage += 1
                
                let paths = (start..<end).map { IndexPath(row: $0, section: 0) }
                
                self.contentUnavailableView.isHidden = self.foodResponse.foods.count > 0
                self.tableView.insertRows(at: paths, with: .automatic)

            } catch is CancellationError {
                print("Load more canceled")
                return
            } catch {
                print("Error loading more food:", error)
            }
        }
    }
    
    func didTapCancelButton() -> UIAction {
        return UIAction { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - ResultTableViewCellDelegate

    func resultTableViewCell(_ cell: ResultTableViewCell, didTapAddButton: Bool) {

    }
}

// MARK: - UITableViewDataSource
extension ResultsPaginatedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
        if foodResponse.currentPage < foodResponse.totalPages {
            return foodResponse.foods.count + 1
        } else {
            return foodResponse.foods.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if foodResponse.currentPage < foodResponse.totalPages && indexPath.row == foodResponse.foods.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadMoreTableViewCell.reuseIdentifier, for: indexPath) as! LoadMoreTableViewCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.reuseIdentifier, for: indexPath) as! ResultTableViewCell
        let item = foodResponse.foods[indexPath.row]
        cell.update(with: item)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let query else { return nil }
        if foodResponse.foods.count == 0 {
            return "No results for “\(query)”"
        }
        return "Results for \"\(query)\" (\(foodResponse.totalHits))"
    }
    
}


extension ResultsPaginatedViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if foodResponse.currentPage < foodResponse.totalPages && indexPath.row == foodResponse.foods.count {
//            didTapLoadMoreButton()
//            return
//        }
//                
//        let foodItem = foodResponse.foods[indexPath.row]
//        // TODO: Make food and recipe version
//        let addFoodDetailViewController = AddFoodDetailViewController(foodEntry: nil, fdcFood: foodItem, meal: nil, userProfile: userProfile, foodService: foodService, selectedFoodPortion: foodItem.selectedFoodPortion)
//        addFoodDetailViewController.delegate = addFoodDelegate
////        addFoodDetailViewController.dismissDelegate = self
////        addFoodDetailViewController.historyDelegate = historyDelegate
//
//        present(UINavigationController(rootViewController: addFoodDetailViewController), animated: true)
//    }
    
    func didTapLoadMoreButton() {
        guard let query else { return }
        loadMoreFood(query: query)
    }
}

extension ResultsPaginatedViewController: ViewControllerDismissDelegate {
    func viewControllerDidDismiss(_ viewController: UIViewController) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
