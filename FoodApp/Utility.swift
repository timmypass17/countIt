//
//  Utility.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/18/25.
//

import Foundation
import UIKit
import SwiftUICore

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

func convertPoundsToKilograms(_ pounds: Double) -> Double {
    return pounds * 0.453592
}

func convertKilogramsToPounds(_ kilograms: Double) -> Double {
    return kilograms / 0.453592
}

extension Double {
    // e.g. 100.0 -> "100", 100.456 - > "100.4"
    var trimmed: String {
        let formatted = String(format: "%.1f", self)
        return formatted.replacingOccurrences(of: #"(\.0+|(?<=\.\d)0)$"#, with: "", options: .regularExpression)
    }
    
}

func extractQuantityAndModifier(from string: String) -> (Double, String)? {
    let components: [Substring] = string.split(separator: " ")
    guard let quantityString = components.first,
          let quantity = Double(quantityString),
          components.count > 1
    else {
        return nil
    }
    let modifier = String(components[1]).lowercased()
    
    return (quantity, modifier)
}

extension Color {
    static let ui = Color.UI()
    
    struct UI {
        let moon1 = UIColor(named: "moon.1")!
        let moon2 = UIColor(named: "moon.2")!
        let moon3 = UIColor(named: "moon.3")!
        let moon4 = UIColor(named: "moon.4")!
        
        let midnight1 = UIColor(named: "midnight.1")!
        let midnight2 = UIColor(named: "midnight.2")!
        let midnight3 = UIColor(named: "midnight.3")!
        let midnight4 = UIColor(named: "midnight.4")!
        
        let darkBackground = UIColor(named: "dark.background")!
        let darkCellBackground = UIColor(named: "dark.cellBackground")!
        let darkLabel = UIColor(named: "dark.label")!
        let darkSecondary = UIColor(named: "dark.secondary")!
        let darkTabBar = UIColor(named: "dark.tabBar")!
        let darkProgress = UIColor(named: "dark.progress")!

        let lightBackground = UIColor(named: "light.background")!
        let lightCellBackground = UIColor(named: "light.cellBackground")!
        let lightLabel = UIColor(named: "light.label")!
        let lightSecondary = UIColor(named: "light.secondary")!
        let lightTabBar = UIColor(named: "light.tabBar")!
        let lightProgress = UIColor(named: "light.progress")!
    }
}

protocol AppTheme: Codable {
    var name: String { get }
    
    var uiUserInterfaceStyle: UIUserInterfaceStyle { get }

    var color1: CodableColor { get }
    var color2: CodableColor { get }
    var color3: CodableColor { get }
    var color4: CodableColor { get }
    
    var background: CodableColor { get }
    var cellBackground: CodableColor { get }
    var tabBar: CodableColor { get }
    
    var label: CodableColor { get }
    var secondary: CodableColor { get }
    
    var progress: CodableColor { get }
}

struct DarkTheme: AppTheme {
    var name = "Dark"
    
    var uiUserInterfaceStyle: UIUserInterfaceStyle = .dark
    
    var color1 = CodableColor(UIColor.systemBlue)
    var color2 =  CodableColor(UIColor.systemYellow)
    var color3 =  CodableColor(UIColor.systemPink)
    var color4 =  CodableColor(UIColor.systemGreen)

    var background =  CodableColor(Color.ui.darkBackground)
    var cellBackground =  CodableColor(Color.ui.darkCellBackground)
    var tabBar = CodableColor(Color.ui.darkTabBar)
    
    var label = CodableColor(Color.ui.darkLabel)
    var secondary = CodableColor(Color.ui.darkSecondary)
    
    var progress = CodableColor(Color.ui.darkProgress)
}

struct LightTheme: AppTheme {
    var name = "Light"
    
    var uiUserInterfaceStyle: UIUserInterfaceStyle = .light
    
    var color1 = CodableColor(UIColor.systemBlue)
    var color2 =  CodableColor(UIColor.systemYellow)
    var color3 =  CodableColor(UIColor.systemPink)
    var color4 =  CodableColor(UIColor.systemGreen)

    var background =  CodableColor(Color.ui.lightBackground)
    var cellBackground =  CodableColor(Color.ui.lightCellBackground)
    var tabBar = CodableColor(Color.ui.lightTabBar)

    var label = CodableColor(Color.ui.lightLabel)
    var secondary = CodableColor(Color.ui.lightSecondary)
    
    var progress = CodableColor(Color.ui.lightProgress)
}

//struct MoonTheme: AppTheme {
//    var name = "Moon"
//    
//    var color1 = CodableColor(Color.ui.moon1)
//    var color2 =  CodableColor(Color.ui.moon2)
//    var color3 =  CodableColor(Color.ui.moon3)
//    var color4 =  CodableColor(Color.ui.moon4)
//
//    var background =  CodableColor(Color.ui.backgroundDark)
//    var cellBackground =  CodableColor(Color.ui.cellBackgroundDark)
//}
//
//struct MidnightTheme: AppTheme {
//    var name = "Midnight"
//    
//    var color1 = CodableColor(Color.ui.midnight1)
//    var color2 =  CodableColor(Color.ui.midnight2)
//    var color3 =  CodableColor(Color.ui.midnight3)
//    var color4 =  CodableColor(Color.ui.midnight4)
//
//    var background =  CodableColor(Color.ui.backgroundDark)
//    var cellBackground =  CodableColor(Color.ui.cellBackgroundDark)
//}


/// https://nilcoalescing.com/blog/EncodeAndDecodeSwiftUIColor/
struct CodableColor: Codable {
    let cgColor: CGColor
    
    var uiColor: UIColor {
        return UIColor(cgColor: cgColor)
    }
    
    var color: Color {
        return Color(cgColor)
    }
    
    enum CodingKeys: String, CodingKey {
        case colorSpace
        case components
    }
    
    init(_ uiColor: UIColor) {
        self.cgColor = uiColor.cgColor
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder
            .container(keyedBy: CodingKeys.self)
        let colorSpace = try container
            .decode(String.self, forKey: .colorSpace)
        let components = try container
            .decode([CGFloat].self, forKey: .components)
        
        guard
            let cgColorSpace = CGColorSpace(name: colorSpace as CFString),
            let cgColor = CGColor(
                colorSpace: cgColorSpace, components: components
            )
        else {
            throw CodingError.wrongData
        }
        
        self.cgColor = cgColor
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        guard
            let colorSpace = cgColor.colorSpace?.name,
            let components = cgColor.components
        else {
            throw CodingError.wrongData
        }
              
        try container.encode(colorSpace as String, forKey: .colorSpace)
        try container.encode(components, forKey: .components)
    }
}

enum CodingError: Error {
    case wrongColor
    case wrongData
}

extension UIUserInterfaceStyle: Codable, CaseIterable {
    public static var allCases: [UIUserInterfaceStyle] = [.unspecified, .light, .dark]
    
    var description: String {
        switch self {
        case .unspecified:
            return "Automatic"
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        @unknown default:
            return "Automatic"
        }
    }
}
