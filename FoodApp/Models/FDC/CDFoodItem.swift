//
//  FoodItemWrapper.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/4/25.
//

import Foundation

struct CDFoodItem: FoodItem {
    var fdcId: Int
    
    var description: String
    
    var dataType: DataType
    
    var foodNutrients: [FoodNutrient]
    
    var foodPortions: [FoodPortion]
    
    var brandName: String
    
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
    
    
}
