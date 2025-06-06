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
        case missingUserProfile
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
        deleteUserProfile()
        // Delete rest of user stuff? Maybe cascade deletion rule is enough
    }
    
    func deleteUserProfile() {
        if let userProfile = getUserProfile() {
            context.delete(userProfile)
            do {
                try context.save()
                print("✅ Successfully deleted UserProfile")
            } catch {
                print("❌ Failed to delete UserProfile: \(error)")
            }
        } else {
            print("❌ UserProfile with  not found.")
        }
    }

    func getUserProfile() -> UserProfile? {
        let fetchRequest: NSFetchRequest<UserProfile> = UserProfile.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        do {
            let results = try context.fetch(fetchRequest)
            if let userProfile = results.first {
                print("✅ Successfully got UserProfile\n\(userProfile)")
                return userProfile
            }
            print("❌ Failed to find any UserProfile")
            return nil
        } catch {
            print("❌ Failed to fetch UserProfile: \(error)")
            return nil
        }
    }
    
    func getMealPlan(date: Date) -> MealPlan? {
        let dateKey = formatDateAsDateKey(date)
        let request: NSFetchRequest<MealPlan> = MealPlan.fetchRequest()
        request.predicate = NSPredicate(format: "dateKey_ == %@", dateKey)
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
        guard let userProfile = getUserProfile() else { throw FoodError.missingUserProfile }
        
        let mealPlan = MealPlan(context: context)
        mealPlan.date = date
        mealPlan.dateKey = formatDateAsDateKey(date)

        let mealNames = ["Breakfast", "Lunch", "Dinner", "Snack"]

        for (index, name) in mealNames.enumerated() {
            let meal = Meal(context: context)
            meal.index = Int16(index)
            meal.name = name
            meal.mealPlan = mealPlan
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

        try context.save()
        print("✅ Created empty meal plan for today (\(Date.now.formatted()))")
        return mealPlan
    }
    
    func addFood(_ fdcFood: FoodItem, with portion: FoodPortion, quantity: Int, to meal: Meal) throws -> Food {
        let food = Food(context: context)
        food.index = Int16(meal.foods.count)
        food.quantity = Int16(quantity)
        food.gramWeight = Double(portion.gramWeight)
        food.portionId = Int32(portion.id)

        if let amount = portion.amount,
           let modifier = portion.modifier {
            food.amount = Double(amount)
            food.modifier = modifier
        } else if let portionDescription = portion.portionDescription {
            // extract "banana" from "1 banana"
            // TODO: Use foodPortion.csv to get modifier instead of extracting
            let parts = extractQuantityAndModifier(from: portionDescription)
            if let quantity = parts?.0,
               let modifier = parts?.1 {
                food.amount = quantity
                food.modifier = modifier
            }
        }
        
        meal.addToFoods_(food)
        
        if let foodInfo = getFoodInfo(fdcId: fdcFood.fdcId) {
            food.foodInfo = foodInfo
        } else {
            let foodInfo = createFoodInfo(fdcFood)
            food.foodInfo = foodInfo
            
            // Add nutrients relationship to foodInfo
            for nutrientId in NutrientId.allCases {
                let foodInfoNutrient = createFoodInfoNutrients(fdcFood, nutrientId: nutrientId)
                foodInfo.addToNutrients_(foodInfoNutrient)
            }
            
            // Add portion relationship
            for (index, fdcPortion) in fdcFood.foodPortions.enumerated() {
                let portion = createFoodInfoPortion(fdcPortion)
                foodInfo.addToPortions_(portion)
            }
        }
        
        updateFoodHistoryIfNeeded(food: food)
        
        try context.save()
        
        return food
    }
    
    func getFoodHistory(fdcId: Int) -> History? {
        let request: NSFetchRequest<History> = History.fetchRequest()
        request.predicate = NSPredicate(format: "fdcId == %d", fdcId)
        request.fetchLimit = 1

        do {
            let res = try context.fetch(request).first
            return res
        } catch {
            print("Error checking existence: \(error)")
            return nil
        }
    }
    
    func updateFoodHistoryIfNeeded(food: Food) {
        guard let fdcId = food.foodInfo?.fdcId else { return }

        if let history = getFoodHistory(fdcId: Int(fdcId)) {
            updateHistory(history)
        } else {
            let history = History(context: context)
            history.fdcId = fdcId
            history.createdAt_ = .now
            history.food = food
        }
    }
    
    func updateHistory(_ history: History) {
        history.createdAt_ = .now
    }

    
    func updateFood(_ food: Food, foodPortion: FoodPortion, quantity: Int) throws -> Food {
        food.quantity = Int16(quantity)
        food.amount = foodPortion.amount
        food.gramWeight = foodPortion.gramWeight
        food.modifier = foodPortion.modifier
        food.portionId = Int32(foodPortion.id)  // 100g - 0, custom - 1
        try context.save()
        
        return food
    }
    
    func deleteFood(_ food: Food) throws {
        context.delete(food)

        try context.save()
    }
    
    func createFoodInfo(_ fdcFood: FoodItem) -> FoodInfo {
        let foodInfo = FoodInfo(context: context)
        foodInfo.fdcId = Int64(fdcFood.fdcId)
        foodInfo.name = fdcFood.description
        foodInfo.brandName_ = fdcFood.brandName
        return foodInfo
    }
    
    func createFoodInfoNutrients(_ fdcFood: FoodItem, nutrientId: NutrientId) -> FoodInfoNutrient {
        let foodInfoNutrient = FoodInfoNutrient(context: context)
        foodInfoNutrient.nutrientId = nutrientId
        foodInfoNutrient.value = Double(fdcFood.foodNutrients[nutrientId]?.amount ?? 0)
        
        return foodInfoNutrient
    }
    
    func createFoodInfoPortion(_ foodPortion: FoodPortion) -> FoodInfoPortion {
        let foodInfoPortion = FoodInfoPortion(context: context)
        foodInfoPortion.id = Int32(foodPortion.id)
        foodInfoPortion.gramWeight = Double(foodPortion.gramWeight)
        if let amount = foodPortion.amount,
           let modifier = foodPortion.modifier {
            foodInfoPortion.amount = Double(amount)
            foodInfoPortion.modifier = modifier
        } else if let portionDescription = foodPortion.portionDescription {
            // extract "banana" from "1 banana"
            let parts = extractQuantityAndModifier(from: portionDescription)
            if let quantity = parts?.0,
               let modifier = parts?.1 {
                foodInfoPortion.amount = quantity
                foodInfoPortion.modifier = modifier
            }
        }
        return foodInfoPortion
    }
    
    func extractQuantityAndModifier(from string: String) -> (Double, String)? {
        let components: [Substring] = string.split(separator: " ")
        guard let quantityString = components.first,
              let quantity = Double(quantityString),
              components.count > 1
        else {
            return nil
        }
        let modifier = String(components[1])
        
        return (quantity, modifier)
    }
    
    func getFoodInfo(fdcId: Int) -> FoodInfo? {
        let fetchRequest: NSFetchRequest<FoodInfo> = FoodInfo.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "fdcId == %d", fdcId)

        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print("Failed to fetch FoodInfo with fdcId \(fdcId):", error)
            return nil
        }
    }
    
    func getFoods(query: String, dataTypes: [DataType], pageSize: Int, pageNumber: Int) async throws -> FoodSearchResponse {
        let abridgedRequest = FoodsSearchAPIRequest(query: query, dataTypes: dataTypes, pageSize: pageSize, pageNumber: pageNumber)
        print("timmy 1")
        var searchResultResponse = try await sendRequest(abridgedRequest)
        print("timmy 2")
        let fdcIds = searchResultResponse.foodParts.map { $0.fdcId }
        // TODO: Don't use multiple fdcIds at once, is slow. Make multiple tasks for each item, fetch concurrently
        let foods: [FoodItem] = try await getFoods(fdcIds: fdcIds, dataTypes: DataType.allCases)
        print("timmy 3")
        searchResultResponse.foods.append(contentsOf: foods)
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
        print("timmy: \(fdcIds)")
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
