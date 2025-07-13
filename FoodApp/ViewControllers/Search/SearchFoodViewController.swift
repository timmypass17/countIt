//
//  SearchFoodViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/2/25.
//

import UIKit
import VisionKit

class SearchFoodViewController: SearchItemTableViewController {
    
    // Initally meal can mealplan not loaded yet
    var meal: Meal?
    var searchTitleView: SearchTitleView?
    
    init(
        meal: Meal?,
        foodService: FoodService,
        userProfile: UserProfile
    ) {
        self.meal = meal
    
        
        super.init(foodService: foodService, userProfile: userProfile, visibleTabs: [.all, .myRecipes, .myFoods], visibleButtonTypes: [.barcode, .quickAdd, .addRecipe, .addFood])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButtonRowView.delegate = self

        let foodResultsViewController = FoodResultsViewController(meal: meal, foodService: foodService, userProfile: userProfile)
        foodResultsViewController.addFoodDelegate = addFoodDelegate
        resultsPaginatedViewController = foodResultsViewController
//        resultsPaginatedViewController.resultDelegate = resultDelegate
        
        searchController = UISearchController(searchResultsController: resultsPaginatedViewController)
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.placeholder = "Search food"
        
        if let meal, let meals = meal.mealPlan?.meals {
            searchTitleView = SearchTitleView(selectedMeal: meal, meals: meals)
            searchTitleView?.delegate = self
            navigationItem.titleView = searchTitleView
        }
        
        navigationItem.searchController = searchController
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateUI() {
        super.updateUI()
        searchTitleView?.updateUI()
    }

    override func handleBarcodeScan(barcodeID: String) {
        searchTask?.cancel()
        searchTask = Task {
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

            let addFoodDetailViewController = AddFoodDetailViewController(fdcFood: food, meal: meal, userProfile: userProfile, foodService: foodService)
            addFoodDetailViewController.delegate = addFoodDelegate
            
            // Only 1 view controlelr can be presented at once. Dismiss the barcode scanning view
            dismiss(animated: true)
            present(UINavigationController(rootViewController: addFoodDetailViewController), animated: true)
        }
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
    
    override func resultTableViewCell(_ cell: ResultTableViewCell, didTapAddButton: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
//
//        do {
//            // Add food to meal
//            let food = try foodService.addFood(fdcFood, foodEntry: foodEntry, with: fdcFood.selectedFoodPortion, quantity: fdcFood.quantity, to: meal, context: CoreDataStack.shared.context)
//            // Add to history
//            foodService.addHistoryIfNeeded(fdcFood: fdcFood, context: CoreDataStack.shared.context)
//            CoreDataStack.shared.saveContext()
//            self.delegate?.addFoodDetailViewController(self, didAddFood: food)
//        } catch {
//            print("Error adding food: \(error)")
//        }
//        
        do {
            let history = fetchedResultsController.object(at: indexPath)
            guard let fdcFood =  history.foodEntry?.convertToFDCFood() else { return }

            let foodEntry = try foodService.addFood(fdcFood, foodEntry: history.foodEntry,  with: fdcFood.selectedFoodPortion, quantity: fdcFood.quantity, to: meal, context: CoreDataStack.shared.context)
            foodService.addHistoryIfNeeded(fdcFood: fdcFood, context: CoreDataStack.shared.context)
            
            CoreDataStack.shared.saveContext()
            addFoodDelegate?.addFoodDetailViewController(self, didAddFood: foodEntry)
        } catch {
            print("Error: \(error)")
        }
    }
}

extension SearchFoodViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let history = fetchedResultsController.object(at: indexPath)
        guard let foodEntry = history.foodEntry,
              var food = foodEntry.convertToFDCFood(),
              let selectedFoodPortion = food.foodPortions.first(where: { $0.id == foodEntry.portionId })
        else { return }
        
        food.selectedFoodPortion = selectedFoodPortion
        let addFoodDetailViewController = AddFoodDetailViewController(foodEntry: history.foodEntry, fdcFood: food, meal: meal, userProfile: userProfile, foodService: foodService)
        addFoodDetailViewController.delegate = addFoodDelegate
        addFoodDetailViewController.dismissDelegate = self
        present(UINavigationController(rootViewController: addFoodDetailViewController), animated: true)
    }
}

extension SearchFoodViewController: SearchTitleViewDelegate {
    func searchTitleView(_ sender: SearchTitleView, didSelectMeal meal: Meal) {
        self.meal = meal
    }
}

extension SearchFoodViewController: DiaryViewControllerDelegate {
    func diaryViewController(_ viewController: DiaryViewController, mealPlanChanged mealPlan: MealPlan) {
        guard let meal = mealPlan.meals.first else { return }
        self.meal = meal

        let titleView = SearchTitleView(selectedMeal: meal, meals: mealPlan.meals)
        titleView.delegate = self
        navigationItem.titleView = titleView
    }
    
}

extension SearchFoodViewController: SearchButtonRowViewDelegate {
    func searchButtonRowView(_ sender: SearchButtonRowView, didTapButton type: SearchButtonRowView.SearchButtonType) {
        // TODO: Maybe in future, can make it update diary
        switch type {
        case .barcode:
            didTapBarcodeButton()
        case .quickAdd:
            guard let meal else { return }
            let quickAddFoodViewController = QuickAddFoodViewController(meal: meal)
            quickAddFoodViewController.addFoodDelegate = addFoodDelegate
            present(UINavigationController(rootViewController: quickAddFoodViewController), animated: true)
            return
        case .addRecipe:
            guard let meal else { return }
            let createRecipeViewController = CreateRecipeViewController(meal: meal, userProfile: userProfile)
            createRecipeViewController.addFoodDelegate = addFoodDelegate
            present(UINavigationController(rootViewController: createRecipeViewController), animated: true)
        case .addFood:
            guard let meal else { return }
            let createFoodViewController = CreateFoodViewController(meal: meal)
            createFoodViewController.addFoodDelegate = addFoodDelegate
            present(UINavigationController(rootViewController: createFoodViewController), animated: true)
        }
    }
}
