//
//  BrandedFood.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/6/24.
//

import Foundation


struct BrandedFoodItem: Codable {
    let fdcId: Int
    let description: String
    let foodNutrients: [FoodNutrient]
    let brandName: String?
    let servingSize: Float
    let servingSizeUnit: String
}

// MARK: UI Methods

extension BrandedFoodItem {
    func getServingSizeFormatted(servingGramWeight: Float) -> String {
        guard let nutrient = foodNutrients.getNutrient(name: "Energy"),
              let caloriesPer100g = nutrient.amount
        else { return "No calories" }
        let caloriesPerServing = calculateCaloriePerServing(caloriesPer100g: caloriesPer100g, servingGramWeight: servingGramWeight)
        var servingSizeString = "\(Int(caloriesPerServing)) cal, \(servingSize.formattedString()) \(servingSizeUnit)"
        if let brandName {
            servingSizeString.append(", \(brandName)")
        }
        return servingSizeString
    }
}

extension Array where Element == FoodNutrient {
    func getNutrient(name: String) -> FoodNutrient? {
        return self.first { $0.nutrient.name.lowercased() == name.lowercased() }
    }
}


func calculateCaloriePerServing(caloriesPer100g: Float, servingGramWeight: Float) -> Float {
    return (caloriesPer100g * servingGramWeight) / 100
}

extension Float {
    func formattedString() -> String {
        return String(format: "%g", self)
    }
}
