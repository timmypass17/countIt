//
//  Food.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/2/24.
//

import Foundation

struct FoodSearchResults: Codable {
    var fdcId: Int
    var description: String
    var additionalDescriptions: String?
    var brandName: String?
    var foodNutrients: [Nutrient]
    var servingSize: Float?
    var servingSizeUnit: String?
    var foodMeasures: [FoodMeasure]
    
    var caloriesPer100g: Int? {
        guard let calories = getNutrient(of: "KCAL")?.value else { return -1 }
        return Int(calories)
    }
    
    func getNutrient(of nutrient: String) -> Nutrient? {
        return foodNutrients.first { $0.unitName == nutrient }
    }
    
    struct Nutrient: Codable {
        // Note: Nutrient values per 100g or 100ml from values per serving
        var unitName: String
        var value: Float
    }
}

// MARK: - UI Methods

extension FoodSearchResults {
    func getNameFormatted() -> String {
        if brandName != nil {
            return description.capitalized.filter { $0 != "," }
        }
        return description
    }
    
//    func getCaloriesFormatted() -> String? {
//        guard let calories else { return nil }
//        return "\(calories) cal"
//    }
    
    func getServingSizeFormatted() -> String? {
        guard let servingSize, let servingSizeUnit else { return nil }
        return "\(Int(servingSize)) \(servingSizeUnit)"
    }
    
    func getBrandNameFormatted() -> String? {
        guard let brandName else { return nil }
        return brandName.capitalized
    }
}

struct FoodMeasure: Codable {
    var gramWeight: Int
    var disseminationText: String
    var rank: Int
}
