//
//  FoodItemWrapper.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/4/25.
//

import Foundation

// Wrapper to treat CDFood as USDA food
struct CDFoodItem: FoodItem {
    var fdcId: Int
    var description: String
    var dataType: DataType
    var foodNutrients: [FoodNutrient]
    var foodPortions: [FoodPortion]
    var brandName: String?
    var ingredients: [FoodItem] = []
    var selectedFoodPortion: FoodPortion
    var quantity: Int = 1
    
    func getFoodPortionDescription(foodPortion: FoodPortion, numberOfServings: Int, options: [FoodEntryOptions]) -> String {
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
    
    private enum CodingKeys: String, CodingKey {
        case fdcId
        case description
        case dataType
        case foodNutrients
        case foodPortions
        case brandName
    }
    
    init(
        fdcId: Int,
        description: String,
        dataType: DataType,
        foodNutrients: [FoodNutrient],
        foodPortions: [FoodPortion],
        brandName: String?,
        ingredients: [CDFoodItem] = [],
        selectedFoodPortion: FoodPortion,
        quantity: Int
    ) {
        self.fdcId = fdcId
        self.description = description
        self.dataType = dataType
        self.foodNutrients = foodNutrients
        self.foodPortions = foodPortions
        self.brandName = brandName
        self.ingredients = ingredients
        self.selectedFoodPortion = selectedFoodPortion
        self.quantity = quantity
    }
    
    // Never gets called
    init(from decoder: Decoder) throws {
        fatalError()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fdcId = try container.decode(Int.self, forKey: .fdcId)
        description = try container.decode(String.self, forKey: .description)
        dataType = try container.decode(DataType.self, forKey: .dataType)
        foodNutrients = try container.decode([FoodNutrient].self, forKey: .foodNutrients)
        foodPortions = try container.decode([FoodPortion].self, forKey: .foodPortions)
        brandName = try container.decodeIfPresent(String.self, forKey: .brandName)
        selectedFoodPortion = FoodPortion(id: 0, gramWeight: 0)
    }
}
