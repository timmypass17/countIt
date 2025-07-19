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
        Settings.shared.currentTheme.color1.color,
        Settings.shared.currentTheme.color2.color,
        Settings.shared.currentTheme.color3.color,
        Settings.shared.currentTheme.color4.color
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
                    .foregroundStyle(Settings.shared.currentTheme.color1.color)

                Text("Calories Consumed")
                    .foregroundColor(Settings.shared.currentTheme.secondary.color)
                    .font(.subheadline)
            }
            .padding(.bottom, 12)
            
            HStack(alignment: .lastTextBaseline) {
                Text("\(Int(caloriesConsumed))")
                    .font(.system(size: 42, weight: .semibold))
                    .foregroundStyle(Settings.shared.currentTheme.label.color)
                    .contentTransition(.numericText())
                    .animation(.default, value: caloriesConsumed)
                VStack(alignment: .leading) {
                    Text("cal")
                        .bold()
                        .foregroundStyle(Settings.shared.currentTheme.label.color)
                    Text("/ \(Int(caloriesGoal))")
                        .bold()
                        .foregroundStyle(Settings.shared.currentTheme.secondary.color)
                }
            }
            .padding(.bottom, 12)
            
            VStack(alignment: .leading, spacing: 8) {
                Chart {
                    if caloriesConsumed < caloriesGoal {
                        BarMark(
                            xStart: .value("Amount", 0),
                            xEnd: .value("Goal", caloriesGoal),
                            y: .value("Type", "Calories"),
                            height: 24
                        )
                        .foregroundStyle(Settings.shared.currentTheme.progress.color)
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

                // Have to make separate legend, messes up chart height when legend expands
                TagCloudView(tags: sortedMealColorPairs)
            }
        }
        .padding(.vertical, 8)
    }
}

struct WrapLegend: View {
    let sortedMealColorPairs: [(String, Color)]

    var body: some View {
        // Auto-wrapping horizontal legend
        LazyVGrid(columns: [], alignment: .leading, spacing: 8) {
            ForEach(sortedMealColorPairs, id: \.0) { name, color in
                HStack(spacing: 4) {
                    Circle()
                        .fill(color)
                        .frame(width: 8, height: 8)
                    Text(name)
                        .font(.caption2)
                }
            }
        }
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

struct TagCloudView: View {
    var tags: [(String, Color)]

    @State private var totalHeight
          = CGFloat.zero       // << variant for ScrollView/List
    //    = CGFloat.infinity   // << variant for VStack

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.tags, id: \.0) { tag in
                HStack(spacing: 4) {
                    Circle()
                        .fill(tag.1)
                        .frame(width: 8, height: 8)
                    Text(tag.0)
                        .font(.caption2)
                        .foregroundStyle(Settings.shared.currentTheme.secondary.color)
                }
                .padding([.horizontal, .vertical], 4)
                .alignmentGuide(.leading, computeValue: { d in
                    if (abs(width - d.width) > g.size.width)
                    {
                        width = 0
                        height -= d.height
                    }
                    let result = width
                    if tag == self.tags.last! {
                        width = 0 //last item
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: {d in
                    let result = height
                    if tag == self.tags.last! {
                        height = 0 // last item
                    }
                    return result
                })
            }
        }.background(viewHeightReader($totalHeight))
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

