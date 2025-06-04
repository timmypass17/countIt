//
//  BrandedFoodItem.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/2/25.
//

import Foundation

// Branded foods do not have inputFood, only ingredients
struct BrandedFoodItem: FoodItem {
    let fdcId: Int
    let brandName: String
    let dataType: DataType
    let description: String
    let gtinUpc: String // barcode
    let ingredients: String
    let householdServingFullText: String // "2 Tbsp"
    let servingSize: Int    // 32.0
    let servingSizeUnit: String // "g"
    let brandedFoodCategory: String // "Popcorn, Peanuts, Seeds & Related Snacks"
    let foodNutrients: [FoodNutrient]
    let foodPortions: [FoodPortion] // branded fod has none
//    let labelNutrients unnecessary
    
    enum CodingKeys: String, CodingKey {
        case fdcId
        case brandName
        case dataType
        case description
        case gtinUpc
        case householdServingFullText
        case ingredients
        case servingSize
        case servingSizeUnit
        case brandedFoodCategory
        case foodNutrients
        case foodPortions
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fdcId = try container.decode(Int.self, forKey: .fdcId)
        self.brandName = try container.decode(String.self, forKey: .brandName)
        self.dataType = try container.decode(DataType.self, forKey: .dataType)
        self.description = try container.decode(String.self, forKey: .description).firstUppercased
        self.gtinUpc = try container.decode(String.self, forKey: .gtinUpc)
        self.householdServingFullText = try container.decode(String.self, forKey: .householdServingFullText)
        self.ingredients = try container.decode(String.self, forKey: .ingredients)
        self.servingSize = try container.decodeIfPresent(Int.self, forKey: .servingSize) ?? 1
        self.servingSizeUnit = try container.decode(String.self, forKey: .servingSizeUnit)
        self.brandedFoodCategory = try container.decode(String.self, forKey: .brandedFoodCategory)
//        var foodPortions = try container.decode([FoodPortion].self, forKey: .foodPortions)
        var foodPortions: [FoodPortion] = []
        foodPortions.append(FoodPortion.default100g)
        foodPortions.append(FoodPortion(id: 1, gramWeight: Double(servingSize)))
        self.foodPortions = foodPortions
        
        let rawNutrients = try container.decode([RawFoodNutrient].self, forKey: .foodNutrients)
        self.foodNutrients = rawNutrients.compactMap { raw in
            guard let nutrientId = NutrientId(rawValue: raw.nutrient.id) else { return nil }
            return FoodNutrient(nutrient: Nutrient(id: nutrientId, name: raw.nutrient.name, unitName: raw.nutrient.unitName, rank: 0), amount: raw.amount)
        }
    }
    
    func getFoodPortionDescription(foodPortion: FoodPortion, numberOfServings: Int = 1, options: [FoodEntryOptions] = FoodEntryOptions.allCases) -> String {
        var descriptionParts: [String] = []
        
        if options.contains(.calories) {
            descriptionParts.append("\(Int(getNutrientAmountPerServing(.calories, foodPortion: foodPortion) * Double(numberOfServings))) cal")
        }
        if options.contains(.servingSize) {
            descriptionParts.append(getServingSizeFormatted(foodPortion: foodPortion, numberOfServings: numberOfServings))
        }
        
        descriptionParts.append(brandName)
        
        return descriptionParts.joined(separator: ", ")
    }

}

struct InputFoodBranded: Codable {
    var ingredientCode: Int // 1145
    var unit: String
}
