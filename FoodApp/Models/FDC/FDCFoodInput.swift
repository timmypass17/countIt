//
//  FDCIngredient.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/2/25.
//

import Foundation

// https://api.nal.usda.gov/fdc/v1/foods?fdcIds=2709225&api_key={{apiKey}} via fdcIds
struct FDCFoodInput: Codable {
    var fdcId: Int
    var name: String
    var amount: Double?
    var ingredientWeight: Double?
    var portionCode: String?
    var portionDescription: String?
    var unit: String? // "GM"
    var sequenceNumber: Int?
//     ingredientDescription same value as foodDescription?
    
    enum CodingKeys: String, CodingKey {
        case fdcId = "id"
        case name = "foodDescription"
        case ingredientWeight
        case amount
        case portionCode
        case portionDescription
        case unit
        case sequenceNumber
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fdcId = try container.decode(Int.self, forKey: .fdcId)
        name = try container.decode(String.self, forKey: .name)
        ingredientWeight = try container.decodeIfPresent(Double.self, forKey: .ingredientWeight) ?? 0
        amount = try container.decodeIfPresent(Double.self, forKey: .amount) ?? 0
        portionCode = try container.decodeIfPresent(String.self, forKey: .portionCode) ?? ""
        portionDescription = try container.decodeIfPresent(String.self, forKey: .portionDescription) ?? ""
        unit = try container.decodeIfPresent(String.self, forKey: .unit) ?? ""
        sequenceNumber = try container.decodeIfPresent(Int.self, forKey: .sequenceNumber) ?? 0
    }
}

//struct FDCFoodInput: Codable {
//    var fdcId: Int
//    var name: String
//    var value: Int
//    var gramWeight: Int
//    var portionCode: String
//    var portionDescription: String
//    var unit: String // "GM"
//    var rank: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case fdcId = "srCode"
//        case name = "foodDescription"
//        case gramWeight
//        case value
//        case portionCode
//        case portionDescription
//        case unit
//        case rank
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        fdcId = try container.decode(Int.self, forKey: .fdcId)
//        name = try container.decode(String.self, forKey: .name)
//        gramWeight = try container.decode(Int.self, forKey: .gramWeight)
//        value = try container.decode(Int.self, forKey: .value)
//        portionCode = try container.decode(String.self, forKey: .portionCode)
//        portionDescription = try container.decode(String.self, forKey: .portionDescription)
//        unit = try container.decode(String.self, forKey: .unit)
//        rank = try container.decode(Int.self, forKey: .rank)
//    }
//}
