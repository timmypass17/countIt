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
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FoodApp")
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
        let date = Calendar.current.startOfDay(for: date)
        let request: NSFetchRequest<MealPlan> = MealPlan.fetchRequest()
        request.predicate = NSPredicate(format: "date_ == %@", date as NSDate)
        request.fetchLimit = 1
        
        do {
            let mealPlans = try context.fetch(request)
            if let mealPlan = mealPlans.first {
                print("Found meal")
                return mealPlan
            }
            print("No meal")
            return nil
        } catch {
            print("Error fetching meal plan: \(error)")
            return nil
        }
    }
    
    func addFoodEntry(_ food: Food, to meal: Meal, servingSize: FoodPortion, numberOfServings: Int) -> FoodEntry {
        let foodEntry = FoodEntry(context: context)
        foodEntry.index = Int16(meal.foodEntries.count)
        foodEntry.servingSize = servingSize
        foodEntry.numberOfServings = numberOfServings

        // Relationship
        foodEntry.food = food.convertToCDFood(context: context)
        foodEntry.meal = meal   // equivalent: meal.addToFoodEntries_(foodEntry)

        return foodEntry
    }
    
    func updateFoodEntry(foodEntry: FoodEntry, servingSize: FoodPortion, numberOfServings: Int) -> FoodEntry {
        foodEntry.servingSize = servingSize
        foodEntry.numberOfServings = numberOfServings
        return foodEntry
    }
    
    // Decode: json -> object
    static func decode<T: Decodable>(jsonString: String) -> T {
        let data = jsonString.data(using: .utf8)!
        return try! JSONDecoder().decode(T.self, from: data)
    }
    
    // Encode: object -> json
    static func encode<T: Encodable>(value: T) -> String {
        let reminderData = try! JSONEncoder().encode(value)
        return String(data: reminderData, encoding:.utf8)!
    }
    
}
