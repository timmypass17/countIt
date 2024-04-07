//
//  AbridgedSearchResponse.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/7/24.
//

import Foundation

struct AbridgedSearchResponse: Decodable {
    var foods: [AbridgedSearchResultFood]
    
    enum CodingKeys: String, CodingKey {
        case foods
    }
}

struct AbridgedSearchResultFood: Codable {
    var fdcId: Int
    var description: String
}
