//
//  Food.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/3/24.
//

import Foundation
import CoreData

struct Food: Codable {
    let fdcId: Int
    var description: String
    var foodNutrients: [FoodNutrient]
    var foodPortions: [FoodPortion] // added
    var brandName: String?
    let dataType: DataType
    
    let servingSize: Float?
    let servingSizeUnit: String?
    
    enum CodingKeys: String, CodingKey {
        case fdcId
        case description
        case foodNutrients
        case foodPortions
        case brandName
        case dataType
        case servingSize
        case servingSizeUnit
    }
    
    init(fdcId: Int, description: String, foodNutrients: [FoodNutrient], foodPortions: [FoodPortion], brandName: String?, dataType: DataType, servingSize: Float?, servingSizeUnit: String?) {
            self.fdcId = fdcId
            self.description = description
            self.foodNutrients = foodNutrients
            self.foodPortions = foodPortions
            self.brandName = brandName
            self.dataType = dataType
            self.servingSize = servingSize
            self.servingSizeUnit = servingSizeUnit
        }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fdcId = try container.decode(Int.self, forKey: .fdcId)
        self.description = try container.decode(String.self, forKey: .description)
        self.foodNutrients = try container.decode([FoodNutrient].self, forKey: .foodNutrients)
        self.foodPortions = try container.decodeIfPresent([FoodPortion].self, forKey: .foodPortions) ?? []
        self.brandName = try container.decodeIfPresent(String.self, forKey: .brandName)?.capitalized
        self.dataType = try container.decode(DataType.self, forKey: .dataType)
        self.servingSize = try container.decodeIfPresent(Float.self, forKey: .servingSize)
        self.servingSizeUnit = try container.decodeIfPresent(String.self, forKey: .servingSizeUnit)

        // Branded foods have additional info
        if dataType == .branded {
            self.description = description.capitalized
            if let servingSize {
                self.foodPortions.append(FoodPortion(gramWeight: servingSize, modifier: ""))
            }
        } else {
            brandName = "USDA"
        }
        // Implicit portion for all food
        self.foodPortions.append(FoodPortion(gramWeight: 100, modifier: ""))
        self.foodPortions.sort()
        
        // Filter out nutritents with 0 value
        self.foodNutrients = foodNutrients.filter { ($0.amount ?? 0.0) != 0 }
    }
    
    func getNutrient(_ id: NutrientID) -> FoodNutrient? {
        return foodNutrients.first { $0.nutrient?.id == id }
    }
    
    var calories: Int {
        return Int(getNutrient(.calories)?.amount ?? 0.0)
    }
}

extension Food {
    enum FoodEntryOptions: CaseIterable {
        case calories, servingSize, brandName
    }
    
    func getFoodEntryDescriptionFormatted(foodPortion: FoodPortion, numberOfServings: Int = 1, options: [FoodEntryOptions] = FoodEntryOptions.allCases) -> String {
        var descriptionParts: [String] = []

        if options.contains(.calories) {
            descriptionParts.append("\(Int(getNutrientPerServing(.calories, foodPortion: foodPortion) * Float(numberOfServings))) cal")
        }
        if options.contains(.servingSize) {
            descriptionParts.append(getServingSizeFormatted(foodPortion: foodPortion, numberOfServings: numberOfServings))
        }
        
        if let brandName, options.contains(.brandName) {
            descriptionParts.append("\(brandName)")
        }
        
        return descriptionParts.joined(separator: ", ")
    }
    
    func getServingSizeFormatted(foodPortion: FoodPortion, numberOfServings: Int = 1) -> String {
        if let amount = foodPortion.amount {
            let servings = Int(amount * Float(numberOfServings))
            let gramWeight = Int(foodPortion.gramWeight * Float(numberOfServings))
            return "\(servings) \(foodPortion.modifier) (\(gramWeight) \(servingSizeUnit ?? "g"))"
        } else {
            let gramWeight = Int(foodPortion.gramWeight * Float(numberOfServings))
            return "\(gramWeight) \(servingSizeUnit ?? "g")"
        }
    }
    
    func convertToCDFood(context: NSManagedObjectContext) -> CDFood {
        let food = CDFood(context: context)
        food.name = description
        food.brandName = brandName ?? "SR Legacy"
        food.dataType = dataType.rawValue
        food.fdcId = Int64(fdcId)
        food.foodNutrients = foodNutrients
        food.foodPortions = foodPortions
        food.servingSize = servingSize ?? 0.0
        food.servingSizeUnit = servingSizeUnit ?? "g"
        return food
    }
    
    func getNutrientPerServing(_ nutrientID: NutrientID, foodPortion: FoodPortion) -> Float {
        guard let nutrient = getNutrient(nutrientID),
              let nutrientPer100g = nutrient.amount else { return 0 }
        return (nutrientPer100g * foodPortion.gramWeight) / 100
    }
}

// TODO: this only works for grams (overload this to convert other units)
func calculateNutrientPerServing(nutrientPer100g: Float, servingSizeGramWeight: Float) -> Float {
    return (nutrientPer100g * servingSizeGramWeight) / 100
}

enum DataType: String, Codable, CaseIterable {
    case foundation = "Foundation"
    case srLegacy = "SR Legacy"
    case branded = "Branded"
}
