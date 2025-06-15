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

    @State private var selectedFilter: SelectedFilter = .all
    
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
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                FilterSegmentedView(selectedFilter: $selectedFilter)
                
                ProgressHeaderView(filteredData: filteredUserWeights)

                ProgressChartView(filteredData: filteredUserWeights)
                
                Divider()
                    .padding(.bottom, 12)
                
                ProgressListView(filteredData: filteredUserWeights)
            }
            .padding([.horizontal, .bottom])
            .animation(.default, value: userWeights.count) // animation trigger when value changes
        }
        .navigationTitle("Weight")
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
    var filteredData: [UserWeight]
    
    var dateRangeString: String {
        let startDate = filteredData.last?.date_ ?? Date()
        let endDate = filteredData.first?.date_ ?? Date()
        return "\(formatDateMonthDayYear(startDate)) - \(formatDateMonthDayYear(endDate))"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Current Weight")
                .foregroundColor(.secondary)
                .font(.subheadline)
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("\(filteredData.last?.getWeight(.pounds).trimmed ?? "-")")
                    .font(.title)
                Text("lbs")
                    .foregroundColor(.secondary)
            }
            
            Text(dateRangeString)
                .foregroundColor(.secondary)
                .font(.subheadline)
        }
        .padding(.vertical, 4)
    }
}

struct ProgressListView: View {
    @Environment(\.colorScheme) var colorScheme

    var filteredData: [UserWeight]

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
                ForEach(Array(filteredData.enumerated()), id: \.offset) { i, exercise in
                    ProgressDetailViewCell(filteredData: filteredData, i: i, userWeight: exercise)
                }
            }
            .background(Color(UIColor.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 8))
        }
    }
}

struct ProgressDetailViewCell: View {
    @Environment(\.colorScheme) var colorScheme
    var filteredData: [UserWeight]
    let i: Int
    let userWeight: UserWeight
    
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
                    Text("140 lbs")
                        .font(.headline)
                    
                    Text(Date().formatted(date: .abbreviated, time: .omitted))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
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
                y: .value("Weight", userWeight.weightInKg)
            )
            .symbol(Circle().strokeBorder(lineWidth: 2))
            .symbolSize(CGSize(width: 6, height: 6))
        }
        .chartYScale(domain: .automatic(includesZero: false))
        .frame(height: 300)
    }
}


enum SelectedFilter: String, CaseIterable, Identifiable {
    case all
    case week
    case month
    case sixMonth
    case year
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

func formatDateMonthDayYear(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    return dateFormatter.string(from: date)
}
