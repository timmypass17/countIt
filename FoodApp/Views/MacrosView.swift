//
//  MacroView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/10/24.
//

import SwiftUI
import Charts

//class MacroData: ObservableObject {
//    @Published var amount: Float
//    @Published var goal: Float
//    var name: String
//    
//    init(amount: Float, goal: Float, name: String) {
//        self.amount = amount
//        self.goal = goal
//        self.name = name
//    }
//}

struct MacroData {
    var amount: Float
    var goal: Float
    var name: String
}


struct MacrosView: View {
    static let reuseIdentifier = "MacrosView"
    
    var calories: MacroData
    var carbs: MacroData
    var protein: MacroData
    var fats: MacroData
    
    var body: some View {
        Grid(horizontalSpacing: 20) {
            GridRow {
                CircularProgressView(title: "Calories", current: calories.amount, total: calories.goal, color: .blue, unitName: "cal")
                CircularProgressView(title: "Carbs", current: carbs.amount, total: carbs.goal, color: .yellow, unitName: "g")
                CircularProgressView(title: "Protein", current: protein.amount, total: protein.goal, color: .pink, unitName: "g")
                CircularProgressView(title: "Fat", current: fats.amount, total: fats.goal, color: .green, unitName: "g")
            }
        }
    }
}

struct CaloriesRemainingView: View {
    static let reuseIdentifier = "CaloriesRemainingView"
    
    // TODO: Change this to calories, and breakfast...
    var caloriesGoal: Int
    
    var caloriesRemaining: Int {
        return caloriesGoal - caloriesConsumed
    }
    
    var caloriesConsumed: Int {
        return data.map { $0.amount }.reduce(0, +)
    }
    
    var data: [CaloriesRemainingItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Calories Consumed")
                .foregroundStyle(.secondary)
                .padding(.bottom, 12)
            
            HStack(alignment: .lastTextBaseline) {
                Text("\(caloriesConsumed)")
                    .font(.system(size: 50, weight: .semibold))
                //                Text("cal")
                //                    .bold()
                VStack(alignment: .leading) {
                    Text("cal")
                        .bold()
                    Text("/ 2000")
                        .bold()
                        .foregroundStyle(.secondary)
                }
//                Text("cal")
//                    .bold()
            }
            .padding(.bottom, 12)
            
            Chart {
                ForEach(data, id: \.name) { item in
                    BarMark(
                        x: .value("Amount", item.amount),
                        y: .value("Type", "Calories")
                    )
                    .foregroundStyle(by: .value("Name", item.name))
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
            
//            HStack {
//                Image(systemName: "trophy")
//                    .foregroundStyle(.yellow)
//                Text("Great! You're on track to losing weight.")
//                Spacer()
//            }
//            .background {
//                RoundedRectangle(cornerRadius: 4, style: .continuous)
//                    .fill(Color.yellow.opacity(0.5))
//            }
        }
        .padding(.vertical, 8)
    }
}

struct CaloriesRemainingItem {
    var amount: Int
    var name: String
}


//    Chart {
//        // Amount bar
//        RectangleMark(
//            xStart: .value("Start", 0),
//            xEnd: .value("End", calories.amount),
//            y: .value("Macro", "Calories")
//        )
//        .foregroundStyle(.blue)
//        .cornerRadius(4)
//
//        // Remaining bar
//        RectangleMark(
//            xStart: .value("Start", calories.amount),
//            xEnd: .value("End", calories.goal),
//            y: .value("Macro", "Calories")
//        )
//        .foregroundStyle(Color.gray.opacity(0.2))
//        .cornerRadius(4)
//    }
//    .frame(height: 65)
//    .chartXScale(domain: 0...calories.goal)
//    .chartYAxis(.hidden)

//VStack(alignment: .leading) {
//    Text("Calories Left")
//    HStack(alignment: .bottom) {
//        Text("\(caloriesRemaining)")
//        Text("cal")
//    }
//
//    Chart(data, id: \.name) {
//
//        BarMark(
//            x: .value("Amount", $0.amount)
//        )
//        .foregroundStyle(by: .value("Status", $0.name))
//
//    }
//    .frame(height: 100)
//
//}
