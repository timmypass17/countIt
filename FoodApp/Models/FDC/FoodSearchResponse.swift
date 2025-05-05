//
//  AbridgedSearchResponse.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/7/24.
//

import Foundation

struct FoodSearchResponse: Decodable {
    let totalHits: Int
    var currentPage: Int
    var totalPages: Int
    var foods: [SearchResultFood]
    
    enum CodingKeys: String, CodingKey {
        case totalHits
        case foods
        case currentPage
        case totalPages
    }
}

struct SearchResultFood: Codable {
    var fdcId: Int
    var description: String
    let dataType: DataType
    let brandName: String
    let foodNutrients: [SearchResultFoodNutrients]
    let servingSizeUnit: String // g
    let servingSize: Float // 32.0
    let householdServingFullText: String? // "2 Tbsp"
    
    var calories: Float {
        let caloriesPer100g = foodNutrients[.calories]?.value ?? 0
        return (caloriesPer100g * servingSize) / 100
    }
    
    enum CodingKeys: String, CodingKey {
        case fdcId
        case description
        case dataType
        case brandName
        case foodNutrients
        case servingSizeUnit
        case servingSize
        case householdServingFullText

    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fdcId = try container.decode(Int.self, forKey: .fdcId)
        self.description = try container.decode(String.self, forKey: .description)
        self.dataType = try container.decode(DataType.self, forKey: .dataType)
        self.brandName = try container.decodeIfPresent(String.self, forKey: .brandName)?.capitalized ?? "USDA"
        self.foodNutrients = try container.decode([SearchResultFoodNutrients].self, forKey: .foodNutrients)
        self.servingSizeUnit = try container.decodeIfPresent(String.self, forKey: .servingSizeUnit) ?? "g"
        self.servingSize = try container.decodeIfPresent(Float.self, forKey: .servingSize) ?? 100
        self.householdServingFullText = try container.decodeIfPresent(String.self, forKey: .householdServingFullText)
    }
    
    func getDescription() -> String {
        let caloriesText = "\(Int(calories)) cal"
        var servingSizeText: String = "\(Int(servingSize)) \(servingSizeUnit)"  // 100 g
        if let householdServingFullText = householdServingFullText {
            servingSizeText = "\(householdServingFullText) (\(Int(servingSize)) \(servingSizeUnit))" // 2 tbsp (100 g)
        }

        return [caloriesText, servingSizeText, brandName].joined(separator: ", ")
    }
}

struct SearchResultFoodNutrients: Codable {
    let nutrientId: NutrientID  // 1008
    let nutrientName: String    // Energy
    let unitName: String    // KCAL
    let value: Float
    
    enum CodingKeys: String, CodingKey {
        case nutrientId
        case nutrientName
        case unitName
        case value
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nutrientId = try container.decode(NutrientID.self, forKey: .nutrientId)
        self.nutrientName = try container.decode(String.self, forKey: .nutrientName)
        self.unitName = try container.decode(String.self, forKey: .unitName)
        self.value = try container.decode(Float.self, forKey: .value)
    }
}

extension Array where Element == SearchResultFoodNutrients {
    subscript(nutrientID: NutrientID) -> SearchResultFoodNutrients? {
        return self.first(where: { $0.nutrientId == nutrientID })
    }
}
