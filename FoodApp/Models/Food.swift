//
//  Food.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/3/24.
//

import Foundation

struct Food: Codable {
    var foodNutrients: [FoodNutrient]? = []
    var foodPortions: [FoodPortion]? = []
    
    var calories: Int? {
        guard let nutrient = getFoodNutrient(of: "kcal"),
              let calories = nutrient.amount,
              let foodPortion = foodPortions?.first
        else { return nil }
        
        let servingSize = foodPortion.gramWeight
        return Int((calories * servingSize)) / 100
    }
    
    func getFoodNutrient(of nutrient: String) -> FoodNutrient? {
        return foodNutrients?.first { $0.nutrient.unitName == nutrient }
    }
    
}

// MARK: - UI Methods

extension Food {
    func getCaloriesFormatted() -> String? {
        guard let calories else { return nil }
        return "\(calories) cal"
    }

    func getServingSizeFormatted() -> String? {
        guard let foodPortion = foodPortions?.first,
              let amount = foodPortion.amount
        else { return nil }
        return "\(Int(amount)) \(foodPortion.modifier) (\(foodPortion.gramWeight) g)" // TODO: always in grams?
    }
}

struct FoodNutrient: Codable {
    var nutrient: Nutrient
    var amount: Float?   // per 100g
}

struct Nutrient: Codable {
    var unitName: String
}

struct FoodPortion: Codable {
    var amount: Float?
    var gramWeight: Float
    var modifier: String
}
