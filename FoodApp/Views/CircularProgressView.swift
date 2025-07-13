//
//  MacroChartView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/10/24.
//

import SwiftUI

struct CircularProgressView: View {
    let title: String
    let current: Float
    let total: Float
    let color: Color
    let unitName: String
    let progressSize: CGFloat = 16
    let totalSize: CGFloat = 10
    let titleSize: CGFloat = 16
    var lineWidth: CGFloat = 5
    
    var progress: Float {
        return current / total
    }
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .stroke(
                        Settings.shared.currentTheme.progress.color,
                        lineWidth: lineWidth
                    )
                    
                Circle()
                    .trim(from: 0, to: CGFloat(progress))
                    .stroke(
                        color,
                        style: StrokeStyle(
                            lineWidth: lineWidth,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: progress)
                VStack {
                    Group {
                        if current > 1 {
                            Text("\(Int(current))")
                        } else {
                            Text("\(current.formattedString(decimalPlaces: 1))")
                        }
                    }
                    .fontWeight(.semibold)
                    .font(.system(size: progressSize))
                    .foregroundStyle(Settings.shared.currentTheme.label.color)

                    Text("\(total.formatted(.number)) \(unitName)")
                        .foregroundStyle(Settings.shared.currentTheme.secondary.color)
                        .font(.system(size: totalSize))
                }
            }
            Text(title)
                .foregroundStyle(Settings.shared.currentTheme.secondary.color)
                .font(.system(size: titleSize))
        }
        
    }
}

#Preview {
    GeometryReader { geometry in
        CircularProgressView(title: "Calories", current: 105, total: 2000, color: .blue, unitName: "cal")
            .frame(width: geometry.size.width * 0.25)
    }
}

extension Float {
    func formattedString(decimalPlaces: Int) -> String {
        return self.formatted(.number.precision(.fractionLength(0...decimalPlaces)))
    }
}
