//
//  FoundationFoodItem.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/3/25.
//

import Foundation

struct FoundationFoodItem: Codable {
    let fdcId: Int
    let dataType: DataType
    let description: String
    let foodNutrients: [FoodNutrient]
//    let inputFoods: [InputFoodFoundation]
}

//struct InputFoodFoundation: Codable {
//    let id: Int
//    let foodDescription: String
//    let inputFood: SampleFoodItem
//}
//
//struct SampleFoodItem: Codable {
//    let fdcId: Int
//    let datatype: DataType
//}
