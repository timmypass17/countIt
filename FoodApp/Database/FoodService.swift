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
//    func getMealPlan(date: Date) -> MealPlan
    func getFoods(query: String, dataTypes: [DataType], pageSize: Int, pageNumber: Int) async throws -> FoodSearchResponse
    func getFoods(fdcIds: [Int], dataTypes: [DataType]) async throws -> [FoodItem]
    func getFood(fdcId: Int) async throws -> FoodItem
    func createEmptyMealPlan(date: Date) throws -> MealPlan
}

class FoodService: FoodServiceProtocol {
    
    let context = CoreDataStack.shared.context
    
    enum FoodError: Error {
        case missingUserId
    }
    
    func createUserProfile(_ userProfile: UserProfile) {
        do {
            try userProfile.managedObjectContext?.save()
            print("✅ User profile saved")
        } catch {
            print("❌ Failed to save user profile: \(error.localizedDescription)")
        }
    }
    
    func signOut()  {
        KeychainItem.deleteUserIdentifierFromKeychain()
    }
    
    func deleteAccount() throws {
        guard let userId = KeychainItem.currentUserIdentifier else { throw FoodError.missingUserId }
        deleteUserProfile(userId: userId)
        KeychainItem.deleteUserIdentifierFromKeychain()
    }
    
    func deleteUserProfile(userId: String) {
        if let userProfile = getUserProfile(id: userId) {
            context.delete(userProfile)
            do {
                try context.save()
                print("✅ Successfully deleted UserProfile with id \(userId)")
            } catch {
                print("❌ Failed to delete UserProfile with id \(userId): \(error)")
            }
        } else {
            print("❌ UserProfile with id \(userId) not found.")
        }
    }

    func getUserProfile(id: String) -> UserProfile? {
        let fetchRequest: NSFetchRequest<UserProfile> = UserProfile.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.fetchLimit = 1
        
        do {
            let results = try context.fetch(fetchRequest)
            if let userProfile = results.first {
                print("✅ Successfully got UserProfile\n\(userProfile)")
                return userProfile
            }
            return nil
        } catch {
            print("❌ Failed to fetch UserProfile with id \(id): \(error)")
            return nil
        }
    }
    
    func getMealPlan(date: Date) -> MealPlan? {
        let date = Calendar.current.startOfDay(for: date)
        let request: NSFetchRequest<MealPlan> = MealPlan.fetchRequest()
        request.predicate = NSPredicate(format: "date_ == %@", date as NSDate)
        request.fetchLimit = 1

        do {
            let mealPlans = try context.fetch(request)
            if let mealPlan = mealPlans.first {
                print("✅ Fetched existing meal plan for (\(Date.now.formatted()))")
                return mealPlan
            }
            print("❌ Failed to get meal plan for (\(Date.now.formatted()))")
            return nil
        } catch {
            print("❌ Failed to get meal plan for (\(Date.now.formatted())): \(error)")
            return nil
        }
    }
    
    func createEmptyMealPlan(date: Date) throws -> MealPlan {
        guard let userId = KeychainItem.currentUserIdentifier,
              let userProfile = getUserProfile(id: userId)
        else { throw FoodError.missingUserId }
        
        let mealPlan = MealPlan(context: context)
        mealPlan.date = date

        let mealNames = ["Breakfast", "Lunch", "Dinner", "Snack"]

        for (index, name) in mealNames.enumerated() {
            let meal = Meal(context: context)
            meal.index = Int16(index)
            meal.name = name
            meal.mealPlan_ = mealPlan
            mealPlan.addToMeals_(meal)
        }
        
        // Take a snapshot of current users goal and apply it to this meal plan
        let calorieGoal = NutrientGoal(context: context)
        calorieGoal.nutrientId = .calories
        calorieGoal.value = Double(userProfile.dailyCalories ?? 0)
        calorieGoal.mealPlan = mealPlan
        mealPlan.addToNutrientGoals_(calorieGoal)
        
        let carbsGoal = NutrientGoal(context: context)
        carbsGoal.nutrientId = .carbs
        carbsGoal.value = Double(userProfile.carbsGrams ?? 0)
        carbsGoal.mealPlan = mealPlan
        mealPlan.addToNutrientGoals_(carbsGoal)
        
        let proteinGoal = NutrientGoal(context: context)
        proteinGoal.nutrientId = .protein
        proteinGoal.value = Double(userProfile.proteinGrams ?? 0)
        proteinGoal.mealPlan = mealPlan
        mealPlan.addToNutrientGoals_(proteinGoal)
        
        let fatsGoal = NutrientGoal(context: context)
        fatsGoal.nutrientId = .fatTotal
        fatsGoal.value = Double(userProfile.fatsGrams ?? 0)
        fatsGoal.mealPlan = mealPlan
        mealPlan.addToNutrientGoals_(fatsGoal)

        print("✅ Created empty meal plan for today (\(Date.now.formatted()))")
        return mealPlan
    }
    
    func getFoods(query: String, dataTypes: [DataType], pageSize: Int, pageNumber: Int) async throws -> FoodSearchResponse {
        let abridgedRequest = FoodsSearchAPIRequest(query: query, dataTypes: dataTypes, pageSize: pageSize, pageNumber: pageNumber)
        let searchResultResponse = try await sendRequest(abridgedRequest)
        return searchResultResponse
    }
    
//    func getFoods(query: String, dataTypes: [DataType]) async throws -> [FoodItem] {
//        let abridgedRequest = FoodsSearchAPIRequest(query: query, dataTypes: dataTypes)
//        let abridgedSearchResult = try await sendRequest(abridgedRequest)
//        let fdcIds = abridgedSearchResult.foods.map { $0.fdcId }
//
//        return try await getFoods(fdcIds: fdcIds, dataTypes: dataTypes)
//    }
    
    func getFoods(fdcIds: [Int], dataTypes: [DataType]) async throws -> [FoodItem] {
        let request = FoodListAPIRequest(fdcIds: fdcIds)
        let searchResult = try await sendRequest(request)
        return searchResult
    }
    
    func getFood(fdcId: Int) async throws -> any FoodItem {
        let request = FoodAPIRequest(fdcId: fdcId)
        let searchResult = try await sendRequest(request)
        return searchResult
    }
}
