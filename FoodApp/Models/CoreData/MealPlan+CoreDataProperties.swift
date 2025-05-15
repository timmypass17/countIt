//
//  MealPlan+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/1/25.
//
//

import Foundation
import CoreData


extension MealPlan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealPlan> {
        return NSFetchRequest<MealPlan>(entityName: "MealPlan")
    }

    @NSManaged public var date_: Date?
    @NSManaged public var meals_: NSSet?
    @NSManaged public var nutrientGoals_: NSSet?
    
    var date: Date {
        get {
            date_ ?? Calendar.current.startOfDay(for: .now)
        }
        set {
            date_ = Calendar.current.startOfDay(for: newValue)
        }
    }
    
    var meals: [Meal] {
        get { (meals_?.allObjects as! [Meal]).sorted { $0.index < $1.index } }
        set { meals_ = NSSet(array: newValue) }
    }
    
    var nutrientGoals: [NutrientGoal] {
        get {
            nutrientGoals_?.allObjects as! [NutrientGoal]
        }
        set {
            nutrientGoals_ = NSSet(array: newValue)
        }
    }
    
    
}

protocol NutrientIdentifiable {
    var nutrientId: NutrientId { get }
}

extension Array where Element: NutrientIdentifiable {
    subscript(nutrientID: NutrientId) -> Element? {
        self.first { $0.nutrientId == nutrientID }
    }
}


// MARK: Generated accessors for meals_
extension MealPlan {

    @objc(addMeals_Object:)
    @NSManaged public func addToMeals_(_ value: Meal)

    @objc(removeMeals_Object:)
    @NSManaged public func removeFromMeals_(_ value: Meal)

    @objc(addMeals_:)
    @NSManaged public func addToMeals_(_ values: NSSet)

    @objc(removeMeals_:)
    @NSManaged public func removeFromMeals_(_ values: NSSet)

}

// MARK: Generated accessors for nutrientGoals_
extension MealPlan {

    @objc(addNutrientGoals_Object:)
    @NSManaged public func addToNutrientGoals_(_ value: NutrientGoal)

    @objc(removeNutrientGoals_Object:)
    @NSManaged public func removeFromNutrientGoals_(_ value: NutrientGoal)

    @objc(addNutrientGoals_:)
    @NSManaged public func addToNutrientGoals_(_ values: NSSet)

    @objc(removeNutrientGoals_:)
    @NSManaged public func removeFromNutrientGoals_(_ values: NSSet)

}
