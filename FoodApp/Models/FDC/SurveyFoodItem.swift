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
    let foodNutrients: [FoodNutrient]
    let brandName: String? = "USDA"
    let ingredients: [FoodItem] = []
    var selectedFoodPortion: FoodPortion

    enum CodingKeys: String, CodingKey {
        case fdcId
        case dataType
        case description
        case foodPortions
        case foodNutrients
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fdcId = try container.decode(Int.self, forKey: .fdcId)
        dataType = try container.decode(DataType.self, forKey: .dataType)
        description = try container.decode(String.self, forKey: .description).firstUppercased
        var foodPortions = try container.decode([FoodPortion].self, forKey: .foodPortions)
        foodPortions.append(FoodPortion.default100g)
        foodPortions.sort { $0.gramWeight ?? 0 < $1.gramWeight ?? 0 }
        self.foodPortions = foodPortions
        let rawNutrients = try container.decode([RawFoodNutrient].self, forKey: .foodNutrients)
        self.foodNutrients = rawNutrients.compactMap { raw in
            guard let nutrientId = NutrientId(rawValue: raw.nutrient.id) else { return nil }
            return FoodNutrient(nutrient: Nutrient(id: nutrientId, name: raw.nutrient.name, unitName: raw.nutrient.unitName, rank: 0), amount: raw.amount)
        }
        self.selectedFoodPortion = foodPortions[foodPortions.count / 2]
    }
    
    
    func getFoodPortionDescription(foodPortion: FoodPortion, numberOfServings: Int = 1, options: [FoodEntryOptions] = FoodEntryOptions.allCases) -> String {
            var descriptionParts: [String] = []

            if options.contains(.calories) {
                descriptionParts.append("\(Int(getNutrientAmountPerServing(.calories, foodPortion: foodPortion) * Double(numberOfServings))) cal")
            }
            if options.contains(.servingSize) {
                descriptionParts.append(getServingSizeFormatted(foodPortion: foodPortion, numberOfServings: numberOfServings))
            }
            
            descriptionParts.append("USDA")
            
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
    let inputFood: SurveyFoodItem?

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
        inputFood = try container.decodeIfPresent(SurveyFoodItem.self, forKey: .inputFood)
    }
}
