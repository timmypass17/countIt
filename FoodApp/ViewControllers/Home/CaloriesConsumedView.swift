//
//  CaloriesConsumedView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/19/25.
//

import SwiftUI
import Charts

import SwiftUI
import Charts

struct CaloriesConsumedView: View {
    static let reuseIdentifier = "CaloriesConsumedView"

    @FetchRequest
    var meals: FetchedResults<Meal>

    var mealPlan: MealPlan

    // Notion Dark Mode-Inspired Colors
    let mealColors: [Color] = [
        Color(hex: "#2E8AFF"), // Blue
        Color(hex: "#F5A623"), // Yellow
        Color(hex: "#FF6B6B"), // Red
        Color(hex: "#29CC7A")  // Green
    ]
    
    init(mealPlan: MealPlan) {
        self.mealPlan = mealPlan
        _meals = FetchRequest(fetchRequest: Meal.fetchMeals(for: mealPlan))
    }
    
    var caloriesRemaining: Double {
        return caloriesGoal - caloriesConsumed
    }

    var caloriesGoal: Double {
        return mealPlan.nutrientGoals[.calories]?.value ?? 0
    }

    var caloriesConsumed: Double {
        return mealPlan.nutrientAmount(.calories)
    }

    // Sorted meals by index
    var sortedMeals: [Meal] {
        meals.sorted { $0.index < $1.index }
    }

    // Map sorted meal names to color
    var sortedMealColorPairs: [(String, Color)] {
        sortedMeals.enumerated().map { (i, meal) in
            (meal.name, mealColors[i % mealColors.count])
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: NutrientId.calories.symbol)
                    .foregroundStyle(NutrientId.calories.progressColor)

                Text("Calories Consumed")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
            .padding(.bottom, 12)
            
            HStack(alignment: .lastTextBaseline) {
                Text("\(Int(caloriesConsumed))")
                    .font(.system(size: 42, weight: .semibold))
                VStack(alignment: .leading) {
                    Text("cal")
                        .bold()
                    Text("/ \(Int(caloriesGoal))")
                        .bold()
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.bottom, 12)

            Chart {
                ForEach(sortedMeals, id: \.self) { meal in
                    BarMark(
                        x: .value("Amount", min(meal.nutrientAmount(.calories), caloriesGoal)),
                        y: .value("Type", "Calories")
                    )
                    .foregroundStyle(by: .value("Meal", meal.name))
                    .cornerRadius(4)
                }
                
                if caloriesConsumed < caloriesGoal {
                    BarMark(
                        xStart: .value("Amount", 0),
                        xEnd: .value("Goal", caloriesGoal),
                        y: .value("Type", "Calories")
                    )
                    .foregroundStyle(Color.gray.opacity(0.2))
                    .cornerRadius(4)
                }
            }
            .frame(height: 65)
            .chartXScale(domain: 0...caloriesGoal)
            .chartYAxis(.hidden)
            .chartLegend(.visible)
            .chartForegroundStyleScale(
                domain: sortedMealColorPairs.map { $0.0 },
                range: sortedMealColorPairs.map { $0.1 }
            )
        }
        .padding(.vertical, 8)
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}
