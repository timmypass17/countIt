//
//  FoodPortion.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/6/24.
//

import Foundation

// modifer and portionDescription are similar, found in different (foundation, survey)
// branded dont have foodportion array? Use explicitt
struct FoodPortion: Codable {
    var id: Int
    var gramWeight: Double?
    var amount: Double? // part of modifier, foundation 1.00 -> used like 1.00 and "banana" (modifier). amount + modifier
    var modifier: String?    // foundation "tbsp"
    var portionDescription: String? = nil // survey "1 tbsp". never use this, just extract into amount and modifier
    
    init(id: Int, amount: Double? = nil, gramWeight: Double?, modifier: String? = nil) {
        self.id = id
        self.amount = amount
        self.gramWeight = gramWeight
        self.modifier = modifier
    }
    
    enum CodingKeys: CodingKey {
        case id
        case amount
        case gramWeight
        case modifier
        case portionDescription
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.amount = try container.decodeIfPresent(Double.self, forKey: .amount)
        self.gramWeight = try container.decode(Double.self, forKey: .gramWeight)
        self.modifier = try container.decodeIfPresent(String.self, forKey: .modifier)?.lowercased()
        let portionDescription = try container.decodeIfPresent(String.self, forKey: .portionDescription)
        
        // extract "banana" from "1 banana"
        // TODO: Use foodPortion.csv to get modifier instead of extracting
        if let portionDescription {
            let parts = extractQuantityAndModifier(from: portionDescription)
            if let quantity = parts?.0,
               let modifier = parts?.1 {
                self.amount = quantity
                self.modifier = modifier
            }
        }
        
        
//        if let portionDescription, portionDescription != "Quantity not specified" {
//            self.portionDescription = portionDescription.lowercased()
//        }
    }
}



extension FoodPortion {
    static let default100g = FoodPortion(id: 0, gramWeight: 100)
}

struct MeasureUnit: Codable, Equatable {
    let id: Int
    let name: String
    let abbreviation: String
}

extension FoodPortion: Comparable {
    public static func < (lhs: FoodPortion, rhs: FoodPortion) -> Bool {
        return lhs.gramWeight ?? 0 < rhs.gramWeight ?? 0
    }
    
}

//extension FoodPortion: Equatable {
//    static func == (lhs: FoodPortion, rhs: FoodPortion) -> Bool {
//        return lhs.amount == rhs.amount &&
//        lhs.gramWeight == rhs.gramWeight &&
//        lhs.modifier == rhs.modifier
//    }
//}

// TODO: Food portions (Want 3 things, gramWeight (110), amount (1), modifier("peeled"))
// foundation
//"foodPortions": [
//    {
//        "id": 267488,
//        "dataPoints": 50,
//        "gramWeight": 110.00000000 <- GOOD
//        "sequenceNumber": 1,
//        "amount": 1.00000000, <- GOOD
//        "modifier": "Peeled", <- GOOD
//        "minDateAcquired": "12/2/2019",
//        "measureUnit": {
//            "id": 1119,
//            "name": "Banana",
//            "abbreviation": "Banana"
//        },
//        "minYearAcquired": 2019
//    }
//],

// sr legacy
//"foodPortions": [
//    {
//        "id": 93520,
//        "gramWeight": 6.20000000, <- GOOD
//        "sequenceNumber": 2,
//        "amount": 1.00000000, <- GOOD
//        "modifier": "tbsp", <- GOOD
//        "measureUnit": {
//            "id": 9999,
//            "name": "undetermined",
//            "abbreviation": "undetermined"
//        }
//    },

// branded, no foodPortions (skippy pb)
// JUST USE GRAMS (e.g. 32 g). no reliable way to extract "2 Tbsp"
//         "householdServingFullText": "2 Tbsp", <- OKAY? Can extract AMOUNT and MODIFIER
//         "servingSize": 32.00000000, <- GOOD
//         "servingSizeUnit": "g", <- Maybe? Is it all in grams? could be "ml"
// if common format like "2 Tbsp", can extract (2 words)
// 2 <- amount
// modifier <- tbsp

// If strange format
// "1 bar (45g)"
// nil <- amount
// modifier <- "1 bar (45g)"
// Display to user "2x 1 bar (45g)"

// survey (Ignore survey, not worth headache)
//"foodPortions": [
//    {
//        "id": 306103,
//        "measureUnit": {
//            "id": 9999,
//            "name": "undetermined",
//            "abbreviation": "undetermined"
//        },
//        "modifier": "10118",
//        "gramWeight": 225, <- GOOD
//        "portionDescription": "1 cup, mashed", <- BAD
//        "sequenceNumber": 4
//    },
