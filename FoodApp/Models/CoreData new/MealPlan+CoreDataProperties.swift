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

    @NSManaged public var date_: Date?  // always stored as utc midnight (12:00AM)
    @NSManaged public var dateKey_: String? // e.g. "06/04/2025"
    @NSManaged public var meals_: NSSet?
    @NSManaged public var nutrientGoals_: NSSet?
    
    var date: Date {
        get {
            return date_ ?? Calendar.current.startOfDay(for: Date())
        }
        set {
            date_ = Calendar.current.startOfDay(for: newValue)
        }
    }
    
    var dateKey: String {
        get {
            return dateKey_ ?? ""
        }
        set {
            dateKey_ = newValue
        }
    }
    
    var meals: [Meal] {
        get { (meals_?.allObjects as? [Meal] ?? []).sorted { $0.index < $1.index } }
        set { meals_ = NSSet(array: newValue) }
    }
    
    var nutrientGoals: [NutrientGoal] {
        get {
            nutrientGoals_?.allObjects as? [NutrientGoal] ?? []
        }
        set {
            nutrientGoals_ = NSSet(array: newValue)
        }
    }
    
    var isEmpty: Bool {
        return meals.allSatisfy { $0.foods.count == 0 }
    }
    
    func nutrientAmount(_ nutrientId: NutrientId) -> Double {
        return meals.map { $0.nutrientAmount(nutrientId) }.reduce(0, +)
    }
    
    static func fetchRequest(for date: Date) -> NSFetchRequest<MealPlan> {
        let request = NSFetchRequest<MealPlan>(entityName: "MealPlan")

        var utcCalendar = Calendar(identifier: .gregorian)
        utcCalendar.timeZone = TimeZone(secondsFromGMT: 0)!

        let startOfUTCDay = utcCalendar.startOfDay(for: date)   // 00:00
        let predicate = NSPredicate(format: "dateUTC == %@", startOfUTCDay as NSDate)

        request.predicate = predicate
        request.fetchLimit = 1
        return request
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
