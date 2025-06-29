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

    @FetchRequest(sortDescriptors: [])
    private var userProfiles: FetchedResults<UserProfile>
    @State private var selectedFilter: SelectedFilter = .week

    var userProfile: UserProfile? {
        userProfiles.first
    }
    
    var goal: Double {
        return userProfile?.userNutrientGoals[nutrientId]?.value ?? 0
    }
    
    var latestMealPlan: MealPlan? {
        mealPlans.first
    }
    
    
    let nutrientId: NutrientId
    
    init(nutrientId: NutrientId) {
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
                        Text("/ \(goal.trimmed) \(nutrientId.unitName)")
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
                    
                    RuleMark(y: .value("Goal", goal))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundStyle(.gray)
                        .annotation(position: .top, alignment: .leading) {
                            Text("Goal: \(goal.trimmed) \(nutrientId.unitName)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                }
                .chartYScale(domain: 0...(goal * 1.25))
                .frame(height: 300)
                .foregroundStyle(nutrientId.progressColor)
                .padding()
                .background(Color(UIColor(hex: "#252525")), in: RoundedRectangle(cornerRadius: 8))
                .padding(.bottom, 12)
                
//                Divider()
//                    .padding(.bottom, 12)
                
                NutrientProgressListView(filteredData: filteredData, nutrientId: nutrientId)
            }
            .padding([.horizontal, .bottom])
            .animation(.default, value: mealPlans.count) // animation trigger when value changes
        }
        .navigationTitle(nutrientId.description)
        .background(Color(UIColor(hex: "#1c1c1e")))
        .toolbar {
            ToolbarItem {
                Button("Edit") {
                    
                }
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
//                .opacity(i < filteredData.count - 1 ? 1 : 0)
        }
    }
}
//
//struct ProgressChartView: View {
//    var filteredData: [UserWeight]
//
//    
//    var body: some View {
//        Chart(filteredData) { userWeight in
//            LineMark(
//                x: .value("Date", userWeight.date_ ?? Date(), unit: .day),
//                y: .value("Weight", userWeight.weightInKg)
//            )
//            .symbol(Circle().strokeBorder(lineWidth: 2))
//            .symbolSize(CGSize(width: 6, height: 6))
//        }
//        .chartYScale(domain: .automatic(includesZero: false))
//        .frame(height: 300)
//    }
//}
//
//
//enum SelectedFilter: String, CaseIterable, Identifiable {
//    case all
//    case week
//    case month
//    case sixMonth
//    case year
//    var id: Self { self }
//    
//    var description: String {
//        switch self {
//        case .all:
//            return "All"
//        case .week:
//            return "Week"
//        case .month:
//            return "Month"
//        case .sixMonth:
//            return "6m"
//        case .year:
//            return "Year"
//        }
//    }
//}
//
//func formatDateMonthDayYear(_ date: Date) -> String {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "MMM d, yyyy"
//    return dateFormatter.string(from: date)
//}
