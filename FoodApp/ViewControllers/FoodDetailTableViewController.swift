//
//  FoodDetailTableViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/3/24.
//

import UIKit

class FoodDetailTableViewController: UITableViewController {

    var food: Food?
    var foodID: Int
    let foodService = FoodService()
    
    init(foodID: Int) {
        self.foodID = foodID
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFood(id: foodID)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    private func loadFood(id: Int) {
        Task {
            do {
                food = try await foodService.getFood(id: id)
                tableView.reloadData()
            } catch {
                print("Error getting food: \(foodID)")
            }
        }
    }

}
