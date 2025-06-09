//
//  CaloriesConsumedView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/19/25.
//

import SwiftUI
import Charts

struct CaloriesConsumedView: View {
    static let reuseIdentifier = "CaloriesConsumedView"
    
    @FetchRequest
    var meals: FetchedResults<Meal> // when meal changes (e.g. includes food added/removed but does not see deeper relationship automatically, ui changes
    
    var mealPlan: MealPlan

    init(mealPlan: MealPlan) {
        self.mealPlan = mealPlan
        _meals = FetchRequest(fetchRequest: Meal.fetchMeals(for: mealPlan))
    }
    
    var caloriesRemaining: Int {
        return caloriesGoal - caloriesConsumed
    }
    
    var caloriesGoal: Int {
        return Int(mealPlan.nutrientGoals[.calories]?.value ?? 0)
    }
    
    var caloriesConsumed: Int {
        return Int(mealPlan.nutrientAmount(.calories))
    }
        
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Calories Consumed")
                .foregroundStyle(.secondary)
                .padding(.bottom, 12)
            
            HStack(alignment: .lastTextBaseline) {
                Text("\(caloriesConsumed)")
                    .font(.system(size: 42, weight: .semibold))
                VStack(alignment: .leading) {
                    Text("cal")
                        .bold()
                    Text("/ \(caloriesGoal)")
                        .bold()
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.bottom, 12)
            
            Chart {
                ForEach(meals) { meal in
                    BarMark(
                        x: .value("Amount", meal.nutrientAmount(.calories)),
                        y: .value("Type", "Calories")
                    )
                    .foregroundStyle(by: .value("Name", meal.name))
                    .cornerRadius(4)
                }
                
                BarMark(
                    x: .value("Goal", caloriesRemaining),
                    y: .value("Type", "Calories")
                )
                .foregroundStyle(Color.gray.opacity(0.2))
                .cornerRadius(4)

            }
            .frame(height: 65)
            .chartXScale(domain: 0...caloriesGoal)
            .chartYAxis(.hidden)
        }
        .padding(.vertical, 8)
    }
}
