//
//  MacroView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/10/24.
//

import SwiftUI

struct MacrosView: View {
    static let reuseIdentifier = "MacrosView"
    
    var calories: (Float, UserNutrientGoal)
    var carbs: (Float, UserNutrientGoal)
    var protein: (Float, UserNutrientGoal)
    var fats: (Float, UserNutrientGoal)

    var body: some View {
        Grid(horizontalSpacing: 24) {
            GridRow {
                CircularProgressView(title: "Calories", current: calories.0, total: calories.1.goal, color: .blue)
                CircularProgressView(title: "Carbs", current: carbs.0, total: carbs.1.goal, color: .yellow)
                CircularProgressView(title: "Protein", current: protein.0, total: protein.1.goal, color: .pink)
                CircularProgressView(title: "Fat", current: fats.0, total: fats.1.goal, color: .green)
            }
        }
    }
}

//#Preview {
//    MacrosView(
//        calories: (105.0, UserNutrientGoal.sample),
//        carbs: (26.0, UserNutrientGoal.sample),
//        protein: (1.0, UserNutrientGoal.sample),
//        fats: (0.4, UserNutrientGoal.sample))
//}
