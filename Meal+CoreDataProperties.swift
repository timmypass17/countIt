//
//  Meal+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/17/24.
//
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
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
        get { (foodEntries_?.allObjects as! [FoodEntry]).sorted() }
        set { foodEntries_ = NSSet(array: newValue) }
    }
    
    func getTotalNutrients(_ nutrientID: NutrientID) -> Float {
        var nutrientAmount: Float = 0.0
        for foodEntry in foodEntries {
            nutrientAmount += foodEntry.getTotalNutrients(nutrientID)
        }
        return nutrientAmount
    }
    
    func updateIndexes() {
        for (index, foodEntry) in foodEntries.enumerated() {
            foodEntry.index = Int16(index)
        }
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

extension Meal : Identifiable {

}

extension Meal: Comparable {
    public static func < (lhs: Meal, rhs: Meal) -> Bool {
        return lhs.index < rhs.index
    }
}
