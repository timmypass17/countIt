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
    @NSManaged public func addToNutrientGoals_(_ value: NutritientGoal)

    @objc(removeNutrientGoals_Object:)
    @NSManaged public func removeFromNutrientGoals_(_ value: NutritientGoal)

    @objc(addNutrientGoals_:)
    @NSManaged public func addToNutrientGoals_(_ values: NSSet)

    @objc(removeNutrientGoals_:)
    @NSManaged public func removeFromNutrientGoals_(_ values: NSSet)

}
