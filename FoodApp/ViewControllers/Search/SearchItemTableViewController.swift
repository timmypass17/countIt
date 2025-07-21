//
//  SearchFoodTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/1/24.
//

import UIKit
import VisionKit
import CoreData

class SearchItemTableViewController: UIViewController, DataScannerViewControllerDelegate, ResultTableViewCellDelegate {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = Settings.shared.currentTheme.background.uiColor
        return tableView
    }()
    
    private var contentUnavailableView: UIContentUnavailableView = {
        var configuration = UIContentUnavailableConfiguration.empty()
        let view = UIContentUnavailableView(configuration: configuration)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private let overlay = ScannerOverlayView()
    
    var history: [FoodEntry] = []
    var myRecipes: [FoodEntry] = []
    var myFoods: [FoodEntry] = []
    var searchButtonRowView: SearchButtonRowView
    var searchTabView: SearchTabView
    var selectedTab: SearchTabView.TabItem = .all
    
    var searchController: UISearchController!
    var resultsPaginatedViewController: ResultsPaginatedViewController!
    var fetchedResultsController: NSFetchedResultsController<History>! // source of truth

//    var meal: Meal?   addFood
//    var foodEntry: FoodEntry?
    let userProfile: UserProfile
    let foodService: FoodService
    let visibleTabs: [SearchTabView.TabItem]
    let visibleButtonTypes: [SearchButtonRowView.SearchButtonType]
    var searchTask: Task<Void, Never>? = nil
    var debounceTimer: Timer?
    
    weak var addFoodDelegate: AddFoodDetailViewControllerDelegate?
    weak var quickAddDelegate: QuickAddItemControllerDelegate?
    weak var resultDelegate: ResultTableViewCellDelegate?

    var scannerAvailable: Bool {
        DataScannerViewController.isSupported &&
        DataScannerViewController.isAvailable
    }
    
    init(
        foodService: FoodService,
        userProfile: UserProfile,
        visibleTabs: [SearchTabView.TabItem],
        visibleButtonTypes: [SearchButtonRowView.SearchButtonType]
    ) {
        self.foodService = foodService
        self.userProfile = userProfile
        self.visibleTabs = visibleTabs
        self.visibleButtonTypes = visibleButtonTypes
        self.searchTabView = SearchTabView(visibleTabs: visibleTabs)
        self.searchButtonRowView = SearchButtonRowView(visibleButtonTypes: visibleButtonTypes)
        super.init(nibName: nil, bundle: nil)
    }
    
    // TODO: UserProfile
//    init(
//        foodService: FoodService,
//        meal: Meal? = nil,
//        foodEntry: FoodEntry? = nil,    // create recipe
//        userProfile: UserProfile,
//        visibleTabs: [SearchTabView.TabItem] = SearchTabView.TabItem.allCases,
//        visibleButtonTypes: [SearchButtonRowView.SearchButtonType] = SearchButtonRowView.SearchButtonType.allCases
//    ) {
//        self.history = []
//        self.foodService = foodService
//        self.meal = meal
//        self.foodEntry = foodEntry
//        self.userProfile = userProfile
//        self.visibleTabs = visibleTabs
//        self.visibleButtonTypes = visibleButtonTypes
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    deinit {
//        print("timmy deinit SearchFoodTableViewController")
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Settings.shared.currentTheme.background.uiColor
        tableView.dataSource = self
        tableView.delegate = self

//        let searchTabView = SearchTabView(visibleTabs: visibleTabs)
        searchTabView.translatesAutoresizingMaskIntoConstraints = false
        searchTabView.delegate = self
//        searchButtonRowView.delegate = self
        searchButtonRowView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(searchTabView)
        view.addSubview(searchButtonRowView)
        view.addSubview(tableView)
        view.addSubview(contentUnavailableView)

        NSLayoutConstraint.activate([
            searchTabView.topAnchor.constraint(equalTo: view.topAnchor),
            searchTabView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTabView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            searchButtonRowView.topAnchor.constraint(equalTo: searchTabView.bottomAnchor),
            searchButtonRowView.leadingAnchor.constraint(equalTo: searchTabView.leadingAnchor),
            searchButtonRowView.trailingAnchor.constraint(equalTo: searchTabView.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: searchButtonRowView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentUnavailableView.topAnchor.constraint(equalTo: searchButtonRowView.bottomAnchor),
            contentUnavailableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentUnavailableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentUnavailableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.reuseIdentifier)
        tableView.backgroundColor = Settings.shared.currentTheme.background.uiColor

        // Place the search bar in the navigation bar.
        navigationItem.searchController = searchController
        
        // Make the search bar always visible.
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
        
        updateFetchedResultsController(for: .all)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateUI),
                                               name: .themeUpdated,
                                               object: nil)
    }
    
    @objc func updateUI() {
        print("timmy search reload")
        view.backgroundColor = Settings.shared.currentTheme.background.uiColor
        tableView.backgroundColor = Settings.shared.currentTheme.background.uiColor
        tableView.reloadData()
        searchTabView.updateUI()
        searchButtonRowView.updateUI()
    }
    
    func updateUnavailableView() {
        switch selectedTab {
        case .all:
            updateUnavailableView(text: "No Foods Yet", secondaryText: "Foods and recipes you add will appear here", image: UIImage(systemName: "tray"))
        case .myRecipes:
            updateUnavailableView(text: "No Recipes Yet", secondaryText: "Create custom recipes by combining foods", image: UIImage(systemName: "book"))
        case .myFoods:
            updateUnavailableView(text: "No Foods Yet", secondaryText: "Create your own custom food", image: UIImage(systemName: "fork.knife"))
        }
    }
    
    func updateUnavailableView(text: String, secondaryText: String? = nil, image: UIImage? = nil) {
        var config = UIContentUnavailableConfiguration.empty()
        config.text = text
        config.secondaryText = secondaryText
        config.image = image
        
        contentUnavailableView.configuration = config
        
        self.contentUnavailableView.isHidden = !(self.fetchedResultsController.fetchedObjects?.isEmpty ?? true)
    }

    func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
        // Implement this delegate method to disable or remove the data-scanning controls in your interface.
        // For example, the scanner calls this method when users tap Don’t Allow the first time the system prompt appears, as described in Provide a reason for using the camera.
        navigationItem.rightBarButtonItem?.isEnabled = scannerAvailable
    }
    
    func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
        guard let item = addedItems.first else { return }
        
        dataScanner.stopScanning()
        
        if case .barcode(let barcode) = item {
            guard var barcodeID = barcode.payloadStringValue else { return }
            // Convert from EDA-13 (13 digits) to UPC (12 digits)
            if barcodeID.first == "0" {
                barcodeID.removeFirst()
            }
            handleBarcodeScan(barcodeID: barcodeID)
        }
    }
    
    func handleBarcodeScan(barcodeID: String) {
        // overridden in subclass
    }
    
    func showFoodNotFoundAlert(id: String) {
//        "This item is not in the database.\n\(id)"
        let alert = UIAlertController(title: "Item not found", message: "This item is not in the database. Please try using the search bar to find a similar product.\n\(id)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it!", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func resultTableViewCell(_ cell: ResultTableViewCell, didTapAddButton: Bool) {
        // override
    }
    
}

extension SearchItemTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = fetchedResultsController?.sections?[section] else {
            return 0
        }
        
        return sectionInfo.numberOfObjects
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.reuseIdentifier, for: indexPath) as! HistoryTableViewCell
        cell.delegate = self
        let history = fetchedResultsController.object(at: indexPath)
        cell.update(history: history)
        return cell
    }
}

extension SearchItemTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let history = fetchedResultsController.object(at: indexPath)
        guard let foodEntry = history.foodEntry,
              var food = foodEntry.convertToFDCFood()
        else { return }
        
        if let selectedFoodPortion = food.foodPortions.first(where: { $0.id == foodEntry.portionId }) {
            food.selectedFoodPortion = selectedFoodPortion
        } else {
            // May be custom user generated
            food.selectedFoodPortion = FoodPortion(id: Int(foodEntry.portionId), amount: foodEntry.amount, gramWeight: foodEntry.gramWeight, modifier: foodEntry.modifier)
        }
        
//        let addFoodDetailViewController = AddFoodDetailViewController(foodEntry: history.foodEntry, fdcFood: food, meal: meal, userProfile: userProfile, foodService: foodService, selectedFoodPortion: food.selectedFoodPortion)
//        addFoodDetailViewController.delegate = addFoodDelegate
//        addFoodDetailViewController.dismissDelegate = self
//        present(UINavigationController(rootViewController: addFoodDetailViewController), animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard (fetchedResultsController.fetchedObjects?.count ?? 0) > 0 else { return nil }
        
        switch selectedTab {
        case .all:
            return "My Collection"
        case .myRecipes:
            return "My Recipes"
        case .myFoods:
            return "My Foods"
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let history = fetchedResultsController.object(at: indexPath)
//            // Delete ingredients (have to manuall
//            let ingredients = history.foodEntry?.ingredients ?? []
//            for ingredient in ingredients {
//                CoreDataStack.shared.context.delete(ingredient)
//            }
            CoreDataStack.shared.context.delete(history)
            CoreDataStack.shared.saveContext()
        }
    }
}

extension SearchItemTableViewController: ViewControllerDismissDelegate {
    func viewControllerDidDismiss(_ viewController: UIViewController) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension SearchItemTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        tableView.endUpdates()
        updateUnavailableView()
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
                let history = fetchedResultsController.object(at: indexPath)
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

extension SearchItemTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTask?.cancel()
        searchTask = Task {
            do {
                await resultsPaginatedViewController.loadFood(query: searchBar.text!)
                
//                resultsTableController.spinner.startAnimating()
                // TODO: searching egg doesnt work
//                resultsTableController.searchResponse = try await foodService.getFoods(query: searchBar.text!, dataTypes: [.foundation, .branded, .survey], pageSize: 10, pageNumber: 1)
//                resultsTableController.contentUnavailableView.isHidden = resultsTableController.searchResponse.foods.count > 0
//                resultsTableController.query = searchBar.text!
//                resultsTableController.tableView.reloadData()
            } catch {
                print("Error searching foods: \(error)")
            }
//            resultsTableController.spinner.stopAnimating()
        }
        searchBar.resignFirstResponder()
    }
    
}

extension SearchItemTableViewController: SearchTabViewDelegate {
    
    func searchTabView(_ sender: SearchTabView, didSelectTab tab: SearchTabView.TabItem) {
        self.selectedTab = tab
        updateFetchedResultsController(for: tab)
    }
    
    func updateFetchedResultsController(for tab: SearchTabView.TabItem) {
        let request: NSFetchRequest<History> = History.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \History.createdAt_, ascending: false)]
        
        switch tab {
        case .all:
            let excludesMyRecipes = !visibleTabs.contains(.myRecipes)

            if excludesMyRecipes {
                // Show only custom foods, not recipes
                request.predicate = NSPredicate(
                    format: "foodEntry.isRecipe == %@", NSNumber(value: false)
                )
            } else {
                // Show all food entries
                request.predicate = nil
            }
        case .myRecipes:
            request.predicate = NSPredicate(format: "foodEntry.isRecipe == %@ AND foodEntry.isCustom == %@",
                                            NSNumber(value: true),  NSNumber(value: true))
        case .myFoods:
            request.predicate = NSPredicate(format: "foodEntry.isRecipe == %@ AND foodEntry.isCustom == %@",
                                            NSNumber(value: false),  NSNumber(value: true))
        }

        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: CoreDataStack.shared.context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
            updateUnavailableView()
            tableView.reloadData()
        } catch {
            print("Fetch failed: \(error)")
        }
    }
}

extension SearchItemTableViewController: CreateItemViewControllerDelegate {
    func createItemViewController(_ viewController: CreateItemViewController, didCreateFood foodEntry: FoodEntry) {
        addFoodDelegate?.addFoodDetailViewController(self, didAddFood: foodEntry)
    }
}

extension SearchItemTableViewController: QuickAddItemControllerDelegate {
    func quickAddItemViewController(_ viewController: QuickAddItemViewController, didAddFoodEntry foodEntry: FoodEntry) {
        addFoodDelegate?.addFoodDetailViewController(self, didAddFood: foodEntry)
    }
}

class ScannerOverlayView: UIView {
    
    // Define the size of the transparent scan area
    private let scanRect = CGRect(x: 0, y: 0, width: 250, height: 150)

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Define full-screen path
        let path = UIBezierPath(rect: rect)
        
        // Center the scan area
        let scanAreaOrigin = CGPoint(
            x: (rect.width - scanRect.width) / 2,
            y: (rect.height - scanRect.height) / 2
        )
        let scanArea = CGRect(origin: scanAreaOrigin, size: scanRect.size)
        
        // Add rounded cutout path
        let cutoutPath = UIBezierPath(roundedRect: scanArea, cornerRadius: 12)
        path.append(cutoutPath)
        path.usesEvenOddFillRule = true

        // Create a shape layer mask
        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = .evenOdd
        fillLayer.fillColor = UIColor.black.withAlphaComponent(0.6).cgColor
        
        // Apply the mask
        layer.sublayers?.forEach { $0.removeFromSuperlayer() } // remove previous
        layer.addSublayer(fillLayer)
    }
}

