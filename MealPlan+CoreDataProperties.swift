//
//  MealPlan+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/17/24.
//
//

import Foundation
import CoreData


extension MealPlan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealPlan> {
        return NSFetchRequest<MealPlan>(entityName: "MealPlan")
    }

    @NSManaged public var nutrientGoals_: String?
    @NSManaged public var date_: Date?
    @NSManaged public var meals_: NSSet?
    
    var nutrientGoals : [NutrientID : Float] {
        get { return CoreDataStack.decode(jsonString: nutrientGoals_!) }
        set {
            nutrientGoals_ = CoreDataStack.encode(value: newValue)
        }
    }
    
    enum Key: String, CaseIterable {
        case nutrientGoal = "nutrientGoals_"
        case date = "date_"
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
    
    var date: Date {
        get { date_ ?? .now }
        set { date_ = newValue }
    }
    
    var meals: [Meal] {
        get { (meals_?.allObjects as! [Meal]).sorted() }
        set { meals_ = NSSet(array: newValue) }
    }
    
    func getTotalNutrients(_ nutrientID: NutrientID) -> Float {
        var nutrientAmount: Float = 0.0
        for meal in meals {
            nutrientAmount += meal.getTotalNutrients(nutrientID)
        }
        return nutrientAmount
    }
    
    var isEmpty: Bool {
        return meals.allSatisfy { $0.foodEntries.isEmpty }
    }
}

extension MealPlan : Identifiable {

}

extension MealPlan {
    
    func printPrettyString() {
//        print("Meal Plan: \(self.date)")
//        print("Meals Count \(self.meals.count)")
//        for meal in self.meals {
//            print("\(meal.name)")
//            for entry in meal.foodEntries {
//                print("\(entry.food?.description_ ?? "")")
//                print("\(entry.food?.foodPortions.first?.getServingSizeFormatted())")
//            }
//        }
//        print()
    }
}
