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
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getMealPlan(for date: Date) -> MealPlan? {
        let request: NSFetchRequest<MealPlan> = MealPlan.fetchRequest()
        request.predicate = NSPredicate(format: "date_ == %@", date as NSDate)
        request.fetchLimit = 1
        
        do {
            let mealPlans = try context.fetch(request)
            print(#function)
            return mealPlans.first
        } catch {
            print("Error fetching meal plan: \(error)")
            return nil
        }
    }
}
