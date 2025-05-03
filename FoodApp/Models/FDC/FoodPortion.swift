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
    var modifier: String    // "tbsp" "10205"
    var sequenceNumber: Int // survey
    var portionDescription: String // survey "1 cup"
    var measureUnit: MeasureUnit
    
    init(amount: Float? = nil, gramWeight: Float, modifier: String, sequenceNumber: Int, portionDescription: String, measureUnit: MeasureUnit) {
        self.amount = amount
        self.gramWeight = gramWeight
        self.modifier = modifier
        self.sequenceNumber = sequenceNumber
        self.portionDescription = portionDescription
        self.measureUnit = measureUnit
    }
}

struct MeasureUnit: Codable, Equatable {
    let id: Int
    let name: String
    let abbreviation: String
}

extension FoodPortion {
//    func getServingSizeFormatted() -> String {
//        if let amount = amount {
//            return "\(Int(amount)) \(modifier) (\(Int(gramWeight)) g)"
//        } else {
//            return "\(Int(gramWeight)) g"
//        }
//    }
}

extension FoodPortion: Comparable {
    public static func < (lhs: FoodPortion, rhs: FoodPortion) -> Bool {
        return lhs.gramWeight < rhs.gramWeight
    }
    
}

//extension FoodPortion: Equatable {
//    static func == (lhs: FoodPortion, rhs: FoodPortion) -> Bool {
//        return lhs.amount == rhs.amount &&
//        lhs.gramWeight == rhs.gramWeight &&
//        lhs.modifier == rhs.modifier
//    }
//}
