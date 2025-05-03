//
//  SurveyFoodItem.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/2/25.
//

import Foundation

// Survey (FNDDS)
// Source: Food and Nutrient Database for Dietary Studies (FNDDS)
// Purpose: Foods reported in national nutrition surveys (e.g., NHANES)
// Contents:
//     Real-world reported foods
//     Includes recipes/ingredients (e.g. “Spaghetti with tomato sauce”)
//     Often includes portion sizes and preparation methods
                                            
struct SurveyFoodItem: FoodItem {
    let fdcId: Int
    let dataType: DataType
    let description: String
    let foodPortions: [FoodPortion]
    let inputFoods: [InputFoodSurvey]
    let foodNutrients: [FoodNutrient]
}

struct InputFoodSurvey: Codable {
    let id: Int
    let amount: Float
    let foodDescription: String
    let ingredientDescription: String
    let ingredientWeight: Float
    let portionDescription: String
    let sequenceNumber: Int
    let unit: String         // e.g. "TB"
    let inputFood: [InputFoodSurvey]  // may not exist, recusive?

    enum CodingKeys: String, CodingKey {
        case id
        case amount
        case foodDescription
        case ingredientDescription
        case ingredientWeight
        case portionDescription
        case sequenceNumber
        case unit
        case inputFood
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        amount = try container.decode(Float.self, forKey: .amount)
        foodDescription = try container.decode(String.self, forKey: .foodDescription)
        ingredientDescription = try container.decode(String.self, forKey: .ingredientDescription)
        ingredientWeight = try container.decode(Float.self, forKey: .ingredientWeight)
        portionDescription = try container.decode(String.self, forKey: .portionDescription)
        sequenceNumber = try container.decode(Int.self, forKey: .sequenceNumber)
        unit = try container.decode(String.self, forKey: .unit)
        inputFood = try container.decodeIfPresent([InputFoodSurvey].self, forKey: .inputFood) ?? []
    }
}
