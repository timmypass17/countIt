//
//  ProgressDetailView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/28/25.
//

import SwiftUI
import Charts

struct ProgressDetailView: View {

    @FetchRequest(sortDescriptors: [SortDescriptor(\.date_, order: .reverse)])
    private var mealPlans: FetchedResults<MealPlan>
    
    @State private var selectedFilter: SelectedFilter = .week
    @State var isPresentingEditSheet = false
    
    // Don't pass UserProfile, updating relationship doesn't trigger ui uipdates, pass UserNutrientGoal directly
    // works - userNutrientGoal.value = amount
    // does not work - userProfile.nutrientGoals[nutrientId].value = amount
    @StateObject var userNutrientGoal: UserNutrientGoal

    var latestMealPlan: MealPlan? {
        mealPlans.first
    }
    
    let nutrientId: NutrientId
    
    init(userNutrientGoal: UserNutrientGoal, nutrientId: NutrientId) {
        self._userNutrientGoal = StateObject(wrappedValue: userNutrientGoal)
        self.nutrientId = nutrientId
    }
    
    var filteredMealPlan: [MealPlan] {
        switch selectedFilter {
        case .all:
            return Array(mealPlans)
        case .week:
            guard let weekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date()) else { return [] }
            return mealPlans.filter { $0.date_ ?? .distantPast >= weekAgo }
        case .month:
            guard let monthAgo = Calendar.current.date(byAdding: .month, value: -1, to: Date()) else { return [] }
            return mealPlans.filter { $0.date_ ?? .distantPast >= monthAgo }
        case .year:
            guard let yearAgo = Calendar.current.date(byAdding: .year, value: -1, to: Date()) else { return [] }
            return mealPlans.filter { $0.date_ ?? .distantPast >= yearAgo }
        case .sixMonth:
            guard let sixMonthsAgo = Calendar.current.date(byAdding: .month, value: -6, to: Date()) else { return [] }
            return mealPlans.filter { $0.date_ ?? .distantPast >= sixMonthsAgo }
        }
    }
    
    var filteredData: [WeeklyData] {
        return filteredMealPlan.map { WeeklyData(date: $0.date, amount: $0.nutrientAmount(nutrientId)) }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                FilterSegmentedView(selectedFilter: $selectedFilter)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Image(systemName: nutrientId.symbol)
                            .foregroundStyle(nutrientId.progressColor)

                        Text(nutrientId.description)
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                    
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("\(filteredMealPlan.first?.nutrientAmount(nutrientId).trimmed ?? "-")")
                            .font(.title)
                            .fontWeight(.semibold)
                        Text("/ \(userNutrientGoal.value.trimmed) \(nutrientId.unitName)")
                            .foregroundColor(.secondary)
                            .font(.title2)
                    }
                    
                    Text("\(formatDateMonthDayYear(filteredMealPlan.last?.date_ ?? Date())) - \(formatDateMonthDayYear(filteredMealPlan.first?.date_ ?? Date()))")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                        .padding(.top, 2)
                }
                .padding(.vertical, 8)
                

                Chart(filteredData) { item in
                    BarMark(
                        x: .value("Date", item.date, unit: .day),
                        y: .value("Amount", item.amount)
                    )
                    
                    RuleMark(y: .value("Goal", userNutrientGoal.value))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundStyle(.gray)
                        .annotation(position: .top, alignment: .leading) {
                            Text("Goal: \(userNutrientGoal.value.trimmed) \(nutrientId.unitName)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                }
                .chartYScale(domain: 0...(max(userNutrientGoal.value, filteredMealPlan.max { $0.nutrientAmount(nutrientId) < $1.nutrientAmount(nutrientId) }?.nutrientAmount(nutrientId) ?? userNutrientGoal.value) * 1.25))
                .frame(height: 300)
                .foregroundStyle(nutrientId.progressColor)
                .padding()
                .background(Color(UIColor(hex: "#252525")), in: RoundedRectangle(cornerRadius: 8))
                .padding(.bottom, 12)

                NutrientProgressListView(filteredData: filteredData, nutrientId: nutrientId)
            }
            .padding([.horizontal, .bottom])
            .animation(.default, value: mealPlans.count) // animation trigger when value changes
        }
        .navigationTitle(nutrientId.description)
        .background(Color(UIColor(hex: "#1c1c1e")))
        .toolbar {
            ToolbarItem {
                Button("Set Goal") {
                    isPresentingEditSheet.toggle()
                }
            }
        }
        .sheet(isPresented: $isPresentingEditSheet) {
            UpdateNutrientView(primaryText: nutrientId.shortDescription, initialAmount: userNutrientGoal.value, unit: nutrientId.unitName) { amount in
                userNutrientGoal.value = amount
                CoreDataStack.shared.saveContext()
                NotificationCenter.default.post(name: .mealPlanUpdated, object: nil)
            }
        }
    }
}

struct NutrientProgressListView: View {
    @Environment(\.colorScheme) var colorScheme

    var filteredData: [WeeklyData]
    let nutrientId: NutrientId

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("History")
                
                Spacer()
                
                Text("\(filteredData.count) Entries")
            }
            .foregroundColor(.secondary)
            .font(.caption)
            .padding(.bottom, 6)
            .padding(.horizontal, 12)
            
            LazyVStack(spacing: 0) {
                ForEach(Array(filteredData.enumerated()), id: \.offset) { i, item in
                    NutrientProgressListCell(item: item, nutrientId: nutrientId)
                }
            }
            .background(Color(UIColor(hex: "#252525")), in: RoundedRectangle(cornerRadius: 8))
        }
    }
}

struct NutrientProgressListCell: View {
    @Environment(\.colorScheme) var colorScheme
    let item: WeeklyData
    let nutrientId: NutrientId
    
    func weightStringFormat(weight: Float) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = weight.truncatingRemainder(dividingBy: 1) == 0 ? 0 : 2
        return numberFormatter.string(from: NSNumber(value: weight)) ?? ""
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(item.amount.trimmed) \(nutrientId.unitName)")
                        .font(.headline)
                    
                    Text(item.date.formatted(date: .abbreviated, time: .omitted))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                Spacer()
            }
            .padding()
            
            Divider()
                .padding(.horizontal)
//                .opacity(i < filteredData.count - 1 ? 1 : 0)
        }
    }
}
