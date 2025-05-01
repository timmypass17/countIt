////
////  MacroWidget.swift
////  FoodApp
////
////  Created by Timmy Nguyen on 4/6/24.
////
//
//import SwiftUI
//
//struct MacroMediumView: View {
//    var entry: Provider.Entry
//    
//    var body: some View {
//        let calories = MacroData(amount: entry.mealPlan?.getTotalNutrients(.calories) ?? 0, goal: entry.mealPlan?.nutrientGoals[.calories] ?? 0)
//        let carbs = MacroData(amount: entry.mealPlan?.getTotalNutrients(.carbs) ?? 0, goal: entry.mealPlan?.nutrientGoals[.carbs] ?? 0)
//        let protein = MacroData(amount: entry.mealPlan?.getTotalNutrients(.protein) ?? 0, goal: entry.mealPlan?.nutrientGoals[.protein] ?? 0)
//        let fats = MacroData(amount: entry.mealPlan?.getTotalNutrients(.totalFat) ?? 0, goal: entry.mealPlan?.nutrientGoals[.totalFat] ?? 0)
//        
//        VStack(alignment: .leading) {
//            HStack(alignment: .firstTextBaseline) {
//                Label("Macros", systemImage: "fork.knife")
//                    .font(.system(size: 16))
//
//                Spacer()
//                Text("Today at \(Date().formatted(date: .abbreviated, time: .omitted))")
//                    .foregroundStyle(.secondary)
//                    .font(.caption)
//            }
//            
//            Spacer()
//            
//            MacrosView(calories: calories, carbs: carbs, protein: protein, fats: fats)
//                .font(.system(size: 16))
//        }
//    }
//}
//
//struct MacroSmallView: View {
//    var entry: SingleMacroProvider.Entry
//    
//    let progressSize: CGFloat = 24
//    let totalSize: CGFloat = 12
//    let titleSize: CGFloat = 16
//    var lineWidth: CGFloat = 8
//    
//    var body: some View {
//        let nutrient = MacroData(amount: entry.mealPlan?.getTotalNutrients(entry.nutrient.nutrientID) ?? 0, goal: entry.mealPlan?.nutrientGoals[entry.nutrient.nutrientID] ?? 0)
//
//        VStack(spacing: 12) {
//            
//            ZStack {
//                Circle()
//                    .stroke(
//                        entry.nutrient.color.opacity(0.1),
//                        lineWidth: lineWidth
//                    )
//                Circle()
//                    .trim(from: 0, to: CGFloat(nutrient.amount / nutrient.goal))
//                    .stroke(
//                        entry.nutrient.color,
//                        style: StrokeStyle(
//                            lineWidth: lineWidth,
//                            lineCap: .round
//                        )
//                    )
//                    .rotationEffect(.degrees(-90))
//                    .animation(.easeOut, value: nutrient.amount / nutrient.goal)
//                VStack {
//                    Group {
//                        if nutrient.amount > 1 {
//                            Text("\(Int(nutrient.amount))")
//                        } else {
//                            Text("\(nutrient.amount.formattedString(decimalPlaces: 1))")
//                        }
//                    }
//                    .fontWeight(.semibold)
//                    .font(.system(size: progressSize))
//                    
//                    Text("\(nutrient.goal.formatted(.number)) \(entry.nutrient.nutrientID.unit)")
//                        .foregroundStyle(.secondary)
//                        .font(.system(size: totalSize))
//                }
//            }
//            
//            Label("\(entry.nutrient.nutrientID.description)", systemImage: "fork.knife")
//                .font(.system(size: titleSize))
//
////            Text(entry.nutrient.nutrientID.description)
////                .font(.system(size: titleSize))
//        }
//    }
//}
//
