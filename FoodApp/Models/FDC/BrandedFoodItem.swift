//
//  BrandedFoodItem.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/2/25.
//

import Foundation

struct BrandedFoodItem: Codable {
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
}
