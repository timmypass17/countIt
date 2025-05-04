//
//  BrandedFoodItem.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/2/25.
//

import Foundation

struct BrandedFoodItem: FoodItem {
    let fdcId: Int
    let brandOwner: String
    let dataType: DataType
    let description: String
    let gtinUpc: String // barcode
    let householdServingFullText: String // "1 ONZ"
    let ingredients: String
    let servingSize: Int
    let servingSizeUnit: String // "g"
    let brandedFoodCategory: String // "Popcorn, Peanuts, Seeds & Related Snacks"
    let foodNutrients: [FoodNutrient]
    let foodPortions: [FoodPortion]
//    let labelNutrients unnecessary
    
    enum CodingKeys: String, CodingKey {
        case fdcId
        case brandOwner
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
        self.brandOwner = try container.decode(String.self, forKey: .brandOwner)
        self.dataType = try container.decode(DataType.self, forKey: .dataType)
        self.description = try container.decode(String.self, forKey: .description)
        self.gtinUpc = try container.decode(String.self, forKey: .gtinUpc)
        self.householdServingFullText = try container.decode(String.self, forKey: .householdServingFullText)
        self.ingredients = try container.decode(String.self, forKey: .ingredients)
        self.servingSize = try container.decodeIfPresent(Int.self, forKey: .servingSize) ?? 1
        self.servingSizeUnit = try container.decode(String.self, forKey: .servingSizeUnit)
        self.brandedFoodCategory = try container.decode(String.self, forKey: .brandedFoodCategory)
        self.foodNutrients = try container.decode([FoodNutrient].self, forKey: .foodNutrients)
        var foodPortions = try container.decode([FoodPortion].self, forKey: .foodPortions)
        foodPortions.append(FoodPortion(gramWeight: 100, modifier: "grams", sequenceNumber: 0, portionDescription: "", measureUnit: MeasureUnit(id: 0, name: "", abbreviation: "")))
        self.foodPortions = foodPortions
    }
    
    func getFoodPortionDescription(foodPortion: FoodPortion, numberOfServings: Int = 1, options: [FoodEntryOptions] = FoodEntryOptions.allCases) -> String {
        var descriptionParts: [String] = []
        
        if options.contains(.calories) {
            descriptionParts.append("\(Int(getNutrientAmountPerServing(.calories, foodPortion: foodPortion) * Float(numberOfServings))) cal")
        }
        if options.contains(.servingSize) {
            descriptionParts.append(getServingSizeFormatted(foodPortion: foodPortion, numberOfServings: numberOfServings))
        }
        
        descriptionParts.append(brandOwner)
        
        return descriptionParts.joined(separator: ", ")
    }

}
