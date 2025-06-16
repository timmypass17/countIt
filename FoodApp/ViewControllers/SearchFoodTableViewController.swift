//
//  SearchFoodTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/1/24.
//

import UIKit
import VisionKit
import CoreData

class SearchFoodTableViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .secondarySystemGroupedBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var history: [FoodEntry] = []
    var myRecipes: [FoodEntry] = []
    var myFoods: [FoodEntry] = []
    var selectedTab: SearchTabView.TabItem = .all
    
    var searchController: UISearchController!
    private var resultsTableController: ResultsTableViewController!
    var historyFRC: NSFetchedResultsController<History>! // source of truth
    var foodFRC: NSFetchedResultsController<FoodEntry>?

    var meal: Meal?
    let foodService: FoodService
    var searchTask: Task<Void, Never>? = nil
    var debounceTimer: Timer?
    
    weak var addFoodDelegate: AddFoodDetailViewControllerDelegate?
    weak var quickAddDelegate: QuickAddTableViewControllerDelegate?
    weak var resultDelegate: ResultTableViewCellDelegate?

    var scannerAvailable: Bool {
        DataScannerViewController.isSupported &&
        DataScannerViewController.isAvailable
    }
    
    init(foodService: FoodService, meal: Meal? = nil) {
        self.history = []
        self.foodService = foodService
        self.meal = meal
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1c1c1e")
        tableView.dataSource = self
        tableView.delegate = self

        let searchTabView = SearchTabView()
        searchTabView.translatesAutoresizingMaskIntoConstraints = false
        searchTabView.delegate = self
        
        view.addSubview(searchTabView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchTabView.topAnchor.constraint(equalTo: view.topAnchor),
            searchTabView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTabView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: searchTabView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.reuseIdentifier)
        if let meal, let meals = meal.mealPlan?.meals {
            let titleView = SearchTitleView(selectedMeal: meal, meals: meals)
            titleView.delegate = self
            navigationItem.titleView = titleView
        }
        tableView.backgroundColor = UIColor(hex: "#1c1c1e")
        
        resultsTableController = ResultsTableViewController(meal: meal, foodService: foodService)
        resultsTableController.addFoodDelegate = addFoodDelegate
        resultsTableController.resultDelegate = resultDelegate
        
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        
        // Place the search bar in the navigation bar.
        navigationItem.searchController = searchController
        
        // Make the search bar always visible.
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
        
        // TODO: use pallete colors
        let barcodeButton = UIBarButtonItem(image: UIImage(systemName: "barcode.viewfinder"), primaryAction: didTapBarcodeButton())
        let quickAddButton = UIBarButtonItem(image: UIImage(systemName: "flame"), primaryAction: didTapQuickAddButton())
        navigationItem.rightBarButtonItems = [barcodeButton, quickAddButton]
        navigationItem.rightBarButtonItem?.isEnabled = scannerAvailable
        
        let fetchRequest: NSFetchRequest<History> = History.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "createdAt_", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        historyFRC = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: CoreDataStack.shared.context,
            sectionNameKeyPath: nil,    // to define sections
            cacheName: nil)

        historyFRC.delegate = self
        
        // Perform a fetch.
        do {
            // actually fetches from cloudkit, when delete and reinstall app
            try historyFRC?.performFetch()
//            contentUnavailableView.isHidden = !(fetchedResultsController.fetchedObjects?.isEmpty ?? true)
        } catch {
            // Handle error appropriately. It's useful to use
            // `fatalError(_:file:line:)` during development.
            fatalError("Failed to perform fetch: \(error.localizedDescription)")
        }
    }

    func didTapBarcodeButton() -> UIAction {
        return UIAction { [self] _ in
            guard scannerAvailable else { return }
            // works: ean13
            //fails: ean8 (doesn
            let viewController = DataScannerViewController(
                recognizedDataTypes: [.barcode()],
                qualityLevel: .accurate,
                recognizesMultipleItems: false,
                isHighFrameRateTrackingEnabled: false,
                isHighlightingEnabled: true)
            
            viewController.delegate = self
            try? viewController.startScanning()
            present(viewController, animated: true)

        }
    }
    
    func didTapQuickAddButton() -> UIAction {
        return UIAction { [self] _ in
            guard let meal else { return }
            let quickAddTableViewController = QuickAddTableViewController(meal: meal)
            quickAddTableViewController.delegate = quickAddDelegate
            present(UINavigationController(rootViewController: quickAddTableViewController), animated: true)
        }
    }
    
}

extension SearchFoodTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return historyFRC.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = historyFRC?.sections?[section] else {
            return 0
        }
        
        return sectionInfo.numberOfObjects
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.reuseIdentifier, for: indexPath) as! HistoryTableViewCell
        cell.delegate = self
        let history = historyFRC.object(at: indexPath)
        cell.update(history: history)
        cell.backgroundColor = UIColor(hex: "#252525")
        return cell
    }
    
}

extension SearchFoodTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let history = historyFRC.object(at: indexPath)
        guard let food = history.foodEntry?.convertToFDCFood() else { return }
        print(food.fdcId)
        let addFoodDetailViewController = AddFoodDetailViewController(fdcFood: food, meal: meal, foodService: foodService)
        addFoodDetailViewController.delegate = addFoodDelegate
        present(UINavigationController(rootViewController: addFoodDetailViewController), animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recently Added"
    }
}

extension SearchFoodTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    // Find out when the fetched results controller adds, removes, moves, or updates a fetched object.
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .fade)
        case .delete:
            guard let indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .update:
            guard let indexPath else { return }
            // Update the cell as the specified indexPath.
            print("Update row: \(indexPath)")
            if let cell = tableView.cellForRow(at: indexPath) as? HistoryTableViewCell {
                let history = historyFRC.object(at: indexPath)
                cell.update(history: history)
            }
        case .move:
            guard let indexPath, let newIndexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        @unknown default:
            break
        }
    }
}
    


// MARK: - UISearchBarDelegate

extension SearchFoodTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTask?.cancel()
        searchTask = Task {
            do {
                resultsTableController.spinner.startAnimating()
                async let bestMatchFoodItems: FoodSearchResponse = try await foodService.getFoods(query: searchBar.text!, dataTypes: ResultsTableViewController.Section.bestMatch.dataTypes, pageSize: 3, pageNumber: 1)
                async let moreResultsFoodItems: FoodSearchResponse = try await foodService.getFoods(query: searchBar.text!, dataTypes: ResultsTableViewController.Section.moreResults.dataTypes, pageSize: 8, pageNumber: 1)
                resultsTableController.bestMatchResponse = try await bestMatchFoodItems
                resultsTableController.moreResultsResponse = try await moreResultsFoodItems
                resultsTableController.query = searchBar.text!
                resultsTableController.tableView.reloadData()
            } catch {
                print("Error searching foods: \(error)")
            }
            resultsTableController.spinner.stopAnimating()
        }
        searchBar.resignFirstResponder()
    }
    
}

extension SearchFoodTableViewController: SearchTitleViewDelegate {
    func searchTitleView(_ sender: SearchTitleView, didSelectMeal meal: Meal) {
        self.meal = meal
    }
}

extension SearchFoodTableViewController: HistoryTableViewCellDelegate {
    func historyTableViewCell(_ cell: HistoryTableViewCell, didSelectDeleteButton: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let history = historyFRC.object(at: indexPath)
        CoreDataStack.shared.context.delete(history)
        CoreDataStack.shared.saveContext()
    }
}

extension SearchFoodTableViewController: DataScannerViewControllerDelegate {
    func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
        // Implement this delegate method to disable or remove the data-scanning controls in your interface.
        // For example, the scanner calls this method when users tap Don’t Allow the first time the system prompt appears, as described in Provide a reason for using the camera.
        navigationItem.rightBarButtonItem?.isEnabled = scannerAvailable
    }
    
    func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
        guard let item = addedItems.first else { return }
        dataScanner.stopScanning()
        
        if case .barcode(let barcode) = item {
            searchTask?.cancel()
            searchTask = Task {
//                guard var barcodeID = barcode.payloadStringValue else { return }
//                // Convert from EDA-13 (13 digits) to UPC (12 digits)
//                if barcodeID.first == "0" {
//                    barcodeID.removeFirst()
//                }
//                print("barcode", barcodeID)
//                guard let food = try? await foodService.getFoods(query: barcodeID, dataTypes: DataType.allCases).first
//                else {
//                    let generator = UIImpactFeedbackGenerator(style: .medium)
//                    generator.impactOccurred()
//                    dismiss(animated: true)
//                    showFoodNotFoundAlert(id: barcodeID)
//                    return
//                }
//                
//                let generator = UIImpactFeedbackGenerator(style: .medium)
//                generator.impactOccurred()
                
//                let foodDetailViewController = FoodDetailTableViewController(food: food, meal: meal, foodService: foodService)
//                foodDetailViewController.delegate = delegate
//                foodDetailViewController.historyDelegate = self
//                
//                // Only 1 view controlelr can be presented at once. Dismiss the barcode scanning view
//                dismiss(animated: true)
//                present(UINavigationController(rootViewController: foodDetailViewController), animated: true)
            }
        }
    }
    
    func showFoodNotFoundAlert(id: String) {
//        "This item is not in the database.\n\(id)"
        let alert = UIAlertController(title: "Item not found", message: "This item is not in the database. Please try using the search bar to find a similar product.\n\(id)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it!", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension SearchFoodTableViewController: DiaryViewControllerDelegate {
    func diaryViewController(_ viewController: DiaryViewController, mealPlanChanged mealPlan: MealPlan) {
        guard let meal = mealPlan.meals.first else { return }
        self.meal = meal

        let titleView = SearchTitleView(selectedMeal: meal, meals: mealPlan.meals)
        titleView.delegate = self
        navigationItem.titleView = titleView
    }
    
}

extension SearchFoodTableViewController: SearchTabViewDelegate {
    
    func searchTabView(_ sender: SearchTabView, didSelectTab tab: SearchTabView.TabItem) {
        self.selectedTab = tab
        updateFetchedResultsController(for: tab)
    }
    
    func updateFetchedResultsController(for tab: SearchTabView.TabItem) {
        switch tab {
        case .all:
            let fetchRequest: NSFetchRequest<History> = History.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt_", ascending: false)]
            historyFRC = NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: CoreDataStack.shared.context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
        case .myFoods:
            let fetchRequest: NSFetchRequest<FoodEntry> = FoodEntry.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "isCustom == true")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            foodFRC = NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: CoreDataStack.shared.context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
        default:
            break
        }

        // Example assumes only one is active; adapt logic accordingly
        try? historyFRC?.performFetch()
        try? foodFRC?.performFetch()

        tableView.reloadData()
    }
}
