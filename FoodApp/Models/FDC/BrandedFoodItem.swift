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
    let brandName: String?
    let dataType: DataType
    let description: String
    let gtinUpc: String // barcode
    let householdServingFullText: String // "2 Tbsp"
    let servingSize: Double    // 32.0, 0.25
    let servingSizeUnit: String // "g"
    let brandedFoodCategory: String // "Popcorn, Peanuts, Seeds & Related Snacks"
    let foodNutrients: [FoodNutrient]
    let foodPortions: [FoodPortion] // branded fod has none
    let ingredients: [FoodItem] = []
    var selectedFoodPortion: FoodPortion
    var quantity: Int = 1

//    let labelNutrients unnecessary
    
    enum CodingKeys: String, CodingKey {
        case fdcId
        case brandName
        case dataType
        case description
        case gtinUpc
        case householdServingFullText
        case servingSize
        case servingSizeUnit
        case brandedFoodCategory
        case foodNutrients
        case foodPortions
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fdcId = try container.decode(Int.self, forKey: .fdcId)
        self.brandName = try container.decodeIfPresent(String.self, forKey: .brandName)?.capitalized
        self.dataType = try container.decode(DataType.self, forKey: .dataType)
        self.description = try container.decode(String.self, forKey: .description).firstUppercased
        self.gtinUpc = try container.decode(String.self, forKey: .gtinUpc)
        let householdServingFullText = try container.decode(String.self, forKey: .householdServingFullText)
        self.householdServingFullText = householdServingFullText
        let servingSize = try container.decodeIfPresent(Double.self, forKey: .servingSize) ?? 1
        self.servingSize = servingSize
        self.servingSizeUnit = try container.decode(String.self, forKey: .servingSizeUnit)
        self.brandedFoodCategory = try container.decode(String.self, forKey: .brandedFoodCategory)

        var foodPortions: [FoodPortion] = []
        foodPortions.append(.default100g)
        
        if let (quantity, modifier) = extractQuantityAndModifier(from: householdServingFullText) {
            foodPortions.append(FoodPortion(id: 1, amount: quantity, gramWeight: servingSize, modifier: modifier))
        } else {
            foodPortions.append(FoodPortion(id: 1, gramWeight: servingSize))
        }
        foodPortions.sort { $0.gramWeight ?? 0 < $1.gramWeight ?? 0 }
        self.foodPortions = foodPortions
        
        // Prefer serving size on product (BrandedFood only have 1 portion)
        if let foodPortion = foodPortions.first(where: { $0.gramWeight == Double(servingSize) }) {
            self.selectedFoodPortion = foodPortion
        } else {
            self.selectedFoodPortion = .default100g
        }
        
        var foodNutrients: [FoodNutrient] = []
        let rawNutrients = try container.decode([RawFoodNutrient].self, forKey: .foodNutrients)
        for nutrientId in NutrientId.allCases {
            if let rawNutrient = rawNutrients.first(where: {
                guard let raw = $0.nutrient else { return false }
                return NutrientId(rawValue: raw.id) == nutrientId
            }) {
                // Nutrient exists
                print("\(nutrientId.description) exist \(Double(rawNutrient.amount))")
                let nutrient = FoodNutrient(nutrient: Nutrient(id: nutrientId, name: nutrientId.description, unitName: nutrientId.unitName, rank: 0), amount: rawNutrient.amount)
                foodNutrients.append(nutrient)
            } else {
                // Add placeholder
                print("\(nutrientId.description) doesn't exist")
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
    }
    
    func getFoodPortionDescription(foodPortion: FoodPortion, numberOfServings: Int = 1, options: [FoodEntryOptions] = FoodEntryOptions.allCases) -> String {
        var descriptionParts: [String] = []
        
        if options.contains(.calories) {
            descriptionParts.append("\(Int(getNutrientAmountPerServing(.calories, foodPortion: foodPortion) * Double(numberOfServings))) cal")
        }
        if options.contains(.servingSize) {
            descriptionParts.append(getServingSizeFormatted(foodPortion: foodPortion, numberOfServings: numberOfServings))
        }
        
        if let brandName {
            descriptionParts.append(brandName)
        }
        
        return descriptionParts.joined(separator: ", ")
    }

}

struct InputFoodBranded: Codable {
    var ingredientCode: Int // 1145
    var unit: String
}
