//
//  Utility.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/18/25.
//

import Foundation
import UIKit

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


extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255
        let b = CGFloat(rgb & 0x0000FF) / 255

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
