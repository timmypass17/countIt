//
//  SearchFoodTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/1/24.
//

import UIKit

class SearchFoodTableViewController: UITableViewController {

    var history: [String] = ["Apple", "Banana", "Orange"]
    
    var searchController: UISearchController!
    private var resultsTableController: ResultsTableViewController!
    
    let foodService: FoodService
    var searchTask: Task<Void, Never>? = nil
    var debounceTimer: Timer?
    
    init(foodService: FoodService) {
        self.foodService = foodService
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ItemCell")
        
        resultsTableController = ResultsTableViewController(foodService: foodService)
        
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        
        // Place the search bar in the navigation bar.
        navigationItem.searchController = searchController
        
        // Make the search bar always visible.
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let product = history[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = product
        cell.contentConfiguration = config
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let food = history[indexPath.row]
//        let detailVC = FoodDetailTableViewController(food: food)
//        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}


// MARK: - UISearchBarDelegate

extension SearchFoodTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Task {
            do {
                let foodIDs = try await foodService.getFoodIDs(query: searchBar.text!)
                print(foodIDs.count)
                let foods: [Food] = try await foodService.getFoods(ids: foodIDs)
                for food in foods {
                    print(food.description)
                }
//                for food in foods {
//                    switch food {
//                    case .srLegacy(let sRLegacyFoodItem):
//                        print("SR Legacy: \(sRLegacyFoodItem.description)")
//                    case .branded(let brandedFoodItem):
//                        print("Branded: \(brandedFoodItem.description)")
//                    }
//                }
//                
//                for item in foodSearchResults {
//                    var food = try await foodService.getFood(id: item.fdcId)
//
//                    if let servingSize = item.servingSize,
//                       let servingSizeUnit = item.servingSizeUnit {
//                        let foodPortion = FoodPortion(portionDescription: nil, amount: nil, gramWeight: servingSize, modifier: servingSizeUnit)
//                        food.foodPortions.append(foodPortion)
//                    }
//                    
//                    // Filter duplicate portions
//                    var uniquePortions: [FoodPortion] = []
//                    var seen: Set<FoodPortion> = []
//                    for portion in food.foodPortions {
//                        if !seen.contains(portion) {
//                            uniquePortions.append(portion)
//                            seen.insert(portion)
//                        }
//                    }
//                    
//                    food.foodPortions = uniquePortions
//                        .sorted { $0.gramWeight < $1.gramWeight }
//                    
//                    models.append(FoodItem(foodSearchResults: item, food: food))
//                }
                        
                // Assuming resultsTableController is available in the scope
                resultsTableController.foods = foods
                resultsTableController.tableView.reloadData()
            } catch {
                print("\(#function) \(error)")
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Invalidate the previous timer if it exists
        debounceTimer?.invalidate()

        // Create a new timer
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            // Call your API here with the searchText
            print("fetchFood(\(searchText))")
        }
    }
    
}


// MARK: - UISearchControllerDelegate

// Use these delegate functions for additional control over the search controller.

extension SearchFoodTableViewController: UISearchControllerDelegate {
    
    func presentSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
}

