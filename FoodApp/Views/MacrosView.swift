//
//  MacroView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/10/24.
//

import SwiftUI
import Charts

class MacrosViewModel: ObservableObject {
    @Published var nutrients: [NutrientId: Double]

    init(nutrients: [NutrientId: Double]) {
        self.nutrients = nutrients
    }
}

struct MacrosView: View {
    static let reuseIdentifier = "MacrosView"
    
    @FetchRequest
    var meals: FetchedResults<Meal>
    
    var userProfile: UserProfile
    
    var mealPlan: MealPlan?
    
    @ObservedObject var model: MacrosViewModel

//    var nutrients: [NutrientId: Double]?

    let nutrientIds: [NutrientId] = [.calories, .carbs, .protein, .fatTotal]
    
    init(mealPlan: MealPlan?, userProfile: UserProfile, model: MacrosViewModel) {
        self.model = model
        self.userProfile = userProfile
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
                    let consumed = model.nutrients[nutrientId] ?? Double((getNutrientConsumed(nutrientId)))
                    let goal = mealPlan?.nutrientGoals[nutrientId]?.value ??
                               userProfile.userNutrientGoals[nutrientId]?.value ?? 0
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

