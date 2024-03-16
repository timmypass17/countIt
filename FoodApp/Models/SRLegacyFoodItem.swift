//
//  SRLegacyFoodItem.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/6/24.
//

import Foundation

struct SRLegacyFoodItem: Codable {
    var fdcId: Int
    var description: String
    var foodNutrients: [FoodNutrient]
    var foodPortions: [FoodPortion]
    
    enum CodingKeys: String, CodingKey {
        case fdcId
        case description
        case foodNutrients
        case foodPortions
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fdcId = try container.decode(Int.self, forKey: .fdcId)
        self.description = try container.decode(String.self, forKey: .description)
        self.foodNutrients = try container.decode([FoodNutrient].self, forKey: .foodNutrients)
        self.foodPortions = try container.decodeIfPresent([FoodPortion].self, forKey: .foodPortions) ?? []
        
        // Add default portions
        foodPortions.append(FoodPortion(gramWeight: 100, modifier: "No modifier"))
    }
}

extension SRLegacyFoodItem {
//    func getServingSizeFormatted(foodPortion: FoodPortion) -> String {
//        guard let nutrient = foodNutrients.getNutrient(name: "Energy"),
//              let caloriesPer100g = nutrient.amount
//        else { return "No calories" }
//        let caloriesPerServing = calculateCaloriePerServing(caloriesPer100g: caloriesPer100g, servingGramWeight: foodPortion.gramWeight)
//        return "\(Int(caloriesPerServing)) cal, \(foodPortion.amount ?? -1) \(foodPortion.modifier) (\(foodPortion.gramWeight.formattedString()) g)"
//    }
}
