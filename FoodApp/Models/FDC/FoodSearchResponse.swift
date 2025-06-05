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
    var foodParts: [SearchResultFood]
    var foods: [FoodItem] = []
    
    enum CodingKeys: String, CodingKey {
        case totalHits
        case foodParts = "foods"
        case currentPage
        case totalPages
    }
}

/// Calculates the amount of a nutrient based on serving size.
/// - Parameters:
///   - amountPer100g: Nutrient amount per 100g (as provided by USDA).
///   - actualServingSize: The actual serving size in grams or milliliters.
/// - Returns: The scaled nutrient amount for the given serving.
func scaledNutrientAmount(amountPer100g: Double, actualServingSize: Double) -> Double {
    guard actualServingSize > 0 else { return 0 }
    return (amountPer100g / 100) * Double(actualServingSize)
}

struct SearchResultFood: Codable {
    var fdcId: Int
    var description: String
    let dataType: DataType
    let brandName: String
    let foodNutrients: [SearchResultFoodNutrient]
    var foodMeasures: [SearchResultFoodMeasurement] = []
    let servingSizeUnit: String // g    // TODO: Make be ml?
    let servingSize: Float // 32.0
    let householdServingFullText: String? // "2 Tbsp"
    
    var calories: Float {
        return 0
//        let caloriesPer100g = foodNutrients[.calories]?.value ?? 0
//        return (caloriesPer100g * servingSize) / 100
    }
    
    enum CodingKeys: String, CodingKey {
        case fdcId
        case description
        case dataType
        case brandName
        case foodNutrients
        case foodMeasures
        case servingSizeUnit
        case servingSize
        case householdServingFullText
    }
    
    init(
        fdcId: Int,
        description: String,
        dataType: DataType,
        brandName: String,
        foodNutrients: [SearchResultFoodNutrient],
        foodMeasures: [SearchResultFoodMeasurement],
        servingSizeUnit: String,
        servingSize: Float,
        householdServingFullText: String? = nil,
        ingredients: String
    ) {
        self.fdcId = fdcId
        self.description = description
        self.dataType = dataType
        self.brandName = brandName
        self.foodNutrients = foodNutrients
        self.foodMeasures = foodMeasures
        self.servingSizeUnit = servingSizeUnit
        self.servingSize = servingSize
        self.householdServingFullText = householdServingFullText
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fdcId = try container.decode(Int.self, forKey: .fdcId)
        self.description = try container.decode(String.self, forKey: .description)
        self.dataType = try container.decode(DataType.self, forKey: .dataType)
        self.brandName = try container.decodeIfPresent(String.self, forKey: .brandName)?.capitalized ?? "USDA"
        self.householdServingFullText = try container.decodeIfPresent(String.self, forKey: .householdServingFullText)
        self.servingSizeUnit = try container.decodeIfPresent(String.self, forKey: .servingSizeUnit) ?? "g"
        self.servingSize = try container.decodeIfPresent(Float.self, forKey: .servingSize) ?? 100
        let rawNutrients = try container.decode([RawSearchResultFoodNutrients].self, forKey: .foodNutrients)
        self.foodNutrients = rawNutrients.compactMap { raw in
            guard let nutrientId = NutrientId(rawValue: raw.nutrientId) else { return nil }
            return SearchResultFoodNutrient(nutrientId: nutrientId, nutrientName: raw.nutrientName, unitName: raw.unitName.lowercased(), value: raw.value, indentLevel: raw.indentLevel)
        }
        
        var foodMeasures = try container.decode([SearchResultFoodMeasurement].self, forKey: .foodMeasures)
        if let householdServingFullText {
            foodMeasures.append(SearchResultFoodMeasurement(id: Int(Date().timeIntervalSince1970 * 1000), disseminationText: householdServingFullText, gramWeight: servingSize, rank: 0))
        }
        foodMeasures.append(SearchResultFoodMeasurement(id: 0, disseminationText: nil, gramWeight: 100, rank: 0))
        foodMeasures.sort { $0.gramWeight > $1.gramWeight }
        
        
        for (index, _) in foodMeasures.enumerated() {
            foodMeasures[index].rank = index
        }
        
        self.foodMeasures = foodMeasures
    }
    
    enum DescriptionOptions: CaseIterable {
        case calories, servingSize, brand
    }
    
    private func getDescription(options: [DescriptionOptions] = DescriptionOptions.allCases) -> String {
        if let householdServingFullText {
            let caloriesText = "\(Int(calories)) cal"
            var servingSizeText: String = "\(Int(servingSize)) \(servingSizeUnit)"  // 100 g
            servingSizeText = "\(householdServingFullText) (\(Int(servingSize)) \(servingSizeUnit))" // 2 tbsp (100 g)
            return [caloriesText, servingSizeText, brandName].joined(separator: ", ")
        }
        
        let foodMeasurement = foodMeasures[(foodMeasures.count - 1) / 2]
        let calories = getNutrients(.calories, foodMeasurement: foodMeasurement)
//        let calories = 0
        let caloriesText = "\(Int(calories)) cal"
        let servingSizeText = "\(foodMeasurement.gramWeight) g"
        return [caloriesText, servingSizeText, brandName].joined(separator: ", ")
    }
    
    var searchResultDescription: String {
        return getDescription(options: [.calories, .servingSize, .brand])
    }
    
    func getNutrients(_ nutrientID: NutrientId, foodMeasurement: SearchResultFoodMeasurement, quantity: Int = 1) -> Float {
        return 0
//        guard let caloriesPer100g = foodNutrients[nutrientID]?.value else { return 0 }
//        let amount = (caloriesPer100g * Float(foodMeasurement.gramWeight)) / 100
//        return amount * Float(quantity)
    }
    
//    func convertToFoodItem() -> FoodItem {
//        let foodNutrients = foodNutrients.map {
//            FoodNutrient(nutrient: Nutrient(id: $0.nutrientId, name: $0.nutrientName, unitName: $0.unitName, rank: 0), amount: Double($0.value))
//        }
//        let foodPortions = foodMeasures.map {
//            FoodPortion(id: $0.id, amount: $0., gramWeight: <#T##Double#>, modifier: <#T##String?#>, portionDescription: <#T##String?#>)
//        }
//        return CDFoodItem(fdcId: fdcId, description: description, dataType: dataType, foodNutrients: foodNutrients, foodPortions: <#T##[FoodPortion]#>, brandName: <#T##String#>)
//    }
}

struct SearchResultFoodNutrient: Codable {
    let nutrientId: NutrientId  // 1008
    let nutrientName: String    // Energy
    let unitName: String    // KCAL
    let value: Float
    let indentLevel: Int
    
    enum CodingKeys: String, CodingKey {
        case nutrientId
        case nutrientName
        case unitName
        case value
        case indentLevel
    }
    
    init(nutrientId: NutrientId, nutrientName: String, unitName: String, value: Float, indentLevel: Int) {
        self.nutrientId = nutrientId
        self.nutrientName = nutrientName
        self.unitName = unitName
        self.value = value
        self.indentLevel = indentLevel
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nutrientId = try container.decode(NutrientId.self, forKey: .nutrientId)
        self.nutrientName = try container.decode(String.self, forKey: .nutrientName)
        self.unitName = try container.decode(String.self, forKey: .unitName).lowercased()
        self.value = try container.decodeIfPresent(Float.self, forKey: .value) ?? 0
        self.indentLevel = try container.decode(Int.self, forKey: .indentLevel)
    }
}

//extension SearchResultFoodNutrient: NutrientIdentifiable {
//    var nutrientIdentifier: Int {
//        return nutrientId.rawValue
//    }
//}

extension SearchResultFoodNutrient {
    static func empty(_ nutrientId: NutrientId) -> SearchResultFoodNutrient {
        return SearchResultFoodNutrient(nutrientId: nutrientId, nutrientName: nutrientId.description, unitName: nutrientId.unitName, value: 0, indentLevel: -1)
    }
}

struct RawSearchResultFoodNutrients: Codable {
    let nutrientId: Int
    let nutrientName: String
    let unitName: String
    let value: Float
    let indentLevel: Int
    
    enum CodingKeys: CodingKey {
        case nutrientId
        case nutrientName
        case unitName
        case value
        case indentLevel
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nutrientId = try container.decode(Int.self, forKey: .nutrientId)
        self.nutrientName = try container.decode(String.self, forKey: .nutrientName)
        self.unitName = try container.decode(String.self, forKey: .unitName)
        self.value = try container.decodeIfPresent(Float.self, forKey: .value) ?? 0
        self.indentLevel = try container.decode(Int.self, forKey: .indentLevel)
    }
}

struct SearchResultFoodMeasurement: Codable {
    let id: Int
    var disseminationText: String?
    let gramWeight: Float
    var rank: Int
    
    var servingSizeDescription: String {
        if let disseminationText {
            return "\(disseminationText) (\(Int(gramWeight)) g)"
        }
        
        return "\(Int(gramWeight)) g"
    }
    
    enum CodingKeys: CodingKey {
        case id
        case disseminationText
        case gramWeight
        case rank
    }
    
    init(id: Int, disseminationText: String?, gramWeight: Float, rank: Int) {
        self.id = id
        self.disseminationText = disseminationText
        self.gramWeight = gramWeight
        self.rank = rank
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        let disseminationText = try container.decode(String.self, forKey: .disseminationText)
        if disseminationText != "Quantity not specified" {
            self.disseminationText = disseminationText
        }
        self.gramWeight = try container.decode(Float.self, forKey: .gramWeight)
        self.rank = try container.decode(Int.self, forKey: .rank)
    }
}

