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
    func getFoods(query: String, dataTypes: [DataType]) async throws -> [FDCFood]
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
    
    func getFoods(query: String, dataTypes: [DataType]) async throws -> [FDCFood] {
        let abridgedRequest = AbridgedSearchAPIRequest(query: query, dataTypes: dataTypes)
        let abridgedSearchResult = try await sendRequest(abridgedRequest)
        let foodIds = abridgedSearchResult.foods.map { $0.fdcId }

        print("timmy middl")
        let request = FoodListAPIRequest(foodIDs: foodIds)
        let searchResult = try await sendRequest(request)
        return searchResult
    }
}
