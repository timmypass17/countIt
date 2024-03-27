//
//  FoodService.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/2/24.
//

import Foundation
import UIKit
import CoreData

class FoodService {
    func getFoods(query: String) async throws -> [Food] {
        let abridgedRequest = AbridgedSearchAPIRequest(query: query)
        let abridgedSearchResult = try await sendRequest(abridgedRequest)
        let foodIds = abridgedSearchResult.foods.map { $0.fdcId }
        
        let request = FoodListAPIRequest(foodIDs: foodIds)
        let searchResult = try await sendRequest(request)
        return searchResult
    }
}
