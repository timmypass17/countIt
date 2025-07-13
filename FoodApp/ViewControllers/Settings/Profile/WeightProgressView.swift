//
//  WeightProgressView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/13/25.
//

import SwiftUI
import Charts

struct WeightProgressView: View {

    @FetchRequest(sortDescriptors: [SortDescriptor(\.date_, order: .reverse)])
    private var userWeights: FetchedResults<UserWeight>
    @State private var selectedFilter: SelectedFilter = .week
    @State var isPresentingEditSheet = false

    let userProfile: UserProfile
    let foodService: FoodService
    
    var currentWeight: Double {
        switch userProfile.weightUnit {
        case .pounds:
//            print("Timmy weight \(userWeights.count): \(userWeights.last?.weightInKg)")
            return convertKilogramsToPounds(userWeights.first?.weightInKg ?? -1)
        case .kilograms:
            return userWeights.first?.weightInKg ?? -1
        }
    }
    
    var goalWeight: Double {
        return userProfile.goalWeight ?? 0
    }
    
    init(userProfile: UserProfile, foodService: FoodService) {
        self.userProfile = userProfile
        self.foodService = foodService
    }
    
    var filteredUserWeights: [UserWeight] {
        switch selectedFilter {
        case .all:
            return Array(userWeights)
        case .week:
            guard let weekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date()) else { return [] }
            return userWeights.filter { $0.date_ ?? .distantPast >= weekAgo }
        case .month:
            guard let monthAgo = Calendar.current.date(byAdding: .month, value: -1, to: Date()) else { return [] }
            return userWeights.filter { $0.date_ ?? .distantPast >= monthAgo }
        case .year:
            guard let yearAgo = Calendar.current.date(byAdding: .year, value: -1, to: Date()) else { return [] }
            return userWeights.filter { $0.date_ ?? .distantPast >= yearAgo }
        case .sixMonth:
            guard let sixMonthsAgo = Calendar.current.date(byAdding: .month, value: -6, to: Date()) else { return [] }
            return userWeights.filter { $0.date_ ?? .distantPast >= sixMonthsAgo }
        }
    }
    
    var filteredData: [WeeklyData] {
        return filteredUserWeights.compactMap {
            guard let date = $0.date_ else { return nil }
            let amount: Double
            switch userProfile.weightUnit {
            case .pounds:
                amount = convertKilogramsToPounds($0.weightInKg ?? 0)
            case .kilograms:
                amount = $0.weightInKg ?? 0
            }
            return WeeklyData(date: date, amount: amount)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                FilterSegmentedView(selectedFilter: $selectedFilter)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Image(systemName: "figure")
                            .foregroundStyle(.blue)

                        Text("Current Weight")
                            .foregroundColor(Settings.shared.currentTheme.secondary.color)
                            .font(.subheadline)
                    }
                    
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("\(currentWeight.trimmed)")
                            .font(.title)
                            .fontWeight(.semibold)
                        Text("/ \(goalWeight.trimmed) \(userProfile.weightUnit.singularSymbol)")
                            .foregroundColor(Settings.shared.currentTheme.secondary.color)
                            .font(.title2)
                    }
                    
                    Text("\(formatDateMonthDayYear(filteredUserWeights.last?.date_ ?? Date())) - \(formatDateMonthDayYear(filteredUserWeights.first?.date_ ?? Date()))")
                        .foregroundColor(Settings.shared.currentTheme.secondary.color)
                        .font(.subheadline)
                        .padding(.top, 2)
                }
                .padding(.vertical, 8)
                

                Chart(filteredData) { item in
                    LineMark(
                        x: .value("Date", item.date, unit: .day),
                        y: .value("Amount", item.amount)
                    )
                    
                    RuleMark(y: .value("Goal", userProfile.goalWeight ?? 0))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundStyle(.gray)
                        .annotation(position: .top, alignment: .leading) {
                            Text("Goal: \(goalWeight.trimmed) \(userProfile.weightUnit.rawValue)")
                                .font(.caption)
                                .foregroundColor(Settings.shared.currentTheme.secondary.color)
                        }
                }
//                .chartYScale(domain: 0...(max(userProfile.goalWeight, filteredUserWeights.max { $0.weightInKg < $1.weightInKg } ) * 1.25))
                .frame(height: 300)
//                .foregroundStyle(nutrientId.progressColor)
                .padding()
                .background(Settings.shared.currentTheme.cellBackground.color, in: RoundedRectangle(cornerRadius: 8))
                .padding(.bottom, 12)

                ProgressListView(filteredData: filteredData, unit: userProfile.weightUnit.singularSymbol)
            }
            .padding([.horizontal, .bottom])
            .animation(.default, value: filteredUserWeights.count) // animation trigger when value changes
        }
        .navigationTitle("Weight")
        .background(Settings.shared.currentTheme.background.color)
        .toolbar {
            ToolbarItem {
                Button {
                    isPresentingEditSheet.toggle()
                } label: {
                    Label("Add Weight", systemImage: "plus")
                        .labelStyle(.iconOnly)
                }
            }
        }
        .sheet(isPresented: $isPresentingEditSheet) {
            AddWeightView(userProfile: userProfile, foodService: foodService)
//            UpdateNutrientView(primaryText: nutrientId.shortDescription, initialAmount: userNutrientGoal.value, unit: nutrientId.unitName) { amount in
//                userNutrientGoal.value = amount
//                CoreDataStack.shared.saveContext()
//                NotificationCenter.default.post(name: .mealPlanUpdated, object: nil)
//            }
//            .presentationDetents([.medium])
        }
    }
}

struct FilterSegmentedView: View {
    @Binding var selectedFilter: SelectedFilter
    
    var body: some View {
        Picker("Time", selection: $selectedFilter) {
            ForEach(SelectedFilter.allCases) { time in
                Text(time.description)
            }
        }
        .pickerStyle(.segmented)
    }
}

struct ProgressHeaderView: View {
//    var filteredData: [UserWeight]
    var title: String
    var unit: String
    var amount: Double?
    var startDate: Date
    var endDate: Date
    
    var dateRangeString: String {
//        let startDate = filteredData.last?.date_ ?? Date()
//        let endDate = filteredData.first?.date_ ?? Date()
        return "\(formatDateMonthDayYear(startDate)) - \(formatDateMonthDayYear(endDate))"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .foregroundColor(Settings.shared.currentTheme.secondary.color)
                .font(.subheadline)
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("\(amount?.trimmed ?? "-")")
                    .font(.title)
                Text(unit)
                    .foregroundColor(Settings.shared.currentTheme.secondary.color)
            }
            
            Text(dateRangeString)
                .foregroundColor(Settings.shared.currentTheme.secondary.color)
                .font(.subheadline)
        }
        .padding(.vertical, 4)
    }
}

struct ProgressListView: View {
    @Environment(\.colorScheme) var colorScheme

    var filteredData: [WeeklyData]
    var unit: String

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("History")
                
                Spacer()
                
                Text("\(filteredData.count) Entries")
            }
            .foregroundColor(Settings.shared.currentTheme.secondary.color)
            .font(.caption)
            .padding(.bottom, 6)
            .padding(.horizontal, 12)
            
            LazyVStack(spacing: 0) {
                ForEach(Array(filteredData.enumerated()), id: \.offset) { i, userWeight in
                    ProgressDetailViewCell(filteredData: filteredData, i: i, userWeight: userWeight, unit: unit)
                }
            }
            .background(Settings.shared.currentTheme.cellBackground.color, in: RoundedRectangle(cornerRadius: 8))
        }
    }
}

struct ProgressDetailViewCell: View {
    @Environment(\.colorScheme) var colorScheme
    var filteredData: [WeeklyData]
    let i: Int
    let userWeight: WeeklyData
    let unit: String
    
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
                    Text("\(userWeight.amount.trimmed) \(unit)")
                        .font(.headline)
                    
                    Text(userWeight.date.formatted(date: .abbreviated, time: .omitted))
                        .font(.subheadline)
                        .foregroundColor(Settings.shared.currentTheme.secondary.color)
                        .lineLimit(1)
                }
                
                Spacer()
            }
            .padding()
            
            Divider()
                .opacity(i < filteredData.count - 1 ? 1 : 0)
        }
    }
}

struct ProgressChartView: View {
    var filteredData: [UserWeight]
    
    var body: some View {
        Chart(filteredData) { userWeight in
            LineMark(
                x: .value("Date", userWeight.date_ ?? Date(), unit: .day),
                y: .value("Weight", userWeight.weightInKg ?? 0)
            )
            .symbol(Circle().strokeBorder(lineWidth: 2))
            .symbolSize(CGSize(width: 6, height: 6))
        }
        .chartYScale(domain: .automatic(includesZero: false))
        .frame(height: 300)
    }
}


func formatDateMonthDayYear(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    return dateFormatter.string(from: date)
}


enum SelectedFilter: String, CaseIterable, Identifiable {
    case week
    case month
    case sixMonth
    case year
    case all
    var id: Self { self }
    
    var description: String {
        switch self {
        case .all:
            return "All"
        case .week:
            return "Week"
        case .month:
            return "Month"
        case .sixMonth:
            return "6m"
        case .year:
            return "Year"
        }
    }
}
