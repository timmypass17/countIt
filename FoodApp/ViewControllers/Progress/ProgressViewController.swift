//
//  ProgressViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/6/25.
//

import UIKit
import SwiftUI

class ProgressViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .secondarySystemGroupedBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var nutrientIds: [NutrientId] = NutrientId.allProgress
    let foodService: FoodService
    let userProfile: UserProfile
    var mealPlans: [MealPlan?] = [] // oldest -> recent
    
    init(foodService: FoodService, userProfile: UserProfile) {
        self.foodService = foodService
        self.userProfile = userProfile
        super.init(nibName: nil, bundle: nil)
        getCurrentWeekMealPlans()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getCurrentWeekMealPlans() {
        var mealPlans: [MealPlan?] = []

        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        // Force start of the week to Sunday
        let weekday = calendar.component(.weekday, from: today)
        let daysFromSunday = weekday - 1 // Sunday = 1, so offset = 0
        guard let sunday = calendar.date(byAdding: .day, value: -daysFromSunday, to: today) else { return }

        for offset in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: offset, to: sunday) {
                let mealPlan: MealPlan? = foodService.getMealPlan(date: date)
                mealPlans.append(mealPlan)
            }
        }

        self.mealPlans = mealPlans
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ProgressTableViewCell.self, forCellReuseIdentifier: ProgressTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self

        navigationItem.title = "Goals"
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", primaryAction: nil)
    }
}

extension ProgressViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return nutrientIds.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProgressTableViewCell.reuseIdentifier, for: indexPath) as! ProgressTableViewCell
        let nutrientId = nutrientIds[indexPath.section]
        let recentAmount = mealPlans.last??.nutrientAmount(nutrientId) ?? 0

        // TODO: Pass in last 7 days value
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)

        // Get Sunday (start of current week)
        let weekday = calendar.component(.weekday, from: today) // Sunday = 1
        let daysFromSunday = weekday - 1
        let sunday = calendar.date(byAdding: .day, value: -daysFromSunday, to: today)!

        let data = mealPlans.enumerated().map { index, mealPlan in
            let date = calendar.date(byAdding: .day, value: index, to: sunday)!
            
            let amount = mealPlan?.nutrientAmount(nutrientId) ?? 0
            
            return WeeklyData(
                date: date,
                amount: amount
            )
        }

        cell.update(title: nutrientId.description, date: .now, amount: recentAmount, unit: nutrientId.unitName, data: data, goal: userProfile.userNutrientGoals[nutrientId]?.value ?? 0, color: nutrientId.progressColor, icon: nutrientId.symbol)
        return cell
    }
    
}

extension ProgressViewController: UITableViewDelegate {
//    // Set spacing between sections (i.e., between your single-row cells)
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 1 // Adjust to your desired spacing
//    }
//    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let spacer = UIView()
//        spacer.backgroundColor = .clear // or match your table background
//        return spacer
//    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let nutrientId = nutrientIds[section]
        return nutrientId.footerText
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nutrientId = nutrientIds[indexPath.section]
        let progressView = ProgressDetailView(nutrientId: nutrientId)
        let hostingController = UIHostingController(rootView: progressView
            .environment(\.managedObjectContext, CoreDataStack.shared.persistentContainer.viewContext))
        navigationController?.pushViewController(hostingController, animated: true)
    }
}
