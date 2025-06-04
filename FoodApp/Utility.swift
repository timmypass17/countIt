//
//  Utility.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/18/25.
//

import Foundation

extension String {
    var firstUppercased: String {
        guard let first else { return "" }
        return first.uppercased() + dropFirst().lowercased()
    }
}

func formatDateAsDateKey(_ date: Date) -> String {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.month, .day, .year], from: date)
    
    guard let month = components.month,
          let day = components.day,
          let year = components.year else {
        return ""
    }
    
    return String(format: "%02d/%02d/%04d", month, day, year)
}
