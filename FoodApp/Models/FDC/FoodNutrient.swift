//
//  FoodNutrient.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/6/24.
//

import Foundation

struct FoodNutrient: Codable {
    let nutrient: Nutrient?
    var amount: Float?   // 590
    
    init(nutrient: Nutrient, amount: Float?) {
        self.nutrient = nutrient
        self.amount = amount
    }
    
    var description: String {
        guard let nutrient else { return "" }
        return nutrient.id.description
    }
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
        let lhsIndex = NutrientID.allCases.firstIndex { $0 == lhs.nutrient?.id } ?? NutrientID.allCases.count
        let rhsIndex = NutrientID.allCases.firstIndex { $0 == rhs.nutrient?.id } ?? NutrientID.allCases.count
        return lhsIndex < rhsIndex
    }
}

struct Nutrient: Codable {
    let id: NutrientID
    let name: String        // Calories
    let unitName: String    // kcal
}

// Wrapper for nutrients
// get rid of magic numbers
enum NutrientID: Int, Codable, CaseIterable {
    // Macronutrient
    case calories = 1008
    case totalFat = 1004
    case saturatedFat = 1258
    case transFat = 1257
    case cholesterol = 1253
    case carbs = 1005
    case sodium = 1093
    case fiber = 1079
    case totalSugar = 2000
    case addedSugar = 1235
    case protein = 1003
    case other = -1
    
    // Vitamins
    case vitaminA = 1106 // RAE, µg
    case vitaminC = 1162 // "Total Ascorbic Acid" represents the total amount of Vitamin C
    case vitaminD = 1114
    case vitaminB6 = 1175
    case vitaminE = 1109 // inherent in food
    case vitaminK = 1185
    case thiamin = 1165
    case vitaminB12 = 1178
    case riboflavin = 1166
    case folate = 1177
    case niacin = 1167
    case choline = 1180
    case pantothenicAcid = 1170
//    case biotin = 1176
    
    // Minerals
    case calcium = 1087
//    case chlorine = 1088
//    case chromium = 1096
    case copper = 1098
    case iodine = 1100
    case iron = 1089
    case magnesium = 1090
    case manganese = 1101
//    case molybdenum = 1102
    case phosphorus = 1091
    case potassium = 1092
    case selenium = 1103
    //    case sodium = 1093
    case zinc = 1095
    
    init(rawValue: Int) {
        switch rawValue {
            // Macronutrients
        case 1008, 2047, 2048: self = .calories
        case 1004: self = .totalFat
        case 1258: self = .saturatedFat
        case 1257: self = .transFat
        case 1253: self = .cholesterol
        case 1005: self = .carbs
        case 1093: self = .sodium
        case 1079: self = .fiber
        case 2000: self = .totalSugar
        case 1235: self = .addedSugar
        case 1003: self = .protein
            // Vitamins
        case 1106: self = .vitaminA
        case 1162: self = .vitaminC
        case 1114: self = .vitaminD
        case 1175: self = .vitaminB6
        case 1109: self = .vitaminE
        case 1185: self = .vitaminK
        case 1165: self = .thiamin
        case 1178: self = .vitaminB12
        case 1166: self = .riboflavin
        case 1177: self = .folate
        case 1167: self = .niacin
        case 1180: self = .choline
        case 1170: self = .pantothenicAcid
//        case 1176: self = .biotin
            // Minerals
        case 1087: self = .calcium
//        case 1088: self = .chlorine
//        case 1096: self = .chromium
        case 1098: self = .copper
        case 1100: self = .iodine
        case 1089: self = .iron
        case 1090: self = .magnesium
        case 1101: self = .manganese
//        case 1102: self = .molybdenum
        case 1091: self = .phosphorus
        case 1092: self = .potassium
        case 1103: self = .selenium
        case 1095: self = .zinc
            // Default case for unknown raw values (need this when decoding nutrients idc about)
        default: self = .other
        }
    }
    
    static let mainNutrients: [Self] = [.calories, .totalFat, .saturatedFat, .transFat, .cholesterol, .sodium, .carbs, .fiber, .totalSugar, .addedSugar, .protein]
    
    static let vitamins: [Self] = [.vitaminA, .vitaminC, .vitaminD, .vitaminB6, .vitaminE, .vitaminK, .thiamin, .vitaminB12, .riboflavin, .folate , .niacin, .choline, .pantothenicAcid]
    
    static let minerals: [Self] = [.calcium/*, .chlorine*/, /*.chromium,*/ .copper, .iodine, .iron, .magnesium, .manganese, /*.molybdenum,*/ .phosphorus, .potassium, .selenium, .sodium, .zinc]
    
    var description: String {
        switch self {
        case .calories:
            return "Calories"
        case .totalFat:
            return "Total Fat"
        case .saturatedFat:
            return "Saturated Fat"
        case .transFat:
            return "Trans Fat"
        case .cholesterol:
            return "Cholesterol"
        case .carbs:
            return "Carbohydrates"
        case .sodium:
            return "Sodium"
        case .fiber:
            return "Fiber"
        case .totalSugar:
            return "Total Sugar"
        case .protein:
            return "Protein"
        case .other:
            return "Other"
        case .vitaminA:
            return "Vitamin A"
        case .vitaminC:
            return "Vitamin C"
        case .vitaminD:
            return "Vitamin D"
        case .vitaminB6:
            return "Vitamin B-6"
        case .vitaminE:
            return "Vitamin E"
        case .vitaminK:
            return "Vitamin K"
        case .thiamin:
            return "Thiamin"
        case .vitaminB12:
            return "Vitamin B-12"
        case .riboflavin:
            return "Riboflavin"
        case .folate:
            return "Folate"
        case .niacin:
            return "Niacin"
        case .choline:
            return "Choline"
        case .pantothenicAcid:
            return "Pantothenic Acid"
//        case .biotin:
//            return "Biotin"
        case .calcium:
            return "Calcium"
//        case .chlorine:
//            return "Chlorine"
//        case .chromium:
//            return "Chromium"
        case .copper:
            return "Copper"
        case .iodine:
            return "Iodine"
        case .iron:
            return "Iron"
        case .magnesium:
            return "Magnesium"
        case .manganese:
            return "Manganese"
//        case .molybdenum:
//            return "Molybdenum"
        case .phosphorus:
            return "Phosphorus"
        case .potassium:
            return "Potassium"
        case .selenium:
            return "Selenium"
        case .zinc:
            return "Zinc"
        case .addedSugar:
            return "Added Sugar"
        }
        
    }
    
    var unit: String {
        switch self {
        case .calories:
            return "cal"
        case .totalFat:
            return "g"
        case .saturatedFat:
            return "g"
        case .transFat:
            return "g"
        case .cholesterol:
            return "mg"
        case .carbs:
            return "g"
        case .sodium:
            return "g"
        case .fiber:
            return "g"
        case .totalSugar:
            return "g"
        case .protein:
            return "g"
        case .other:
            return "-"
        case .vitaminA:
            return "mcg"
        case .vitaminC:
            return "mg"
        case .vitaminD:
            return "mcg"
        case .vitaminB6:
            return "mg"
        case .vitaminE:
            return "mg"
        case .vitaminK:
            return "mcg"
        case .thiamin:
            return "mg"
        case .vitaminB12:
            return "mcg"
        case .riboflavin:
            return "mg"
        case .folate:
            return "mcg"
        case .niacin:
            return "mg"
        case .choline:
            return "mg"
        case .pantothenicAcid:
            return "mg"
//        case .biotin:
//            return "mcg"
        case .calcium:
            return "mg"
//        case .chlorine:
//            return "g"
//        case .chromium:
//            return "mcg"
        case .copper:
            return "mcg"
        case .iodine:
            return "mcg"
        case .iron:
            return "mg"
        case .magnesium:
            return "mg"
        case .manganese:
            return "mg"
//        case .molybdenum:
//            return "mcg"
        case .phosphorus:
            return "mg"
        case .potassium:
            return "mg"
        case .selenium:
            return "mcg"
        case .zinc:
            return "mg"
        case .addedSugar:
            return "g"
        }
    }
    
    var isSecondary: Bool {
        switch self {
        case .saturatedFat, .transFat, .carbs, .fiber, .totalSugar:
            return true
        default:
            return false
        }
    }
    
    var isTertiary: Bool {
        switch self {
        case .addedSugar:
            return true
        default:
            return false
        }
    }
}
