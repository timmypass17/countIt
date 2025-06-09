//
//  MacroView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/10/24.
//

import SwiftUI
import Charts

struct MacrosView: View {
    static let reuseIdentifier = "MacrosView"
    
    @FetchRequest
    var meals: FetchedResults<Meal>
    
    var mealPlan: MealPlan?
    var nutrients: [NutrientId: Double]?

    let nutrientIds: [NutrientId] = [.calories, .carbs, .protein, .fatTotal]
    
    init(mealPlan: MealPlan?, nutrients: [NutrientId: Double]? = nil) {
        self.nutrients = nutrients
        if let mealPlan {
            self.mealPlan = mealPlan
            _meals = FetchRequest(fetchRequest: Meal.fetchMeals(for: mealPlan))
        } else {
            _meals = FetchRequest(fetchRequest: Meal.emptyFetchRequest())
        }
    }

    var body: some View {
        Grid(horizontalSpacing: 20) {
            GridRow {
                ForEach(nutrientIds, id: \.rawValue) { nutrientId in
                    let consumed = nutrients?[nutrientId] ?? Double((getNutrientConsumed(nutrientId)))
                    let goal = Float(mealPlan?.nutrientGoals[nutrientId]?.value ?? 0)
                    
                    CircularProgressView(
                        title: nutrientId.shortDescription,
                        current: Float(consumed),
                        total: Float(goal),
                        color: nutrientId.color,
                        unitName: nutrientId.unitName
                    )
                }
            }
        }
        .padding(.vertical, 4)
    }
    
    func getNutrientConsumed(_ nutrientId: NutrientId) -> Double {
        var total = 0.0
        for meal in meals {
            total += meal.nutrientAmount(nutrientId)
        }
        return total
    }
}

