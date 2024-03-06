//
//  Food.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/3/24.
//

import Foundation

struct Food: Codable {
    var foodNutrients: [FoodNutrient]
    var foodPortions: [FoodPortion]
    var servingSizeUnit: String?
    
    enum CodingKeys: String, CodingKey {
        case foodNutrients
        case foodPortions
        case servingSizeUnit
    }
    
    var calories: Int? {
        guard let nutrient = getFoodNutrient(of: "kcal"),
              let calories = nutrient.amount,
              let foodPortion = foodPortions.first
        else { return nil }
        
        let servingSize = foodPortion.gramWeight
        return Int((calories * servingSize)) / 100
    }
    
    func getFoodNutrient(of nutrient: String) -> FoodNutrient? {
        return foodNutrients.first { $0.nutrient.unitName == nutrient }
    }
    
    var averageFoodPortionSize: FoodPortion {
        let count = foodPortions.count
        if count % 2 == 0 {
            // No middle, choose left most
            return foodPortions[(count / 2) - 1]
        }
        return foodPortions[count / 2]
    }
    
    func getServingSizeFormatted(of foodPortion: FoodPortion) -> String? {
        if let servingSizeUnit, foodPortion.gramWeight == 100  {
            return "100 \(servingSizeUnit) [1]"
        }
        if let portionDescription = foodPortion.portionDescription {
            return "\(portionDescription) (\(Int(foodPortion.gramWeight)) g) [2]"
        }
        guard let amount = foodPortion.amount else { return "\(Int(foodPortion.gramWeight)) g [3]" }
        return "\(Int(amount)) \(foodPortion.modifier) (\(foodPortion.gramWeight) g) [4]" // TODO: always in grams?
    }
    
//    func getServingSizeFormatted(of foodPortion: FoodPortion) -> String? {
//        guard let amount = foodPortion.amount else { return "\(Int(foodPortion.gramWeight)) \(servingSizeUnit ?? "")" }
//        return "\(Int(amount)) \(foodPortion.modifier) (\(Int(foodPortion.gramWeight))  \(servingSizeUnit ?? ""))"
//    }
}

extension Food {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        foodNutrients = try values.decode([FoodNutrient].self, forKey: .foodNutrients)
        foodPortions = try values.decode([FoodPortion].self, forKey: .foodPortions)
        foodPortions.append(FoodPortion(portionDescription: nil, gramWeight: 100, modifier: "unspecified"))  // add implicit portion
        foodPortions.sort { $0.gramWeight < $1.gramWeight }
        servingSizeUnit = try values.decodeIfPresent(String.self, forKey: .servingSizeUnit)

    }
}

// MARK: - UI Methods

extension Food {
    func getCaloriesFormatted() -> String? {
        guard let calories else { return nil }
        return "\(calories) cal"
    }
}

struct FoodNutrient: Codable {
    var nutrient: Nutrient
    var amount: Float?   // per 100g
}

struct Nutrient: Codable {
    var name: String
    var unitName: String
}

struct FoodPortion: Codable, Hashable, Equatable {
    var portionDescription: String?
    var amount: Float?
    var gramWeight: Float
    var modifier: String
    
    func getServingSizeFormatted() -> String? {
        if gramWeight == 100 {
            return "100 g [5]"
        }
        if let portionDescription {
            return "\(portionDescription) (\(Int(gramWeight)) g) [6]"
        }
        guard let amount else { return "\(Int(gramWeight)) g [7]" }
        return "\(Int(amount)) \(modifier) (\(gramWeight) g) [8]" // TODO: always in grams?
    }
        
    func hash(into hasher: inout Hasher) {
        hasher.combine(gramWeight)
    }
    
    static func == (lhs: FoodPortion, rhs: FoodPortion) -> Bool {
        return lhs.gramWeight == rhs.gramWeight
    }
}
