//
//  SearchIngredientViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/26/25.
//

import UIKit
import VisionKit
import CoreData

class SearchIngredientViewController: SearchItemTableViewController {
        
    var recipeEntry: FoodEntry
    
    init(
        recipeEntry: FoodEntry,
        foodService: FoodService,
        userProfile: UserProfile
    ) {
        self.recipeEntry = recipeEntry
        super.init(foodService: foodService, userProfile: userProfile, visibleTabs: [.all, .myFoods], visibleButtonTypes: [.barcode, .quickAdd, .addFood])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButtonRowView.delegate = self
        title = "Add Ingredient"
        
        resultsPaginatedViewController = IngredientsResultViewController(recipeEntry: recipeEntry, userProfile: userProfile, foodService: foodService)
        resultsPaginatedViewController.addFoodDelegate = addFoodDelegate
//        resultsPaginatedViewController.resultDelegate = resultDelegate
//        
        searchController = UISearchController(searchResultsController: resultsPaginatedViewController)
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.placeholder = "Search ingredients"
        
        navigationItem.searchController = searchController
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didTapBarcodeButton() {
        guard scannerAvailable else {
            // TODO: Show alert
            return
        }
        // works: ean13
        //fails: ean8 (doesn
        let scannerViewController = DataScannerViewController(
            recognizedDataTypes: [.barcode()],
            isHighFrameRateTrackingEnabled: false,
            isHighlightingEnabled: true)
        
        scannerViewController.delegate = self
        try? scannerViewController.startScanning()
        present(scannerViewController, animated: true) {
            // Add overlay after presentation
            let overlay = ScannerOverlayView()
            overlay.isUserInteractionEnabled = false
            overlay.backgroundColor = .clear
            overlay.translatesAutoresizingMaskIntoConstraints = false

            scannerViewController.view.addSubview(overlay)
            
            NSLayoutConstraint.activate([
                overlay.topAnchor.constraint(equalTo: scannerViewController.view.topAnchor),
                overlay.bottomAnchor.constraint(equalTo: scannerViewController.view.bottomAnchor),
                overlay.leadingAnchor.constraint(equalTo: scannerViewController.view.leadingAnchor),
                overlay.trailingAnchor.constraint(equalTo: scannerViewController.view.trailingAnchor)
            ])
        }
    }
    
    override func handleBarcodeScan(barcodeID: String) {
        searchTask?.cancel()
        searchTask = Task {
            print("barcode", barcodeID)
            guard let food = try? await foodService.getFoods(query: barcodeID, dataTypes: [.branded], pageSize: 1, pageNumber: 1).foods.first
            else {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
                dismiss(animated: true)
                showFoodNotFoundAlert(id: barcodeID)
                return
            }

            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
            let addIngredientViewController = AddIngredientDetailViewController(recipeEntry: recipeEntry, foodEntry: nil, fdcFood: food, userProfile: userProfile, foodService: foodService)
            addIngredientViewController.addFoodDelegate = addFoodDelegate
//            let addFoodDetailViewController = AddFoodDetailViewController(fdcFood: food, meal: meal, userProfile: userProfile, foodService: foodService)
//            addFoodDetailViewController.delegate = addFoodDelegate
//            
            // Only 1 view controlelr can be presented at once. Dismiss the barcode scanning view
            dismiss(animated: true)
            present(UINavigationController(rootViewController: addIngredientViewController), animated: true)
        }
    }
    
    override func resultTableViewCell(_ cell: ResultTableViewCell, didTapAddButton: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }

        do {
            let history = fetchedResultsController.object(at: indexPath)
            guard let fdcFood =  history.foodEntry?.convertToFDCFood(),
                  let recipeContext: NSManagedObjectContext = recipeEntry.managedObjectContext else { return }
            
            let ingredientEntry = try foodService.addFood(fdcFood, with: fdcFood.selectedFoodPortion, quantity: fdcFood.quantity , context: recipeContext)   // add to recipe box
            ingredientEntry.index = Int16(recipeEntry.ingredients.count)   // setting relationship does change size of relationship
            ingredientEntry.parent = recipeEntry
            recipeEntry.addToIngredients_(ingredientEntry)  // maybe unnecessarry
            
            // add to history in main
            foodService.addHistoryIfNeeded(fdcFood: fdcFood, context: CoreDataStack.shared.context)
            CoreDataStack.shared.saveContext() // save history
            
            self.addFoodDelegate?.addFoodDetailViewController(self, didAddFood: ingredientEntry)
        } catch {
            print("Error adding food: \(error)")
        }
    }
}

extension SearchIngredientViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let history = fetchedResultsController.object(at: indexPath)
        guard let foodEntry = history.foodEntry,
              var food = foodEntry.convertToFDCFood()
        else { return }
        
        // Add from my collection
        let addIngredientDetailViewController = AddIngredientDetailViewController(recipeEntry: recipeEntry, foodEntry: foodEntry, fdcFood: food, userProfile: userProfile, foodService: foodService)
        addIngredientDetailViewController.addFoodDelegate = addFoodDelegate
        addIngredientDetailViewController.dismissDelegate = self
        present(UINavigationController(rootViewController: addIngredientDetailViewController), animated: true)
    }
}

extension SearchIngredientViewController: SearchButtonRowViewDelegate {
    func searchButtonRowView(_ sender: SearchButtonRowView, didTapButton type: SearchButtonRowView.SearchButtonType) {
        // TODO: Maybe in future, can make it update diary
        switch type {
        case .barcode:
            didTapBarcodeButton()
        case .quickAdd:
            let quickAddIngredientViewController = QuickAddIngredientViewController(recipeEntry: recipeEntry)
            quickAddIngredientViewController.addFoodDelegate = addFoodDelegate
            present(UINavigationController(rootViewController: quickAddIngredientViewController), animated: true)
        case .addRecipe:
            return
        case .addFood:
            let createIngredientViewController = CreateIngredientViewController(recipeEntry: recipeEntry)
            createIngredientViewController.addFoodDelegate = addFoodDelegate
            present(UINavigationController(rootViewController: createIngredientViewController), animated: true)
            return
        }
    }

}
