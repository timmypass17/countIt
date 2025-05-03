//
//  Food.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/3/24.
//

import Foundation
import CoreData

protocol FoodItem: Codable {
    var fdcId: Int { get }
    var description: String { get }
    var dataType: DataType { get }
    var foodNutrients: [FoodNutrient] { get }
    var foodPortions: [FoodPortion] { get }
//    var foodInputs
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
        case .survey(let item): return []
        }
    }

    var foodPortions: [FoodPortion] {
        switch self {
        case .foundation(let item): return item.foodPortions
        case .branded(let item): return item.foodPortions
        case .survey(let item): return item.foodPortions
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
//    case srLegacy = "SR Legacy"
    case branded = "Branded"
    case survey = "Survey (FNDDS)"
}
