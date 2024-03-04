//
//  FoodService.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/2/24.
//

import Foundation

class FoodService {
    func getFoodSearchResults(query: String) async throws -> [FoodSearchResults] {
        let request = SearchAPIRequest(query: query)
        let searchResult = try await sendRequest(request)
        return searchResult.foods
    }
    
    func getFood(id: Int) async throws -> Food {
        let request = FoodAPIRequest(id: id)
        let food = try await sendRequest(request)
        return food
    }
}
