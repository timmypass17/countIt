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
    let foodNutrients: [FoodNutrient]
    let foodPortions: [FoodPortion] // not in foundation
    
    enum CodingKeys: String, CodingKey {
        case fdcId
        case dataType
        case description
        case foodNutrients
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fdcId = try container.decode(Int.self, forKey: .fdcId)
        dataType = try container.decode(DataType.self, forKey: .dataType)
        description = try container.decode(String.self, forKey: .description)
        
        let rawNutrients = try container.decode([RawFoodNutrient].self, forKey: .foodNutrients)
        self.foodNutrients = rawNutrients.compactMap { raw in
            guard let nutrientId = NutrientId(rawValue: raw.nutrient.id) else { return nil }
            return FoodNutrient(nutrient: Nutrient(id: nutrientId, name: raw.nutrient.name, unitName: raw.nutrient.unitName, rank: 0), amount: raw.amount)
        }
        
        foodPortions = [FoodPortion(gramWeight: 100, modifier: "grams", sequenceNumber: 0, portionDescription: "", measureUnit: MeasureUnit(id: 0, name: "", abbreviation: ""))]
    }
    
    
    func getFoodPortionDescription(foodPortion: FoodPortion, numberOfServings: Int = 1, options: [FoodEntryOptions] = FoodEntryOptions.allCases) -> String {
            var descriptionParts: [String] = []

            if options.contains(.calories) {
                descriptionParts.append("\(Int(getNutrientAmountPerServing(.calories, foodPortion: foodPortion) * Float(numberOfServings))) cal")
            }
            if options.contains(.servingSize) {
                descriptionParts.append(getServingSizeFormatted(foodPortion: foodPortion, numberOfServings: numberOfServings))
            }
            
            descriptionParts.append("USDA (foundation)")
            
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
