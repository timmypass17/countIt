//
//  FoodNutrient.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/6/24.
//

import Foundation
import UIKit
import SwiftUICore

struct FoodNutrient: Codable {
    var nutrient: Nutrient?
    var amount: Double?   // 590
    
    init(nutrient: Nutrient, amount: Double?) {
        self.nutrient = nutrient
        self.amount = amount
    }
    
    var description: String {
        guard let nutrient else { return "" }
        return nutrient.id.description
    }
}

extension FoodNutrient: NutrientIdentifiable {
    var nutrientId: NutrientId? {
        return nutrient?.id
    }
}

protocol NutrientIdentifiable {
    var nutrientId: NutrientId? { get }
}

extension Array where Element: NutrientIdentifiable {
    subscript(nutrientID: NutrientId?) -> Element? {
        self.first { $0.nutrientId == nutrientID }
    }
}

extension FoodNutrient {
    static func empty(_ nutrientId: NutrientId) -> FoodNutrient {
        return FoodNutrient(nutrient: Nutrient(id: nutrientId, name: nutrientId.description, unitName: nutrientId.unitName, rank: 0), amount: 0)

    }
}

struct RawFoodNutrient: Codable {
    let amount: Double
    let unitName: String
    let nutrient: RawNutrient
    
    enum CodingKeys: CodingKey {
        case amount
        case unitName
        case nutrient
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.amount = try container.decodeIfPresent(Double.self, forKey: .amount) ?? 0
        self.unitName = try container.decodeIfPresent(String.self, forKey: .unitName) ?? ""
        self.nutrient = try container.decode(RawNutrient.self, forKey: .nutrient)
    }
}

struct RawNutrient: Codable {
    let id: Int
    let name: String
//    let rank: String
    let unitName: String
}

//extension FoodNutrient: Equatable {
//    static func == (lhs: FoodNutrient, rhs: FoodNutrient) -> Bool {
//        return lhs.nutrient.id == rhs.nutrient.id
//    }
//}

extension FoodNutrient: Comparable {
    static func == (lhs: FoodNutrient, rhs: FoodNutrient) -> Bool {
        return lhs.nutrient?.id == rhs.nutrient?.id
    }
    
    static func < (lhs: FoodNutrient, rhs: FoodNutrient) -> Bool {
        // Sort based on enum case order
        let lhsIndex = NutrientId.allCases.firstIndex { $0 == lhs.nutrient?.id } ?? NutrientId.allCases.count
        let rhsIndex = NutrientId.allCases.firstIndex { $0 == rhs.nutrient?.id } ?? NutrientId.allCases.count
        return lhsIndex < rhsIndex
    }
}

struct Nutrient: Codable {
    let id: NutrientId
    let name: String        // Calories
    let unitName: String    // kcal
    var rank: Int
}

// TODO: Import nutrient csv? 
enum NutrientId: Int, Codable, CaseIterable {
    case calories = 1008
    case fallbackCalories = 2047 // fall back Energy (Atwater General Factors) - (fdcid: 2514746 - "Chicken breast")
    case carbs = 1005
    case fiber = 1079
    case sugarTotal = 2000
    case sugarAdded = 1235  // not in HealthKit
    case fatTotal = 1004
    case fatMono = 1292
    case fatPoly = 1293
    case fatSaturated = 1258
    case cholesterol = 1253
    case protein = 1003
    
    case vitaminA = 1104 // IU
    case vitaminB1 = 1165 // Thiamin
    case vitaminB2 = 1166 // Riboflavin
    case vitaminB3 = 1167 // Niacin
    //    Pantothenic Acid (B5) → Not available
    case vitaminB6 = 1175
    case vitaminB7 = 1176 // Biotin
    case vitaminB12 = 1178
    case vitaminC = 1162
    case vitaminD = 1114
    case vitaminE = 1109
    case vitaminK = 1185
    case folate = 1177
    
    case calcium = 1087
    //    case chloride
    case iron = 1089
    case magnesium = 1090
    case phosphorus = 1091
    case potassium = 1092
    case sodium = 1093
    case zinc = 1095
    
    case water = 1051
    
    case caffeine = 1057
    
    //    case chromium = 1096  // might not exist?
    case copper = 1098
    case iodine = 1100
    case manganese = 1101
    //    case molybdenum = 1102
    case selenium = 1103
    
    var description: String {
        switch self {
        case .calories:
            return "Calories"
        case .fallbackCalories:
            return "Fallback Calories"
        case .carbs:
            return "Total Carbohydrates"
        case .fiber:
            return "Fiber"
        case .sugarTotal:
            return "Total Sugar"
        case .sugarAdded:
            return "Added Sugar"
        case .fatTotal:
            return "Total Fat"
        case .fatMono:
            return "Monounsaturated Fat"
        case .fatPoly:
            return "Polyunsaturated Fat"
        case .fatSaturated:
            return "Saturated Fat"
        case .cholesterol:
            return "Cholesterol"
        case .protein:
            return "Protein"
        case .vitaminA:
            return "Vitamin A"
        case .vitaminB1:
            return "Vitamin B1 (Thiamin)"
        case .vitaminB2:
            return "Vitamin B2 (Riboflavin)"
        case .vitaminB3:
            return "Vitamin B3 (Niacin)"
        case .vitaminB6:
            return "Vitamin B6"
        case .vitaminB7:
            return "Vitamin B7 (Biotin)"
        case .vitaminB12:
            return "Vitamin B12"
        case .vitaminC:
            return "Vitamin C"
        case .vitaminD:
            return "Vitamin D"
        case .vitaminE:
            return "Vitamin E"
        case .vitaminK:
            return "Vitamin K"
        case .folate:
            return "Folate"
        case .calcium:
            return "Calcium"
        case .iron:
            return "Iron"
        case .magnesium:
            return "Magnesium"
        case .phosphorus:
            return "Phosphorus"
        case .potassium:
            return "Potassium"
        case .sodium:
            return "Sodium"
        case .zinc:
            return "Zinc"
            
        case .water:
            return "Water"
            
        case .caffeine:
            return "Caffeine"
        case .copper:
            return "Copper"
        case .iodine:
            return "Iodine"
        case .manganese:
            return "Manganese"
        case .selenium:
            return "Selenium"
        }
    }
    
    var shortDescription: String {
        switch self {
        case .calories: return "Calories"
        case .fallbackCalories: return "Calories"
        case .carbs: return "Carbs"
        case .fiber: return "Fiber"
        case .sugarTotal: return "Sugars"
        case .sugarAdded: return "Added Sugars"
        case .fatTotal: return "Fat"
        case .fatMono: return "Mono Fat"
        case .fatPoly: return "Poly Fat"
        case .fatSaturated: return "Sat Fat"
        case .cholesterol: return "Chol"
        case .protein: return "Protein"

        case .vitaminA: return "Vit A"
        case .vitaminB1: return "B1"
        case .vitaminB2: return "B2"
        case .vitaminB3: return "B3"
        case .vitaminB6: return "B6"
        case .vitaminB7: return "B7"
        case .vitaminB12: return "B12"
        case .vitaminC: return "Vit C"
        case .vitaminD: return "Vit D"
        case .vitaminE: return "Vit E"
        case .vitaminK: return "Vit K"
        case .folate: return "Folate"

        case .calcium: return "Ca"
        case .iron: return "Fe"
        case .magnesium: return "Mg"
        case .phosphorus: return "P"
        case .potassium: return "K"
        case .sodium: return "Na"
        case .zinc: return "Zn"

        case .water: return "Water"
        case .caffeine: return "Caffeine"

        case .copper: return "Cu"
        case .iodine: return "Iodine"
        case .manganese: return "Mn"
        case .selenium: return "Se"
        }
    }
    
    var unitName: String {
        switch self {
        // Energy
        case .calories:
            return "cal"
        case .fallbackCalories:
            return "cal"
        // Macronutrients (mass)
        case .carbs, .fiber,
             .sugarTotal, .sugarAdded,
             .fatTotal, .fatMono, .fatPoly, .fatSaturated,
             .protein, .water:
            return "g"
            
        // Cholesterol (mass)
        case .cholesterol:
            return "mg"
            
        // Vitamins (varied)
        case .vitaminA:
            return "iu"
        case .vitaminD, .vitaminK:
            return "µg"
        case .vitaminB1, .vitaminB2, .vitaminB3,
             .vitaminB6, .vitaminC, .vitaminE,
             .folate:
            return "mg"
        case .vitaminB7, .vitaminB12:
            return "µg"
        
        // Minerals (mass)
        case .calcium, .iron, .magnesium, .phosphorus,
             .potassium, .sodium, .zinc, .copper, .manganese:
            return "mg"
        case .iodine, .selenium:
            return "µg"
        
        // Other
        case .caffeine:
            return "mg"
        }
    }
    
    var color: Color {
        switch self {
        case .calories:
            return Color(uiColor: UIColor(hex: "#2E8AFF"))  // blue
        case .carbs:
            return Color(uiColor: UIColor(hex: "#DFAB01"))  // yellow
        case .protein:
            return Color(uiColor: UIColor(hex: "#E03E3E"))  // red/pink
        case .fatTotal:
            return Color(uiColor: UIColor(hex: "#0F7B6C"))  // green
        default:
            return .purple
        }
    }
    
    // Lighter
//    var color: Color {
//        switch self {
//        case .calories:
//            return Color(uiColor: UIColor(hex: "#2E8AFF"))  // blue
//        case .carbs:
//            return Color(uiColor: UIColor(hex: "#F5A623"))  // yellow
//        case .protein:
//            return Color(uiColor: UIColor(hex: "#FF6B6B"))  // red/pink
//        case .fatTotal:
//            return Color(uiColor: UIColor(hex: "#29CC7A"))  // green
//        default:
//            return .purple
//        }
//    }
    
    // Darker
//    var color: Color {
//        switch self {
//        case .calories:
//            return Color(uiColor: UIColor(hex: "#0B6E99"))  // blue
//        case .carbs:
//            return Color(uiColor: UIColor(hex: "#DFAB01"))  // yellow
//        case .protein:
//            return Color(uiColor: UIColor(hex: "#E03E3E"))  // red/pink
//        case .fatTotal:
//            return Color(uiColor: UIColor(hex: "#0F7B6C"))  // green
//        default:
//            return .purple
//        }
//    }
    
    static let macronutrients: [NutrientId] = [
        .calories, .fatTotal, .fatMono, .fatPoly, .fatSaturated,
        .cholesterol, .sodium, .carbs, .fiber, .sugarTotal, .sugarAdded, .protein
    ]
    
    static let vitamins: [NutrientId] = [
        .vitaminA, .vitaminB1, .vitaminB2, .vitaminB3, .vitaminB6,
        .vitaminB7, .vitaminB12, .vitaminC, .vitaminD, .vitaminE,
        .vitaminK, .folate
    ]
    
    static let minerals: [NutrientId] = [
        .calcium, .iron, .magnesium, .phosphorus, .potassium,
        .sodium, .zinc, .copper, .iodine, .manganese, .selenium
    ]
    
    static let other: [NutrientId] = [
        .water, .caffeine
    ]
    
}

extension NutrientId {
    var isSecondary: Bool {
        switch self {
        case .fatMono, .fatPoly, .fiber, .sugarTotal:
            return true
        default:
            return false
        }
    }

    var isTertiary: Bool {
        switch self {
        case .sugarAdded:
            return true
        default:
            return false
        }
    }
}

//// Wrapper for nutrients
//// get rid of magic numbers
//enum NutrientID: Int, Codable, CaseIterable {
//    // Macronutrient
//    case calories = 1008
//    case totalFat = 1004
//    case saturatedFat = 1258
//    case transFat = 1257
//    case cholesterol = 1253
//    case carbs = 1005
//    case sodium = 1093
//    case fiber = 1079
//    case totalSugar = 2000
//    case addedSugar = 1235
//    case protein = 1003
//    case other = -1
//    
//    // Vitamins
//    case vitaminA = 1106 // RAE, µg
//    case vitaminC = 1162 // "Total Ascorbic Acid" represents the total amount of Vitamin C
//    case vitaminD = 1114
//    case vitaminB6 = 1175
//    case vitaminE = 1109 // inherent in food
//    case vitaminK = 1185
//    case thiamin = 1165
//    case vitaminB12 = 1178
//    case riboflavin = 1166
//    case folate = 1177
//    case niacin = 1167
//    case choline = 1180
//    case pantothenicAcid = 1170
////    case biotin = 1176
//    
//    // Minerals
//    case calcium = 1087
////    case chlorine = 1088
////    case chromium = 1096
//    case copper = 1098
//    case iodine = 1100
//    case iron = 1089
//    case magnesium = 1090
//    case manganese = 1101
////    case molybdenum = 1102
//    case phosphorus = 1091
//    case potassium = 1092
//    case selenium = 1103
//    //    case sodium = 1093
//    case zinc = 1095
//    
//    init(rawValue: Int) {
//        switch rawValue {
//            // Macronutrients
//        case 1008, 2047, 2048: self = .calories
//        case 1004: self = .totalFat
//        case 1258: self = .saturatedFat
//        case 1257: self = .transFat
//        case 1253: self = .cholesterol
//        case 1005: self = .carbs
//        case 1093: self = .sodium
//        case 1079: self = .fiber
//        case 2000: self = .totalSugar
//        case 1235: self = .addedSugar
//        case 1003: self = .protein
//            // Vitamins
//        case 1106: self = .vitaminA
//        case 1162: self = .vitaminC
//        case 1114: self = .vitaminD
//        case 1175: self = .vitaminB6
//        case 1109: self = .vitaminE
//        case 1185: self = .vitaminK
//        case 1165: self = .thiamin
//        case 1178: self = .vitaminB12
//        case 1166: self = .riboflavin
//        case 1177: self = .folate
//        case 1167: self = .niacin
//        case 1180: self = .choline
//        case 1170: self = .pantothenicAcid
////        case 1176: self = .biotin
//            // Minerals
//        case 1087: self = .calcium
////        case 1088: self = .chlorine
////        case 1096: self = .chromium
//        case 1098: self = .copper
//        case 1100: self = .iodine
//        case 1089: self = .iron
//        case 1090: self = .magnesium
//        case 1101: self = .manganese
////        case 1102: self = .molybdenum
//        case 1091: self = .phosphorus
//        case 1092: self = .potassium
//        case 1103: self = .selenium
//        case 1095: self = .zinc
//            // Default case for unknown raw values (need this when decoding nutrients idc about)
//        default: self = .other
//        }
//    }
//    
//    static let mainNutrients: [Self] = [.calories, .totalFat, .saturatedFat, .transFat, .cholesterol, .sodium, .carbs, .fiber, .totalSugar, .addedSugar, .protein]
//    
//    static let vitamins: [Self] = [.vitaminA, .vitaminC, .vitaminD, .vitaminB6, .vitaminE, .vitaminK, .thiamin, .vitaminB12, .riboflavin, .folate , .niacin, .choline, .pantothenicAcid]
//    
//    static let minerals: [Self] = [.calcium/*, .chlorine*/, /*.chromium,*/ .copper, .iodine, .iron, .magnesium, .manganese, /*.molybdenum,*/ .phosphorus, .potassium, .selenium, .sodium, .zinc]
//    
//    var description: String {
//        switch self {
//        case .calories:
//            return "Calories"
//        case .totalFat:
//            return "Total Fat"
//        case .saturatedFat:
//            return "Saturated Fat"
//        case .transFat:
//            return "Trans Fat"
//        case .cholesterol:
//            return "Cholesterol"
//        case .carbs:
//            return "Carbohydrates"
//        case .sodium:
//            return "Sodium"
//        case .fiber:
//            return "Fiber"
//        case .totalSugar:
//            return "Total Sugar"
//        case .protein:
//            return "Protein"
//        case .other:
//            return "Other"
//        case .vitaminA:
//            return "Vitamin A"
//        case .vitaminC:
//            return "Vitamin C"
//        case .vitaminD:
//            return "Vitamin D"
//        case .vitaminB6:
//            return "Vitamin B-6"
//        case .vitaminE:
//            return "Vitamin E"
//        case .vitaminK:
//            return "Vitamin K"
//        case .thiamin:
//            return "Thiamin"
//        case .vitaminB12:
//            return "Vitamin B-12"
//        case .riboflavin:
//            return "Riboflavin"
//        case .folate:
//            return "Folate"
//        case .niacin:
//            return "Niacin"
//        case .choline:
//            return "Choline"
//        case .pantothenicAcid:
//            return "Pantothenic Acid"
////        case .biotin:
////            return "Biotin"
//        case .calcium:
//            return "Calcium"
////        case .chlorine:
////            return "Chlorine"
////        case .chromium:
////            return "Chromium"
//        case .copper:
//            return "Copper"
//        case .iodine:
//            return "Iodine"
//        case .iron:
//            return "Iron"
//        case .magnesium:
//            return "Magnesium"
//        case .manganese:
//            return "Manganese"
////        case .molybdenum:
////            return "Molybdenum"
//        case .phosphorus:
//            return "Phosphorus"
//        case .potassium:
//            return "Potassium"
//        case .selenium:
//            return "Selenium"
//        case .zinc:
//            return "Zinc"
//        case .addedSugar:
//            return "Added Sugar"
//        }
//        
//    }
//    
//    var unit: String {
//        switch self {
//        case .calories:
//            return "cal"
//        case .totalFat:
//            return "g"
//        case .saturatedFat:
//            return "g"
//        case .transFat:
//            return "g"
//        case .cholesterol:
//            return "mg"
//        case .carbs:
//            return "g"
//        case .sodium:
//            return "g"
//        case .fiber:
//            return "g"
//        case .totalSugar:
//            return "g"
//        case .protein:
//            return "g"
//        case .other:
//            return "-"
//        case .vitaminA:
//            return "mcg"
//        case .vitaminC:
//            return "mg"
//        case .vitaminD:
//            return "mcg"
//        case .vitaminB6:
//            return "mg"
//        case .vitaminE:
//            return "mg"
//        case .vitaminK:
//            return "mcg"
//        case .thiamin:
//            return "mg"
//        case .vitaminB12:
//            return "mcg"
//        case .riboflavin:
//            return "mg"
//        case .folate:
//            return "mcg"
//        case .niacin:
//            return "mg"
//        case .choline:
//            return "mg"
//        case .pantothenicAcid:
//            return "mg"
////        case .biotin:
////            return "mcg"
//        case .calcium:
//            return "mg"
////        case .chlorine:
////            return "g"
////        case .chromium:
////            return "mcg"
//        case .copper:
//            return "mcg"
//        case .iodine:
//            return "mcg"
//        case .iron:
//            return "mg"
//        case .magnesium:
//            return "mg"
//        case .manganese:
//            return "mg"
////        case .molybdenum:
////            return "mcg"
//        case .phosphorus:
//            return "mg"
//        case .potassium:
//            return "mg"
//        case .selenium:
//            return "mcg"
//        case .zinc:
//            return "mg"
//        case .addedSugar:
//            return "g"
//        }
//    }
//    
//    var isSecondary: Bool {
//        switch self {
//        case .saturatedFat, .transFat, .fiber, .totalSugar:
//            return true
//        default:
//            return false
//        }
//    }
//    
//    var isTertiary: Bool {
//        switch self {
//        case .addedSugar:
//            return true
//        default:
//            return false
//        }
//    }
//}
