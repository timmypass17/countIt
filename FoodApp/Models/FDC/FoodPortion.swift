//
//  FoodPortion.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/6/24.
//

import Foundation

// modifer and portionDescription are similar, found in different
struct FoodPortion: Codable {
    var id: Int
    var amount: Float?
    var gramWeight: Float
    var modifier: String?    // foundation "tbsp"
    var portionDescription: String? // survey "1 tbsp"
    var sequenceNumber: Int // survey
    var measureUnit: MeasureUnit
    
    init(id: Int, amount: Float? = nil, gramWeight: Float, modifier: String? = nil, sequenceNumber: Int, portionDescription: String? = nil, measureUnit: MeasureUnit) {
        self.id = id
        self.amount = amount
        self.gramWeight = gramWeight
        self.modifier = modifier
        self.sequenceNumber = sequenceNumber
        self.portionDescription = portionDescription
        self.measureUnit = measureUnit
    }
    
    enum CodingKeys: CodingKey {
        case id
        case amount
        case gramWeight
        case modifier
        case sequenceNumber
        case portionDescription
        case measureUnit
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.amount = try container.decodeIfPresent(Float.self, forKey: .amount)
        self.gramWeight = try container.decode(Float.self, forKey: .gramWeight)
        self.modifier = try container.decodeIfPresent(String.self, forKey: .modifier)?.lowercased()
        self.sequenceNumber = try container.decode(Int.self, forKey: .sequenceNumber)
        let portionDescription = try container.decodeIfPresent(String.self, forKey: .portionDescription)
        if let portionDescription, portionDescription != "Quantity not specified" {
            self.portionDescription = portionDescription.lowercased()
        }
        self.measureUnit = try container.decode(MeasureUnit.self, forKey: .measureUnit)
    }
}

extension FoodPortion {
    static let default100g = FoodPortion(id: 0, gramWeight: 100, sequenceNumber: 0, measureUnit:  MeasureUnit(id: 0, name: "", abbreviation: ""))
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

