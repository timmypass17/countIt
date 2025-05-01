//
//  FoodSearchResponse.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/2/24.
//

import Foundation


struct SearchResponse: Decodable {
    var foods: [FDCFood]
    
    enum CodingKeys: String, CodingKey {
        case foods
    }
}
