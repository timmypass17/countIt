//
//  FoodService.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/2/24.
//

import Foundation
import UIKit
import CoreData

protocol FoodServiceProtocol {
    func getFoods(query: String, dataTypes: [DataType]) async throws -> [FoodItem]
    func getFoods(fdcIds: [Int], dataTypes: [DataType]) async throws -> [FoodItem]
    func createEmptyMealPlan() -> MealPlan
}

class FoodService: FoodServiceProtocol {
    
    let context = CoreDataStack.shared.context
    
    func createEmptyMealPlan() -> MealPlan {
        let mealPlan = MealPlan(context: context)
        mealPlan.date = .now
        
        let meal = Meal(context: context)
        meal.index = 0
        meal.name = "Breakfast"
        meal.mealPlan_ = mealPlan
        mealPlan.addToMeals_(meal)
        
        return mealPlan
    }
    
    func getFoods(query: String, dataTypes: [DataType]) async throws -> [FoodItem] {
        let abridgedRequest = AbridgedSearchAPIRequest(query: query, dataTypes: dataTypes)
        let abridgedSearchResult = try await sendRequest(abridgedRequest)
        let fdcIds = abridgedSearchResult.foods.map { $0.fdcId }

        return try await getFoods(fdcIds: fdcIds, dataTypes: dataTypes)
    }
    
    func getFoods(fdcIds: [Int], dataTypes: [DataType]) async throws -> [FoodItem] {
        let request = FoodListAPIRequest(fdcIds: fdcIds)
        let searchResult = try await sendRequest(request)
        return searchResult
    }
    
}
