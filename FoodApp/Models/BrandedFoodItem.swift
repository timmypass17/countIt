////
////  BrandedFood.swift
////  FoodApp
////
////  Created by Timmy Nguyen on 3/6/24.
////
//
//import Foundation
//
//
//struct BrandedFoodItem: Codable {
//    let fdcId: Int
//    let description: String
//    let foodNutrients: [FoodNutrient]
//    let foodPortions: [FoodPortion] // added
//    let brandName: String?
////    let servingSize: Float
////    let servingSizeUnit: String
//    
//    enum CodingKeys: String, CodingKey {
//        case fdcId
//        case description
//        case foodNutrients
//        case brandName
////        case servingSize
////        case servingSizeUnit
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.fdcId = try container.decode(Int.self, forKey: .fdcId)
//        self.description = try container.decode(String.self, forKey: .description)
//        self.foodNutrients = try container.decode([FoodNutrient].self, forKey: .foodNutrients)
//        self.brandName = try container.decode(String.self, forKey: .brandName)
////        self.brandName = try container.decode(String.self, forKey: .brandName)
////        self.brandName = try container.decode(String.self, forKey: .brandName)
//
//        // Add default portions
//        foodPortions.append(FoodPortion(gramWeight: 100, modifier: "No modifier"))
//    }
//}
//
//// MARK: UI Methods
//
//extension BrandedFoodItem {
//    func getServingSizeFormatted(servingGramWeight: Float) -> String {
//        return ""
////        guard let nutrient = foodNutrients.getNutrient(name: "Energy"),
////              let caloriesPer100g = nutrient.amount
////        else { return "No calories" }
////        let caloriesPerServing = calculateCaloriePerServing(caloriesPer100g: caloriesPer100g, servingGramWeight: servingGramWeight)
////        var servingSizeString = "\(Int(caloriesPerServing)) cal, \(servingSize.formattedString()) \(servingSizeUnit)"
////        if let brandName {
////            servingSizeString.append(", \(brandName)")
////        }
////        return servingSizeString
//    }
//}
//
//extension Array where Element == FoodNutrient {
//    func getNutrient(name: String) -> FoodNutrient? {
//        return self.first { $0.nutrient.name.lowercased() == name.lowercased() }
//    }
//}
//
//
//func calculateCaloriePerServing(caloriesPer100g: Float, servingGramWeight: Float) -> Float {
//    return (caloriesPer100g * servingGramWeight) / 100
//}
//
//extension Float {
//    func formattedString() -> String {
//        return String(format: "%g", self)
//    }
//}
