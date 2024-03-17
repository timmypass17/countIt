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
    func getFoodIDs(query: String) async throws -> [Int] {
        let request = AbridgedSearchAPIRequest(query: query)
        let searchResult = try await sendRequest(request)
        return searchResult.foods.map { $0.fdcId }
    }

    func getFoods(ids: [Int]) async throws -> [Food] {
        let request = FoodListAPIRequest(foodIDs: ids)
        let searchResult = try await sendRequest(request)
        return searchResult
    }
}
