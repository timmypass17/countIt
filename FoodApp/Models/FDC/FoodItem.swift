//
//  Food.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/3/24.
//

import Foundation
import CoreData

// Foundation > Survey > Branded > SRLegacy
protocol FoodItem: Codable {
    var fdcId: Int { get }
    var description: String { get }
    var dataType: DataType { get }
    var selectedFoodPortion: FoodPortion { get set }
    var foodNutrients: [FoodNutrient] { get }
    var foodPortions: [FoodPortion] { get }
    var brandName: String? { get }
    var ingredients: [FoodItem] { get }
    
//    var foodInputs: [FDCFoodInput]    - not really possible with fdcapi
    func getFoodPortionDescription(foodPortion: FoodPortion, numberOfServings: Int, options: [FoodEntryOptions]) -> String
    func getServingSizeFormatted(foodPortion: FoodPortion, numberOfServings: Int) -> String
    func getNutrientAmountPerServing(_ nutrientID: NutrientId, foodPortion: FoodPortion) -> Double
    func getNutrientAmount(_ nutrientID: NutrientId, quantity: Int) -> Double
    func getFoodNutrient(_ id: NutrientId) -> FoodNutrient?
}

extension FoodItem {
    
    func getFoodNutrient(_ id: NutrientId) -> FoodNutrient? {
        return foodNutrients.first { $0.nutrient?.id == id }
    }
    
    func getNutrientAmountPerServing(_ nutrientID: NutrientId, foodPortion: FoodPortion) -> Double {
        guard let nutrient = getFoodNutrient(nutrientID),
              let nutrientPer100g = nutrient.amount else { return 0 }
        return (nutrientPer100g * Double(foodPortion.gramWeight ?? 0)) / 100
    }
    
    // TODO: Duplicate of foodEntry's getNutrientAmount
    // food (may contain ingredients)
    func getNutrientAmount(_ nutrientID: NutrientId, quantity: Int = 1) -> Double {
        let isCustom = fdcId < 0
        if isCustom {
            let currentAmount = (foodNutrients[nutrientID]?.amount ?? 0) * Double(quantity)
            var ingredientAmount = 0.0
            for ingredient in ingredients {
                ingredientAmount += ingredient.getNutrientAmount(nutrientID, quantity: quantity)
            }
            return currentAmount + ingredientAmount
        } else {
            guard let amountPer100g = foodNutrients[nutrientID]?.amount else { return 0 }
            return (amountPer100g / 100) * Double(selectedFoodPortion.gramWeight ?? 0) * Double(quantity)
        }
    }

    func getServingSizeFormatted(foodPortion: FoodPortion, numberOfServings: Int = 1) -> String {        
        if foodPortion.gramWeight == nil {
            guard let amount = foodPortion.amount,
                  let modifier = foodPortion.modifier else { return "" }
            
            let servings = Int(amount * Double(numberOfServings))
            return  "\(servings) \(modifier)"
        }
        
        if foodPortion.modifier == "Quick Add" {
            return "1 serving"
        }
        
        let gramWeight = Int(foodPortion.gramWeight ?? 0 * Double(numberOfServings))
        if let amount = foodPortion.amount,
           let modifier = foodPortion.modifier {
            let servings = Int(amount * Double(numberOfServings))
            return "\(servings) \(modifier) (\(gramWeight) g)"
        } else if let portionDescription = foodPortion.portionDescription {
            return "\(portionDescription) (\(gramWeight) g)"
        } else {
            return "\(gramWeight) g"
        }
    }
}

// For decoding array of different FoodItem
enum AnyFoodItem: FoodItem {
    case foundation(FoundationFoodItem)
    case branded(BrandedFoodItem)
    case survey(SurveyFoodItem)

    var fdcId: Int {
        switch self {
        case .foundation(let item): return item.fdcId
        case .branded(let item): return item.fdcId
        case .survey(let item): return item.fdcId
        }
    }

    var description: String {
        switch self {
        case .foundation(let item): return item.description
        case .branded(let item): return item.description
        case .survey(let item): return item.description
        }
    }
    
    var brandName: String? {
        switch self {
        case .foundation(let foundationFoodItem):
            return foundationFoodItem.brandName
        case .branded(let brandedFoodItem):
            return brandedFoodItem.brandName
        case .survey(let surveyFoodItem):
            return surveyFoodItem.brandName
        }
    }

    var dataType: DataType {
        switch self {
        case .foundation(let item): return item.dataType
        case .branded(let item): return item.dataType
        case .survey(let item): return item.dataType
        }
    }

    var foodNutrients: [FoodNutrient] {
        switch self {
        case .foundation(let item): return item.foodNutrients
        case .branded(let item): return item.foodNutrients
        case .survey(let item): return item.foodNutrients
        }
    }
    
    var selectedFoodPortion: FoodPortion {
        get {
            switch self {
            case .foundation(let item): return item.selectedFoodPortion
            case .branded(let item): return item.selectedFoodPortion
            case .survey(let item): return item.selectedFoodPortion
            }
        }
        set {
            self.setSelectedFoodPortion(newValue)
        }
    }

    mutating func setSelectedFoodPortion(_ portion: FoodPortion) {
        switch self {
        case .foundation(var item):
            item.selectedFoodPortion = portion
            self = .foundation(item)
        case .branded(var item):
            item.selectedFoodPortion = portion
            self = .branded(item)
        case .survey(var item):
            item.selectedFoodPortion = portion
            self = .survey(item)
        }
    }

    var foodPortions: [FoodPortion] {
        switch self {
        case .foundation(let item): return item.foodPortions
        case .branded(let item): return item.foodPortions
        case .survey(let item): return item.foodPortions
        }
    }
    
    var ingredients: [FoodItem] {
        switch self {
        case .foundation(let item): return item.ingredients
        case .branded(let item): return item.ingredients
        case .survey(let item): return item.ingredients
        }
    }
    
    func getFoodPortionDescription(foodPortion: FoodPortion, numberOfServings: Int, options: [FoodEntryOptions]) -> String {
        switch self {
        case .foundation(let item):
            return item.getFoodPortionDescription(foodPortion: foodPortion, numberOfServings: numberOfServings, options: options)
        case .branded(let item):
            return item.getFoodPortionDescription(foodPortion: foodPortion, numberOfServings: numberOfServings, options: options)
        case .survey(let item):
            return item.getFoodPortionDescription(foodPortion: foodPortion, numberOfServings: numberOfServings, options: options)
        }
    }
    
}

extension AnyFoodItem {
    private enum CodingKeys: String, CodingKey {
        case dataType
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataType = try container.decode(DataType.self, forKey: .dataType)

        let singleValueContainer = try decoder.singleValueContainer()

        switch dataType {
        case .foundation:
            let item = try singleValueContainer.decode(FoundationFoodItem.self)
            self = .foundation(item)
        case .branded:
            let item = try singleValueContainer.decode(BrandedFoodItem.self)
            self = .branded(item)
        case .survey:
            let item = try singleValueContainer.decode(SurveyFoodItem.self)
            self = .survey(item)
        }
    }

    func encode(to encoder: Encoder) throws {
        switch self {
        case .foundation(let item):
            try item.encode(to: encoder)
        case .branded(let item):
            try item.encode(to: encoder)
        case .survey(let item):
            try item.encode(to: encoder)
        }
    }
}

enum DataType: String, Codable, CaseIterable {
    case foundation = "Foundation"
    case branded = "Branded"
    case survey = "Survey (FNDDS)"
}
