//
//  MacroMediumView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/19/25.
//

import SwiftUI
import Charts

// TODO: Try using user defaults
struct MacroMediumView: View {
    var entry: Provider.Entry
    
    var meals: [Meal]
    var mealPlan: MealPlan
    let appTheme: AppTheme

    var mealColors: [Color] {
        [
            appTheme.color1.color,
            appTheme.color2.color,
            appTheme.color3.color,
            appTheme.color4.color
        ]
        
    }
    
    init(entry: Provider.Entry) {
        self.entry = entry
        self.mealPlan = entry.mealPlan
        self.meals = entry.mealPlan.meals
        self.appTheme = entry.appTheme
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
                    .foregroundStyle(appTheme.color1.color)

                Text("Calories Consumed")
                    .foregroundColor(appTheme.secondary.color)
                    .font(.subheadline)
            }
            .padding(.bottom, 8)
//
            HStack(alignment: .lastTextBaseline) {
                Text("\(Int(caloriesConsumed))")
                    .font(.system(size: 36, weight: .semibold))
                    .foregroundStyle(appTheme.label.color)
                    .contentTransition(.numericText())
                    .animation(.default, value: caloriesConsumed)
                VStack(alignment: .leading) {
                    Text("cal")
                        .font(.system(size: 16))
                        .bold()
                        .foregroundStyle(appTheme.label.color)
                    Text("/ \(Int(caloriesGoal))")
                        .font(.system(size: 16, weight: .bold))
                        .bold()
                        .foregroundStyle(appTheme.secondary.color)
                }
            }
            .padding(.bottom, 8)
            
            VStack(alignment: .leading, spacing: 8) {
                Chart {
                    if caloriesConsumed < caloriesGoal {
                        BarMark(
                            xStart: .value("Amount", 0),
                            xEnd: .value("Goal", caloriesGoal),
                            y: .value("Type", "Calories"),
                            height: 24
                        )
                        .foregroundStyle(appTheme.progress.color)
                        .cornerRadius(4)
                    }
                    
                    ForEach(Array(sortedMeals.enumerated()), id: \.element) { index, meal in
                        // sum of previous meals
                        let prevSum = sortedMeals
                            .prefix(index)
                            .reduce(0) { $0 + $1.nutrientAmount(.calories) }
                        
                        let amount = meal.nutrientAmount(.calories)
                        let remaining = caloriesGoal - prevSum
                        let clamped = min(max(remaining, 0), amount)

                        if clamped > 0 {
                            BarMark(
                                x: .value("Amount", clamped),
                                y: .value("Type", "Calories"),
                                height: 24
                            )
                            .foregroundStyle(by: .value("Meal", meal.name))
                            .cornerRadius(4)
                        }
                    }

                }
                .frame(height: 50) // fixed chart height
                .chartXScale(domain: 0...caloriesGoal)
                .chartYAxis(.hidden)
                .chartForegroundStyleScale(
                    domain: sortedMealColorPairs.map { $0.0 },
                    range: sortedMealColorPairs.map { $0.1 }
                )
                .chartLegend(.hidden)
                .chartXAxis {
                    AxisMarks { value in
                        AxisGridLine()
                            .foregroundStyle(appTheme.secondary.color)
                        AxisTick()
                            .foregroundStyle(appTheme.secondary.color)
                        AxisValueLabel()
                            .foregroundStyle(appTheme.secondary.color)
                    }
                }

                // Have to make separate legend, messes up chart height when legend expands
//                TagCloudView(tags: sortedMealColorPairs)
            }
        }
    }
}

