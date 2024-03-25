//
//  MacroView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/10/24.
//

import SwiftUI

class MacroData: ObservableObject {
    @Published var amount: Float
    @Published var goal: Float
    
    init(amount: Float, goal: Float) {
        self.amount = amount
        self.goal = goal
    }
}
struct MacrosView: View {
    static let reuseIdentifier = "MacrosView"
    
    @ObservedObject var calories: MacroData
    @ObservedObject var carbs: MacroData
    @ObservedObject var protein: MacroData
    @ObservedObject var fats: MacroData

    var body: some View {
        Grid(horizontalSpacing: 24) {
            GridRow {
                CircularProgressView(title: "Calories", current: calories.amount, total: calories.goal, color: .blue)
                CircularProgressView(title: "Carbs", current: carbs.amount, total: carbs.goal, color: .yellow)
                CircularProgressView(title: "Protein", current: protein.amount, total: protein.goal, color: .pink)
                CircularProgressView(title: "Fat", current: fats.amount, total: fats.goal, color: .green)
            }
        }
    }
}
