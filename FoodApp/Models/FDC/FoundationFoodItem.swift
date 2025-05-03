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
    let foodPortions: [FoodPortion]
//    let inputFoods: [InputFoodFoundation]
    
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
        foodNutrients = try container.decode([FoodNutrient].self, forKey: .foodNutrients)
        foodPortions = []   // add default 100g
    }
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
