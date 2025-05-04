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

    enum CodingKeys: String, CodingKey {
        case fdcId
        case dataType
        case description
        case foodPortions
        case inputFoods
        case foodNutrients
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fdcId = try container.decode(Int.self, forKey: .fdcId)
        dataType = try container.decode(DataType.self, forKey: .dataType)
        description = try container.decode(String.self, forKey: .description)
        var foodPortions = try container.decode([FoodPortion].self, forKey: .foodPortions)
        foodPortions.append(FoodPortion(gramWeight: 100, modifier: "grams", sequenceNumber: 0, portionDescription: "", measureUnit: MeasureUnit(id: 0, name: "", abbreviation: "")))
        self.foodPortions = foodPortions
        inputFoods = try container.decode([InputFoodSurvey].self, forKey: .inputFoods)
        foodNutrients = try container.decode([FoodNutrient].self, forKey: .foodNutrients)
    }
    
    
    func getFoodPortionDescription(foodPortion: FoodPortion, numberOfServings: Int = 1, options: [FoodEntryOptions] = FoodEntryOptions.allCases) -> String {
            var descriptionParts: [String] = []

            if options.contains(.calories) {
                descriptionParts.append("\(Int(getNutrientAmountPerServing(.calories, foodPortion: foodPortion) * Float(numberOfServings))) cal")
            }
            if options.contains(.servingSize) {
                descriptionParts.append(getServingSizeFormatted(foodPortion: foodPortion, numberOfServings: numberOfServings))
            }
            
            descriptionParts.append("USDA (survey)")
            
            return descriptionParts.joined(separator: ", ")
    }

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
