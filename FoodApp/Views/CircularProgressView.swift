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
    
    var progress: Float {
        return current / total
    }
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .stroke(
                        color.opacity(0.1),
                        lineWidth: 5
                    )
                Circle()
                    .trim(from: 0, to: CGFloat(progress))
                    .stroke(
                        color,
                        style: StrokeStyle(
                            lineWidth: 5,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: progress)
                VStack {
                    if current > 1 {
                        Text("\(Int(current))")
                            .fontWeight(.semibold)
                    } else {
                        Text("\(current.formattedString(decimalPlaces: 1))")
                            .fontWeight(.semibold)
                    }
                    Text("\(total.formatted(.number)) g")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Text(title)
                .foregroundStyle(.secondary)
        }
        
    }
}

#Preview {
    GeometryReader { geometry in
        CircularProgressView(title: "Calories", current: 105, total: 2000, color: .blue)
            .frame(width: geometry.size.width * 0.25)
    }
}

extension Float {
    func formattedString(decimalPlaces: Int) -> String {
        return self.formatted(.number.precision(.fractionLength(0...decimalPlaces)))
    }
}
