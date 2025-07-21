//
//  Meal+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/15/25.
//
//

import Foundation
import CoreData


extension Meal {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }
    
    static func fetchMeals(for mealPlan: MealPlan) -> NSFetchRequest<Meal> {
        let request = NSFetchRequest<Meal>(entityName: "Meal")
        request.predicate = NSPredicate(format: "mealPlan == %@", mealPlan)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Meal.index, ascending: true)]
        return request
    }
    
    static func emptyFetchRequest() -> NSFetchRequest<Meal> {
        let request = Meal.fetchRequest()
        request.predicate = NSPredicate(value: false)
        return request
    }

    @NSManaged public var index: Int16
    @NSManaged public var name_: String?
    @NSManaged public var foodEntries_: NSSet?
    @NSManaged public var mealPlan: MealPlan?
    
    var name: String {
        get { name_ ?? "" }
        set { name_ = newValue }
    }
    
    var foodEntries: [FoodEntry] {
        get { (foodEntries_?.allObjects as! [FoodEntry]).sorted { $0.index < $1.index } }
        set { foodEntries_ = NSSet(array: newValue) }
    }
    
    func nutrientAmount(_ nutrientId: NutrientId) -> Double {
        return foodEntries.map { $0.getNutrientAmount(nutrientId, quantity: Int($0.quantity)) }.reduce(0, +)
    }
}

// MARK: Generated accessors for foodEntries_
extension Meal {

    @objc(addFoodEntries_Object:)
    @NSManaged public func addToFoodEntries_(_ value: FoodEntry)

    @objc(removeFoodEntries_Object:)
    @NSManaged public func removeFromFoodEntries_(_ value: FoodEntry)

    @objc(addFoodEntries_:)
    @NSManaged public func addToFoodEntries_(_ values: NSSet)

    @objc(removeFoodEntries_:)
    @NSManaged public func removeFromFoodEntries_(_ values: NSSet)

}
