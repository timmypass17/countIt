//
//  WeeklyNutrientChartView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/28/25.
//

import SwiftUI
import Charts

struct WeeklyData: Identifiable {
    var date: Date
    var amount: Double
    var id = UUID()
    
    var weekday: String {
        let f = DateFormatter()
        return f.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
    }
    
    var label: String {
        return DateFormatter.shortWeekdayLetter(from: date)
    }
}

struct WeeklyNutrientChartView: View {
    var data: [WeeklyData]
    var goal: Double
    var color: Color
    
    var barWidth: CGFloat = 10

    var body: some View {
        Chart {
            ForEach(data) { item in
                BarMark(
                    x: .value("Weekday", item.weekday),
                    y: .value("Amount", min(item.amount, goal)),
                    width: .fixed(barWidth)
                )
                .foregroundStyle(color)
                
                if item.amount < goal {
                    BarMark(
                        x: .value("Weekday", item.weekday),
                        yStart: .value("Amount", min(item.amount, goal)),
                        yEnd: .value("Goal", goal),
                        width: .fixed(barWidth)
                    )
                    .foregroundStyle(Settings.shared.currentTheme.progress.color)
                }
            }
        }
        .chartXAxis {
            AxisMarks(values: data.map { $0.weekday }) { value in
                if let category = value.as(String.self),
                   let item = data.first(where: { $0.weekday == category }) {
                    AxisValueLabel {
                        Text(item.label)
                            .bold(Calendar.current.isDateInToday(item.date))
                            .foregroundStyle(Settings.shared.currentTheme.secondary.color)
                    }
                }
            }
        }
        .chartYAxis(.hidden)
        .chartYScale(domain: 0...goal)
        .frame(width: 120, height: 75)
    }
}

extension DateFormatter {
    static func shortWeekdayLetter(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX") // force consistent symbols
        formatter.dateFormat = "EEEEE" // 1-letter weekday (e.g., "S", "M")
        return formatter.string(from: date)
    }
}
