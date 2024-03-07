//
//  FoodSearchResponse.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/2/24.
//

import Foundation

enum DataType: String, Decodable, CaseIterable {
    case srLegacy = "SR Legacy"
    case branded = "Branded"
}

struct SearchResponse: Decodable {
    var foods: [SearchResultFood]
    
    enum CodingKeys: String, CodingKey {
        case foods
    }
}

enum SearchResultFood: Decodable {
    case srLegacy(SRLegacyFoodItem)
    case branded(BrandedFoodItem)
    
    enum CodingKeys : String, CodingKey {
        case dataType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataType: DataType = try container.decode(DataType.self, forKey: .dataType)
        let singleContainer = try decoder.singleValueContainer()
        switch dataType {
        case .srLegacy:
            self = .srLegacy(try singleContainer.decode(SRLegacyFoodItem.self))
        case .branded:
            self = .branded(try singleContainer.decode(BrandedFoodItem.self))
        }
    }
    
    var description: String {
        switch self {
        case .srLegacy(let srLegacyFoodItem):
            return srLegacyFoodItem.description
        case .branded(let brandedFoodItem):
            return brandedFoodItem.description.capitalized
        }
    }
    
    
    var foodNutrients: [FoodNutrient] {
        switch self {
        case .srLegacy(let sRLegacyFoodItem):
            return sRLegacyFoodItem.foodNutrients
        case .branded(let brandedFoodItem):
            return brandedFoodItem.foodNutrients
        }
    }
    
    var foodPortions
    
    func getServingSizeFormatted() -> String {
        switch self {
        case .srLegacy(let sRLegacyFoodItem):
            guard let foodPortion = sRLegacyFoodItem.foodPortions.first else { return "No food portion" }
            return sRLegacyFoodItem.getServingSizeFormatted(foodPortion: foodPortion)
        case .branded(let brandedFoodItem):
            return brandedFoodItem.getServingSizeFormatted(servingGramWeight: brandedFoodItem.servingSize)
        }
    }
}

// Decode list of different types https://stackoverflow.com/questions/67949917/how-can-i-parse-an-json-array-of-a-list-of-different-object-using-codable
