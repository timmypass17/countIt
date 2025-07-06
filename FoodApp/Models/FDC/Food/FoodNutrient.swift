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
    
    init(nutrient: Nutrient?, amount: Double?) {
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
    let nutrient: RawNutrient?
    
    enum CodingKeys: CodingKey {
        case amount
        case unitName
        case nutrient
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.amount = try container.decodeIfPresent(Double.self, forKey: .amount) ?? 0
        self.unitName = try container.decodeIfPresent(String.self, forKey: .unitName) ?? ""
        self.nutrient = try container.decodeIfPresent(RawNutrient.self, forKey: .nutrient)
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
    case vitaminE = 1109 // Vitamin E (alpha-tocopherol)
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
            return "Total Carbohydrate"
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
    
    var progressColor: Color {
        switch self {
            // 🔥 Energy
        case .calories, .fallbackCalories:
            return .blue
            
            // 🍞 Carbs & Sugars
        case .carbs, .sugarTotal, .sugarAdded:
            return .yellow
        case .fiber:
            return .brown
            
            // 🥑 Fats
        case .fatTotal, .fatMono, .fatPoly, .fatSaturated, .cholesterol:
            return .green
            
            // 💪 Protein
        case .protein:
            return .pink
            
            // 🍏 Vitamins
        case .vitaminA, .vitaminB1, .vitaminB2, .vitaminB3, .vitaminB6, .vitaminB7, .vitaminB12, .vitaminC, .vitaminD, .vitaminE, .vitaminK, .folate:
            return .green
            
            // 🦴 Minerals
        case .calcium, .iron, .magnesium, .phosphorus, .potassium, .sodium, .zinc, .copper, .iodine, .manganese, .selenium:
            return .blue
            
            // 💧 Water & hydration
        case .water:
            return .cyan
            
            // ☕ Caffeine
        case .caffeine:
            return .red
            
            // fallback (shouldn't happen with exhaustive switch)
        }
    }
    
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
    
    var isRequired: Bool {
        switch self {
        case .calories:
            return true
        default:
            return false
        }
    }
    
    static var allProgress: [NutrientId] {
        [
            .calories, .carbs, .protein, .fatTotal, .water, .caffeine,
            .fiber, .sugarTotal, .sugarAdded,
            .fatMono, .fatPoly, .fatSaturated, .cholesterol,
            .vitaminA, .vitaminB1, .vitaminB2, .vitaminB3, .vitaminB6, .vitaminB7, .vitaminB12,
            .vitaminC, .vitaminD, .vitaminE, .vitaminK, .folate,
            .calcium, .iron, .magnesium, .phosphorus, .potassium, .sodium, .zinc,
            .copper, .iodine, .manganese, .selenium
        ]
    }
    
    var symbol: String {
        switch self {
        case .calories, .fallbackCalories:
            return "flame.fill"
        case .carbs, .fiber:
            return "laurel.trailing"
        case .sugarTotal, .sugarAdded:
            return "cube.fill"
        case .protein:
            return "fish.fill"
        case .fatTotal, .fatMono, .fatPoly, .fatSaturated, .cholesterol:
            return "drop.fill"
            
        case .water:
            return "drop.circle.fill"
        case .caffeine:
            return "cup.and.saucer.fill"
            
        case .vitaminA, .vitaminB1, .vitaminB2, .vitaminB3, .vitaminB6, .vitaminB7, .vitaminB12,
                .vitaminC, .vitaminD, .vitaminE, .vitaminK, .folate:
            return "leaf.fill"
            
        case .calcium, .iron, .magnesium, .phosphorus, .potassium, .sodium, .zinc,
                .copper, .iodine, .manganese, .selenium:
            return "circle.grid.cross.fill"
        }
    }
    
    var footerText: String {
        switch self {
        case .calories, .fallbackCalories:
            return "Energy your body uses—measured in calories." // :contentReference[oaicite:1]{index=1}
        case .carbs:
            return "Your body's main fuel; includes sugars and starches." // :contentReference[oaicite:2]{index=2}
        case .fiber:
            return "A type of carb that aids digestion and supports gut health." // :contentReference[oaicite:3]{index=3}
        case .sugarTotal:
            return "All sugar—natural and added—found in your food/drinks."
        case .sugarAdded:
            return "Extra sugar added during processing or cooking." // :contentReference[oaicite:4]{index=4}
        case .protein:
            return "Builds and repairs muscle, tissue, and enzymes." // :contentReference[oaicite:5]{index=5}
        case .fatTotal:
            return "All fats—from healthy to less healthy types."
        case .fatMono:
            return "Heart‑healthy monounsaturated fats (like in olive oil)." // :contentReference[oaicite:6]{index=6}
        case .fatPoly:
            return "Polyunsaturated fats, including omega‑3s and omega‑6s." // :contentReference[oaicite:7]{index=7}
        case .fatSaturated:
            return "Solid at room temp—too much may raise LDL (‘bad’) cholesterol." // :contentReference[oaicite:8]{index=8}
        case .cholesterol:
            return "Waxy molecule in food/body; too much may affect heart health."
        case .water:
            return "Keeps you hydrated—essential for all body functions." // :contentReference[oaicite:9]{index=9}
        case .caffeine:
            return "Stimulates alertness—found in coffee, tea, energy drinks."
        case .vitaminA:
            return "Supports good vision, skin health, and immunity." // :contentReference[oaicite:10]{index=10}
        case .vitaminB1:
            return "Helps turn carbs into energy and supports nerves."
        case .vitaminB2:
            return "Aids energy production and keeps cells healthy."
        case .vitaminB3:
            return "Helps nourish the skin and convert food into energy."
        case .vitaminB6:
            return "Important for brain health and helping nerves work right."
        case .vitaminB7:
            return "Assists in metabolism; often linked to healthy hair & nails."
        case .vitaminB12:
            return "Needed for making red blood cells and healthy nerves."
        case .vitaminC:
            return "Boosts immunity and helps your body heal." // :contentReference[oaicite:11]{index=11}
        case .vitaminD:
            return "Helps your body use calcium to build strong bones." // :contentReference[oaicite:12]{index=12}
        case .vitaminE:
            return "Acts as an antioxidant, protecting your cells." // :contentReference[oaicite:13]{index=13}
        case .vitaminK:
            return "Needed for normal blood clotting and bone health." // :contentReference[oaicite:14]{index=14}
        case .folate:
            return "Supports new cell growth—especially important in pregnancy." // :contentReference[oaicite:15]{index=15}
        case .calcium:
            return "Strengthens bones and helps muscles contract." // :contentReference[oaicite:16]{index=16}
        case .iron:
            return "Helps carry oxygen in your blood." // :contentReference[oaicite:17]{index=17}
        case .magnesium:
            return "Supports muscles, nerves, and energy production." // :contentReference[oaicite:18]{index=18}
        case .phosphorus:
            return "Works with calcium to build strong bones and teeth." // :contentReference[oaicite:19]{index=19}
        case .potassium:
            return "Helps control fluids, muscle contractions, and blood pressure." // :contentReference[oaicite:20]{index=20}
        case .sodium:
            return "Balances fluids and affects your blood pressure." // :contentReference[oaicite:21]{index=21}
        case .zinc:
            return "Supports the immune system and helps healing." // :contentReference[oaicite:22]{index=22}
        case .copper:
            return "Helps your body use iron and make energy."
        case .iodine:
            return "Essential for making thyroid hormones." // :contentReference[oaicite:23]{index=23}
        case .manganese:
            return "Plays a role in metabolism and bone formation." // :contentReference[oaicite:24]{index=24}
        case .selenium:
            return "Protects cells and supports thyroid and immunity." // :contentReference[oaicite:25]{index=25}
        }
    }
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
