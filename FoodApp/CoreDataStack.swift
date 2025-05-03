//
//  CoreDataStack.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/16/24.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let appGroup = "group.com.example.DuduMelon"
        let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup)!
        let storeURL = containerURL.appendingPathComponent("FoodApp.sqlite") // FoodApp.xcdatamodeld
        let description = NSPersistentStoreDescription(url: storeURL)
        // Maybe remove?
        description.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.example.DuduMelon")
        let container = NSPersistentCloudKitContainer(name: "FoodApp")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
}

extension CoreDataStack {
    func saveContext () {
        print(#function)
        if context.hasChanges {
            do {
                try context.save()
                print("Saved Success")
            } catch {
                print("Error saving: \(error)")
            }
        }
    }
    
    func getMealPlan(for date: Date) -> MealPlan? {
        return nil
//        let date = Calendar.current.startOfDay(for: date)
//        let request: NSFetchRequest<MealPlan> = MealPlan.fetchRequest()
//        request.predicate = NSPredicate(format: "date_ == %@", date as NSDate)
//        request.fetchLimit = 1
//        
//        do {
//            let mealPlans = try context.fetch(request)
//            if let mealPlan = mealPlans.first {
//                return mealPlan
//            }
//            return nil
//        } catch {
//            print("Error fetching meal plan: \(error)")
//            return nil
//        }
    }
    
    func addFoodEntry(_ food: FoodItem, to meal: Meal, servingSize: FoodPortion, numberOfServings: Int, servingSizeUnit: String) -> Food {
        let foodEntry = Food(context: context)
//        foodEntry.index = Int16(meal.foodEntries.count)
//        foodEntry.servingSize = servingSize
//        foodEntry.numberOfServings = numberOfServings
//        foodEntry.servingSizeUnit = servingSizeUnit
//
//        // Relationship
//        if let existingFood = getCDFood(id: food.fdcId) {
//            foodEntry.food = existingFood
//        } else {
//            foodEntry.food = food.convertToCDFood(context: context)
//        }
//        foodEntry.food?.updatedAt = .now
//        foodEntry.meal = meal   // equivalent: meal.addToFoodEntries_(foodEntry)

        return foodEntry
    }
    
    func updateFoodEntry(foodEntry: Food, servingSize: FoodPortion, numberOfServings: Int) -> Food {
//        foodEntry.servingSize = servingSize
//        foodEntry.numberOfServings = numberOfServings
        return foodEntry
    }
    
    func addMeal(mealName: String, to mealPlan: MealPlan) {
        let meal = Meal(context: context)
//        meal.name = mealName
//        meal.index = Int16(mealPlan.meals.count)
//        meal.mealPlan = mealPlan
    }
    
    func copy(mealPlanAt date: Date, into mealPlan: MealPlan) -> MealPlan {
        let copiedMealPlan = getMealPlan(for: date) ?? createEmpty(for: date)
        
        // 1. Override original meal plan
        context.delete(mealPlan)
        
        // 2. Create new meal plan using selected meal plan
        let newMealPlan = MealPlan(context: context)
//        newMealPlan.date = Calendar.current.startOfDay(for: mealPlan.date)
//        newMealPlan.nutrientGoals = copiedMealPlan.nutrientGoals
//        for copiedMeal in copiedMealPlan.meals {
//            let meal = Meal(context: context)
//            meal.name = copiedMeal.name
//            meal.index = copiedMeal.index
//            meal.mealPlan = newMealPlan
//            for copiedFoodEntry in copiedMeal.foodEntries {
//                let foodEntry = FoodEntry(context: context)
//                foodEntry.index = copiedFoodEntry.index
//                foodEntry.numberOfServings = copiedFoodEntry.numberOfServings
//                foodEntry.servingSize = copiedFoodEntry.servingSize
//                foodEntry.meal = meal
//                foodEntry.food = copiedFoodEntry.food
//            }
//        }
        
        return newMealPlan
    }
    
    func getCDFood(id: Int) -> Food? {
        return nil
//        let request: NSFetchRequest<CDFood> = CDFood.fetchRequest()
//        request.predicate = NSPredicate(format: "fdcId == %d", id)
//        request.fetchLimit = 1
//        
//        do {
//            let foods = try context.fetch(request)
//            if let food = foods.first {
//                return food
//            }
//            return nil
//        } catch {
//            print("Error fetching food: \(error)")
//            return nil
//        }
    }
    
    func getFoodHistory() -> [Food] {
        return []
//        let request: NSFetchRequest<CDFood> = CDFood.fetchRequest()
//        request.predicate = NSPredicate(format: "updatedAt_ != nil")
//        request.sortDescriptors = [NSSortDescriptor(key: "updatedAt_", ascending: false)]
//        
//        do {
//            let foods = try context.fetch(request)
//            return foods
//        } catch {
//            print("Error fetching history: \(error)")
//            return []
//        }
    }
    
    func deleteHistory(_ food: Food) {
//        food.updatedAt_ = nil
    }
    
    func getLatestMealPlan(currentDate: Date) -> MealPlan? {
        return nil
//        let date = Calendar.current.startOfDay(for: currentDate)
//        let request: NSFetchRequest<MealPlan> = MealPlan.fetchRequest()
//        request.predicate = NSPredicate(format: "date_ != %@", date as NSDate)  // ignore fetch current meal plan
//        request.sortDescriptors = [NSSortDescriptor(key: "date_", ascending: false)]
//        request.fetchLimit = 1
//        
//        do {
//            let mealPlans = try context.fetch(request)
//            if let mealPlan = mealPlans.first {
//                print("Found latest meal plan: \(mealPlan.date)")
//                return mealPlan
//            }
//            print("No latest meal plan")
//            return nil
//        } catch {
//            print("Error fetching latest meal plan: \(error)")
//            return nil
//        }
    }
    
    func createEmpty(for date: Date) -> MealPlan {
        let mealPlan = MealPlan(context: context)
//        mealPlan.date = Calendar.current.startOfDay(for: date)
//        let nutrientGoals: [NutrientID: Float]
//        let mealNames: [String]
//        if let previousMealPlan = getLatestMealPlan(currentDate: date) {
//            nutrientGoals = previousMealPlan.nutrientGoals
//            mealNames = previousMealPlan.meals.map { $0.name }
//        } else {
//            nutrientGoals = UserDailyValues.default2000
//            mealNames = ["Breakfast", "Lunch", "Dinner", "Snack"]
//        }
//        mealPlan.nutrientGoals = nutrientGoals
//        for (i, mealName) in mealNames.enumerated() {
//            let meal = Meal(context: context)
//            meal.name = mealName
//            meal.index = Int16(i)
//            meal.mealPlan = mealPlan
//        }
//        
        return mealPlan
    }
}

extension CoreDataStack {
    // Decode: data -> your object
    static func decode<T: Decodable>(jsonString: String) -> T {
        let data = jsonString.data(using: .utf8)!
        return try! JSONDecoder().decode(T.self, from: data)
    }
    
    // Encode: your object -> data
    static func encode<T: Encodable>(value: T) -> String {
        let reminderData = try! JSONEncoder().encode(value)
        return String(data: reminderData, encoding:.utf8)!
    }
}
