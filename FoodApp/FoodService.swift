//
//  FoodService.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/2/24.
//

import Foundation

class FoodService {
    func getFoodIDs(query: String) async throws -> [Int] {
        let request = AbridgedSearchAPIRequest(query: query)
        let searchResult = try await sendRequest(request)
        return searchResult.foods.map { $0.fdcId }
    }
    
    func getFoodSearchResults(query: String) async throws -> [SearchResultFood] {
        let request = SearchAPIRequest(query: query)
        let searchResult = try await sendRequest(request)
        return searchResult.foods
    }
    
    func getFoods(ids: [Int]) async throws -> [SearchResultFood] {
        let request = FoodListAPIRequest(foodIDs: ids)
        let searchResult = try await sendRequest(request)
        return searchResult
    }
    
//    func getFood(id: Int) async throws -> Food {
//        let request = FoodAPIRequest(id: id)
//        let food = try await sendRequest(request)
//        return food
//    }
}
