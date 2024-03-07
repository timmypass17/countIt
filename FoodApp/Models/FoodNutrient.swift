//
//  FoodNutrient.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/6/24.
//

import Foundation

struct FoodNutrient: Codable {
    let nutrient: Nutrient
    let amount: Float?   // 590
}

struct Nutrient: Codable {
    let name: String        // Energy
    let unitName: String    // kcal
}
