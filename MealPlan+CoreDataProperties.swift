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

    @NSManaged public var date_: Date?
    @NSManaged public var meals_: NSSet?

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

}

extension MealPlan : Identifiable {

}

extension MealPlan {
    static let sample: MealPlan = {
        let context = CoreDataStack.shared.context
        print("Sample: \(context)")
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: .now) // don't include time so that we match predicate
        let date = Calendar.current.date(from: dateComponents)!
        
        let mealPlan = MealPlan(context: context)
        mealPlan.date = date
        
        let breakfast = Meal(context: context)
        breakfast.name = "Breakfast"
        breakfast.index = 0
        breakfast.mealPlan = mealPlan
        mealPlan.addToMeals_(breakfast)
        
//        let bananaEntry = FoodEntry(context: context)
//        bananaEntry.food = CDFood.sample
//        bananaEntry.index = 0
//        bananaEntry.servingSize = FoodPortion(amount: 1, gramWeight: 118, modifier: "medium (7\" to 7-7/8\" long) ")
//        bananaEntry.numberOfServings = 1
//        bananaEntry.meal = breakfast
//        breakfast.addToFoodEntries_(bananaEntry)
        
        let lunch = Meal(context: context)
        lunch.name = "Lunch"
        lunch.index = 1
        lunch.mealPlan = mealPlan
        mealPlan.addToMeals_(lunch)
        
        return mealPlan
    }()
    
    func printPrettyString() {
        print("Meal Plan: \(self.date.formatted())")
        print("Meals Count \(self.meals.count)")
        for meal in self.meals {
            print("\(meal.name)")
            for entry in meal.foodEntries {
                print("\(entry.food?.description_ ?? "")")
                print("\(entry.food?.foodPortions.first?.getServingSizeFormatted())")

            }
        }
    }
}
