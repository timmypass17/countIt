//
//  FoundationFoodItem.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/3/25.
//

import Foundation

struct FoundationFoodItem: FoodItem {
    let fdcId: Int
    let dataType: DataType
    let description: String
    var foodNutrients: [FoodNutrient]
    let foodPortions: [FoodPortion] // not in foundation
    let brandName: String? = "USDA"
    let ingredients: [FoodItem] = []
    var selectedFoodPortion: FoodPortion
    var quantity: Int = 1
    
    enum CodingKeys: String, CodingKey {
        case fdcId
        case dataType
        case description
        case foodNutrients
        case foodPortions
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fdcId = try container.decode(Int.self, forKey: .fdcId)
        dataType = try container.decode(DataType.self, forKey: .dataType)
        description = try container.decode(String.self, forKey: .description).firstUppercased
        let rawNutrients = try container.decode([RawFoodNutrient].self, forKey: .foodNutrients)
        var foodNutrients: [FoodNutrient] = []
        for nutrientId in NutrientId.allCases {
            if let rawNutrient = rawNutrients.first(where: {
                guard let raw = $0.nutrient else { return false }
                return NutrientId(rawValue: raw.id) == nutrientId
            }) {
                // Nutrient exists
                let nutrient = FoodNutrient(nutrient: Nutrient(id: nutrientId, name: nutrientId.description, unitName: nutrientId.unitName, rank: 0), amount: Double(rawNutrient.amount))
                foodNutrients.append(nutrient)
            } else {
                // Add placeholder
                let empty = FoodNutrient(nutrient: Nutrient(id: nutrientId, name: nutrientId.description, unitName: nutrientId.unitName, rank: 0), amount: 0)
                foodNutrients.append(empty)
            }
        }

        // Edge case: Calories is missing, fallback on other calories
        if let caloriesIndex = foodNutrients.firstIndex(where: { $0.nutrientId == .calories }) {
            let calories = foodNutrients[caloriesIndex]
            if calories.amount == 0 {
                // Fall back on other calories
                if let fallbackCalories = foodNutrients.first(where: { $0.nutrientId == .fallbackCalories }) {
                    foodNutrients[caloriesIndex].amount = fallbackCalories.amount
                }
            }
        }

        self.foodNutrients = foodNutrients
        var foodPortions = try container.decodeIfPresent([FoodPortion].self, forKey: .foodPortions) ?? []
        foodPortions.append(FoodPortion.default100g)
        foodPortions.sort { $0.gramWeight ?? 0 < $1.gramWeight ?? 0 }
        self.foodPortions = foodPortions
        self.selectedFoodPortion = foodPortions[foodPortions.count / 2]
//        print("timmy decode selectedFoodPortion: \(selectedFoodPortion)")
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

struct InputFoodFoundation: Codable {
//    let id: Int
    let foodDescription: String
    let inputFood: SampleFoodItem
}

struct SampleFoodItem: Codable {
    let fdcId: Int
//    let datatype: DataType
}

enum FoodEntryOptions: CaseIterable {
    case calories, servingSize, brandName
}
