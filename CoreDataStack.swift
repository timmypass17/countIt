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
//        ValueTransformer.setValueTransformer(FoodPortionToDataTransformer(), forName: .foodPortionToDataTransformer)

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
        foodEntry.food = food.convertToCDFood(context: context)
        foodEntry.index = Int16(meal.foodEntries.count)
        foodEntry.servingSize = servingSize
        foodEntry.numberOfServings = Int16(numberOfServings)
        foodEntry.meal = meal

        meal.addToFoodEntries_(foodEntry)
        foodEntry.food?.addToFoodEntries_(foodEntry)
        
        saveContext()
        return foodEntry
    }
}
