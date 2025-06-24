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
//    func createEmptyMealPlan(date: Date) throws -> MealPlan
}

class FoodService: FoodServiceProtocol {
    
    let context = CoreDataStack.shared.context
    
    enum FoodError: Error {
        case missingUserProfile
    }
    
    func createUserProfile(_ userProfile: UserProfile) throws {
        guard let dailyCalories = userProfile.dailyCalories,
              let dailyCarbs = userProfile.carbsGrams,
              let dailyProtein = userProfile.proteinGrams,
              let dailyFat = userProfile.fatsGrams
        else { return }
        // set defaults
        let calorieGoal = createUserNutrientGoal(.calories, value: Double(dailyCalories))
        let carbsGoal = createUserNutrientGoal(.carbs, value: Double(dailyCarbs))
        let proteinGoal = createUserNutrientGoal(.protein, value: Double(dailyProtein))
        let fatGoal = createUserNutrientGoal(.fatTotal, value: Double(dailyFat))
        
        // macros
        let fatMono = createUserNutrientGoal(.fatMono, value: 20)
        let fatPoly = createUserNutrientGoal(.fatPoly, value: 8)
        let fatSaturated = createUserNutrientGoal(.fatSaturated, value: 20)
        let cholestrol = createUserNutrientGoal(.cholesterol, value: 300)
        let sodium = createUserNutrientGoal(.sodium, value: 2300)
        let fiber = createUserNutrientGoal(.fiber, value: 28)
        let sugarTotal = createUserNutrientGoal(.sugarTotal, value: 50)
        let sugarAdded = createUserNutrientGoal(.sugarAdded, value: 30)
        
        // vitamins
        let vitaminA = createUserNutrientGoal(.vitaminA, value: 3000)
        let vitaminB1 = createUserNutrientGoal(.vitaminB1, value: 1.2)
        let vitaminB2 = createUserNutrientGoal(.vitaminB2, value: 1.3)
        let vitaminB3 = createUserNutrientGoal(.vitaminB3, value: 16)
        let vitaminB6 = createUserNutrientGoal(.vitaminB6, value: 1.7)
        let vitaminB7 = createUserNutrientGoal(.vitaminB7, value: 30)
        let vitaminB12 = createUserNutrientGoal(.vitaminB12, value: 2.4)
        let vitaminC = createUserNutrientGoal(.vitaminC, value: 90)
        let vitaminD = createUserNutrientGoal(.vitaminD, value: 20)
        let vitaminE = createUserNutrientGoal(.vitaminE, value: 15)
        let vitaminK = createUserNutrientGoal(.vitaminK, value: 120)
        let folate = createUserNutrientGoal(.folate, value: 400)
        
        // minerals
        let calcium = createUserNutrientGoal(.calcium, value: 1300)
        let iron = createUserNutrientGoal(.iron, value: 18)
        let magnesium = createUserNutrientGoal(.magnesium, value: 420)
        let phosphorus = createUserNutrientGoal(.phosphorus, value: 1250)
        let potassium = createUserNutrientGoal(.potassium, value: 4700)
        let zinc = createUserNutrientGoal(.zinc, value: 11)
        let copper = createUserNutrientGoal(.copper, value: 0.9)
        let iodine = createUserNutrientGoal(.iodine, value: 150)
        let manganese = createUserNutrientGoal(.manganese, value: 2.3)
        let selenium = createUserNutrientGoal(.selenium, value: 55)
        
        // other
        let water = createUserNutrientGoal(.water, value: 3700)
        let caffeine = createUserNutrientGoal(.caffeine, value: 400)
        
        let allGoals = [
            calorieGoal, carbsGoal, proteinGoal, fatGoal,
            fatMono, fatPoly, fatSaturated, cholestrol, sodium, fiber, sugarTotal, sugarAdded,
            vitaminA, vitaminB1, vitaminB2, vitaminB3, vitaminB6, vitaminB7, vitaminB12,
            vitaminC, vitaminD, vitaminE, vitaminK, folate,
            calcium, iron, magnesium, phosphorus, potassium,
            zinc, copper, iodine, manganese, selenium,
            water, caffeine
        ]
        
        allGoals.forEach { $0.userProfile = userProfile }
        
        try context.save()
        print("✅ User profile saved")
    }
    
    func getStartingUserWeight() -> UserWeight? {
        let request: NSFetchRequest<UserWeight> = UserWeight.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(UserWeight.date_), ascending: true)]
        request.fetchLimit = 1
        
        do {
            let startingWeight = try context.fetch(request).first
            return startingWeight
        } catch {
            return nil
        }
    }
    
    func getCurrentUserWeight() -> UserWeight? {
        let request: NSFetchRequest<UserWeight> = UserWeight.fetchRequest()
        request.predicate = NSPredicate(format: "%K <= %@", #keyPath(UserWeight.date_), Date() as NSDate)
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(UserWeight.date_), ascending: false)]
        request.fetchLimit = 1
        
        do {
            let currentWeight = try context.fetch(request).first
            return currentWeight
        } catch {
            return nil
        }
    }
    
    func createUserWeight(weightInKg: Double, date: Date) throws {
        let userWeight = UserWeight(context: context)
        userWeight.date_ = date
        userWeight.weightInKg = weightInKg
        try context.save()
    }
    
    func createUserNutrientGoal(_ nutrientId: NutrientId, value: Double) -> UserNutrientGoal {
        let userNutrientGoal = UserNutrientGoal(context: context)
        userNutrientGoal.nutrientId = nutrientId
        userNutrientGoal.value = value
        return userNutrientGoal
    }
    
    func signOut()  {
        KeychainItem.deleteUserIdentifierFromKeychain()
    }
    
    // NSBatchDeleteRequest - deletes items efficiently without having to fetch them.
    // note: Ignore's deletion rules
    // https://www.avanderlee.com/swift/nsbatchdeleterequest-core-data/
    func deleteAccount() throws {
        for entityName in CoreDataStack.shared.persistentContainer.managedObjectModel.entities.map({ $0.name! }) {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeObjectIDs
            
            let result = try context.execute(batchDeleteRequest) as? NSBatchDeleteResult
            if let objectIDs = result?.result as? [NSManagedObjectID] {
                let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: objectIDs]
                // need to notifiy cloudkit about deletion
                // "Hey, these object IDs were deleted—clean up your in-memory state, and notify CloudKit too."
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
            }
        }

        try context.save()
    }
    
//    func deleteUserProfile() {
//        if let userProfile = getUserProfile() {
//            context.delete(userProfile)
//            do {
//                try context.save()
//                print("✅ Successfully deleted UserProfile")
//            } catch {
//                print("❌ Failed to delete UserProfile: \(error)")
//            }
//        } else {
//            print("❌ UserProfile with  not found.")
//        }
//    }

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
                print("timmy found meal plan for (\(date.formatted()))")
                return mealPlan
            }
            print("timmy did not find any meal plan for (\(date.formatted()))")
            return nil
        } catch {
            print("timmy failed to get meal plan for (\(date.formatted())): \(error)")
            return nil
        }
    }
    
    // Copies meals/foods from one mealplan into another
    func copyMeals(from source: MealPlan, to destination: MealPlan) throws -> MealPlan {
        // Delete other meal plan's meals and foods
        for meal in destination.meals {
            context.delete(meal)
        }
        
        let meals = source.meals
        print("timmy source: \(source.date.formatted(date: .abbreviated, time: .omitted))")
        for meal in meals {
            print("timmy food count: \(meal.foodEntries.count)")
        }

        for meal in source.meals {
            // Copy meals
            let mealCopy = Meal(context: context)
            mealCopy.name = meal.name
            mealCopy.index = meal.index
            mealCopy.mealPlan = destination
            for food in meal.foodEntries {
                // Copy foods
                let foodCopy = FoodEntry(context: context)
                foodCopy.index = food.index
                foodCopy.quantity = food.quantity
                foodCopy.gramWeight = food.gramWeight
                foodCopy.modifier = food.modifier
                foodCopy.amount = food.amount
                foodCopy.isCustom = food.isCustom
                foodCopy.isRecipe = food.isRecipe
                foodCopy.foodInfo = food.foodInfo
                foodCopy.meal = mealCopy
            }
        }
        
        try context.save()
        return destination
    }
    
    func createEmptyMealPlan(date: Date, userProfile: UserProfile) throws -> MealPlan {
        guard let userProfile = getUserProfile() else { throw FoodError.missingUserProfile }
        
        let mealNames: [String]
        
        if let latestMealPlan = getPreviousMealPlan(for: date) {
            print("timmy found latest meal plan and extracting meals: \(latestMealPlan.date.formatted(date: .abbreviated, time: .omitted))")
            mealNames = latestMealPlan.meals.map { $0.name }
        } else {
            print("timmy using default meal plan")
            mealNames = ["Breakfast", "Lunch", "Dinner", "Snack"]
        }
        
        print("timmy is creating empty mealPlan for :\(date.formatted(date: .abbreviated, time: .omitted))")
        let mealPlan = MealPlan(context: context)
        mealPlan.date = date
        mealPlan.dateKey = formatDateAsDateKey(date)
        
        // TODO: Get previous meal names if possible
        for (index, name) in mealNames.enumerated() {
            let meal = Meal(context: context)
            meal.index = Int16(index)
            meal.name = name
            meal.mealPlan = mealPlan
            mealPlan.addToMeals_(meal)
        }
        
        copyNutrientGoals(userProfile, to: mealPlan)

        try context.save()
        print("timmy created empty meal plan for \(date.formatted(date: .abbreviated, time: .omitted))")
        return mealPlan
    }
    
    func copyNutrientGoals(_ source: UserProfile, to destination: MealPlan) {
        let userNutrientGoals = source.userNutrientGoals
        for userNutrientGoal in userNutrientGoals {
            let nutrientGoal = NutrientGoal(context: context)
            nutrientGoal.value = userNutrientGoal.value
            nutrientGoal.nutrientId = userNutrientGoal.nutrientId
            destination.addToNutrientGoals_(nutrientGoal)
        }
    }
    
    func getPreviousMealPlan(for date: Date) -> MealPlan? {
        let fetchRequest: NSFetchRequest<MealPlan> = MealPlan.fetchRequest()
        
        let startOfDay = Calendar.current.startOfDay(for: date)
        fetchRequest.predicate = NSPredicate(format: "date_ < %@", startOfDay as NSDate)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date_", ascending: false)]
        fetchRequest.fetchLimit = 1
        
        do {
            if let latestMealPlan = try context.fetch(fetchRequest).first {
                print("timmy found latest meal plan for \(latestMealPlan.date.formatted(date: .abbreviated, time: .omitted))")
                return latestMealPlan
            } else {
                print("timmy no latest meal plan exist")
            }
        } catch {
            print("Fetch failed: \(error)")
        }
        
        return nil
    }
    
    // TODO: Maybe add one with fdcFood and one that takes in a foodEntry (from history?)?
    func addFood(_ fdcFood: FoodItem, foodEntry: FoodEntry? = nil, with portion: FoodPortion, quantity: Int, to meal: Meal? = nil) throws -> FoodEntry {
        let food = FoodEntry(context: context)
        if let meal {
            food.index = Int16(meal.foodEntries.count)
        }
        food.quantity = Int16(quantity)
        if let gramWeight = portion.gramWeight {
            food.gramWeight = gramWeight
        }
        food.portionId = Int32(portion.id)
        if let foodEntry {
            food.isCustom = foodEntry.isCustom
            food.isRecipe = foodEntry.isRecipe
        } else {
            food.isCustom = false
            food.isRecipe = false
        }

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
        
        food.meal = meal
        
        if let foodInfo = getFoodInfo(fdcId: fdcFood.fdcId) {
            food.foodInfo = foodInfo
        } else {
            let foodInfo = createFoodInfo(fdcFood)
            food.foodInfo = foodInfo
            
            // Add nutrients relationship to foodInfo
            for nutrientId in NutrientId.allCases {
                let foodInfoNutrient = createFoodInfoNutrients(fdcFood, nutrientId: nutrientId)
                print("\(nutrientId.description) \(foodInfoNutrient.value)")
                foodInfo.addToNutrients_(foodInfoNutrient)
            }
            
            // Add portion relationship
            for (index, fdcPortion) in fdcFood.foodPortions.enumerated() {
                let portion = createFoodInfoPortion(fdcPortion)
                foodInfo.addToPortions_(portion)
            }
        }
        
        if let foodEntry {
            let ingredients = foodEntry.ingredients
            for ingredient in ingredients {
                let ingredientCopy = FoodEntry(context: context)
                ingredientCopy.amount = ingredient.amount
                ingredientCopy.gramWeight = ingredient.gramWeight
                ingredientCopy.index = ingredient.index
                ingredientCopy.modifier = ingredient.modifier
                ingredientCopy.portionId = ingredient.portionId
                ingredientCopy.quantity = ingredient.quantity
                ingredientCopy.foodInfo = ingredient.foodInfo
                ingredientCopy.isCustom = ingredient.isCustom
                ingredientCopy.isRecipe = ingredient.isRecipe
                ingredientCopy.parent = food   // updates ingredients aswell
            }
        }
        
        
        // Add copy to history
        updateFoodHistoryIfNeeded(food: food)
        
        try context.save()
        
        return food
    }
        
    func getFoodHistory(fdcId: Int) -> History? {
        let request: NSFetchRequest<History> = History.fetchRequest()
        request.predicate = NSPredicate(format: "fdcId == %@", NSNumber(value: fdcId))  // to work with Int64 (negatives), %d only works with signed 32
        request.fetchLimit = 1

        do {
            let res = try context.fetch(request).first
            return res
        } catch {
            print("Error checking existence: \(error)")
            return nil
        }
    }
    
    func updateFoodHistoryIfNeeded(food: FoodEntry, context: NSManagedObjectContext = CoreDataStack.shared.context) {
        guard let fdcId = food.foodInfo?.fdcId else { return }
        print("timmy: \(fdcId)")
        if let history = getFoodHistory(fdcId: Int(fdcId)) {
            print("timmy udpate")
            updateHistory(history)
        } else {
            print("timmy add")
            addHistory(foodEntry: food, context: context)
        }
    }
    
    func updateHistory(_ history: History) {
        // Kinda annoying seeing it change positions
//        history.createdAt_ = .now
    }
    
    func addHistory(foodEntry: FoodEntry, context: NSManagedObjectContext = CoreDataStack.shared.context) {
        guard let fdcId = foodEntry.foodInfo?.fdcId else { return }
        
        let history = History(context: context)
        history.fdcId = fdcId
        history.createdAt_ = .now
        
        // Make copy of food entry (to fix bug where deleting foodEntry deletes history)
        let foodEntryCopy = FoodEntry(context: context)
        foodEntryCopy.amount = foodEntry.amount
        foodEntryCopy.gramWeight = foodEntry.gramWeight
        foodEntryCopy.index = foodEntry.index    // doesn't matter
        foodEntryCopy.modifier = foodEntry.modifier
        foodEntryCopy.portionId = foodEntry.portionId
        foodEntryCopy.quantity = foodEntry.quantity
        foodEntryCopy.foodInfo = foodEntry.foodInfo
        foodEntryCopy.isCustom = foodEntry.isCustom
        foodEntryCopy.isRecipe = foodEntry.isRecipe
        // TODO: Copy ingredients
        for ingredient in foodEntry.ingredients {
            let ingredientCopy = FoodEntry(context: context)
            ingredientCopy.amount = ingredient.amount
            ingredientCopy.gramWeight = ingredient.gramWeight
            ingredientCopy.index = ingredient.index    // doesn't matter
            ingredientCopy.modifier = ingredient.modifier
            ingredientCopy.portionId = ingredient.portionId
            ingredientCopy.quantity = ingredient.quantity
            ingredientCopy.foodInfo = ingredient.foodInfo
            ingredientCopy.isCustom = ingredient.isCustom
            ingredientCopy.isRecipe = ingredient.isRecipe
            ingredientCopy.parent = foodEntryCopy   // updates ingredients aswell
        }
        history.foodEntry = foodEntryCopy
    }

    
    func updateFood(_ foodEntry: FoodEntry, foodPortion: FoodPortion, quantity: Int) throws -> FoodEntry {
        foodEntry.quantity = Int16(quantity)
        foodEntry.amount = foodPortion.amount
        foodEntry.gramWeight = foodPortion.gramWeight
        foodEntry.modifier = foodPortion.modifier
        foodEntry.portionId = Int32(foodPortion.id)  // 100g - 0, custom - 1
        try context.save()
        
        return foodEntry
    }
    
    func deleteFood(_ food: FoodEntry) throws {
        context.delete(food)

        try context.save()
    }
    
    func createFoodInfo(_ fdcFood: FoodItem) -> FoodInfo {
        print("timmy food info: \(fdcFood.description)")
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
        if let gramWeight = foodPortion.gramWeight {
            foodInfoPortion.gramWeight = foodPortion.gramWeight
        }
        if let amount = foodPortion.amount,
           let modifier = foodPortion.modifier {
            foodInfoPortion.amount = Double(amount)
            foodInfoPortion.modifier = modifier
        } else if let portionDescription = foodPortion.portionDescription {
            // extract "banana" from "1 banana"
            // TODO: Use sheets with portionId
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
        var searchResultResponse = try await sendRequest(abridgedRequest)
        let fdcIds = searchResultResponse.foodParts.map { $0.fdcId }
        // Note: Need another api call to get portions
        
        let foods: [FoodItem] = try await withThrowingTaskGroup(of: FoodItem.self) { group in
            var foodDict: [Int: FoodItem] = [:]
            
            for id in fdcIds {
                group.addTask {
                    let food = try await self.getFood(fdcId: id)
                    return food
                }
            }
            
            for try await food in group {
                foodDict[food.fdcId] = food
            }
            
            // Sort by original order of fdcIds
            let sortedFoods = fdcIds.compactMap { foodDict[$0] }
            return sortedFoods
        }
    
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
