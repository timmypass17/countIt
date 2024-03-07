//
//  FoodPortion.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/6/24.
//

import Foundation

struct FoodPortion: Codable {
    var amount: Float?
    var gramWeight: Float
    var modifier: String    // "tbsp"
}
