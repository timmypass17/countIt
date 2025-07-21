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
        return meals.allSatisfy { $0.foodEntries.count == 0 }
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

extension MealPlan {
    static let sample: MealPlan = {
        let context = CoreDataStack.shared.childContext()
        let mealPlan = MealPlan(context: context)
        
        mealPlan.date = .now
        mealPlan.dateKey = formatDateAsDateKey(.now)

        let calorieGoal = NutrientGoal(context: context)
        calorieGoal.value = 2000
        calorieGoal.nutrientId = .calories
        mealPlan.addToNutrientGoals_(calorieGoal)
                
        let carbGoal = NutrientGoal(context: context)
        carbGoal.value = 250 // grams
        carbGoal.nutrientId = .carbs
        mealPlan.addToNutrientGoals_(carbGoal)

        let proteinGoal = NutrientGoal(context: context)
        proteinGoal.value = 150 // grams
        proteinGoal.nutrientId = .protein
        mealPlan.addToNutrientGoals_(proteinGoal)

        let fatGoal = NutrientGoal(context: context)
        fatGoal.value = 70 // grams
        fatGoal.nutrientId = .fatTotal
        mealPlan.addToNutrientGoals_(fatGoal)
        
        
        let mealNames = ["Breakfast", "Lunch", "Dinner", "Snack"]
        
        for (index, mealName) in mealNames.enumerated() {
            let meal = Meal(context: context)
            meal.index = Int16(index)
            meal.name = mealName
            meal.mealPlan = mealPlan
            mealPlan.addToMeals_(meal)
        }
        
        let breakfast = mealPlan.meals[0]
        let egg = FoodEntry(context: context)
        
        let foodInfo = FoodInfo(context: context)
        foodInfo.fdcId = Int64.random(in: Int64.min..<0)    // negative means user generated
        foodInfo.brandName_ = nil
        egg.foodInfo = foodInfo
        
        for nutrientId in NutrientId.allCases {
            let foodInfoNutrient = FoodInfoNutrient(context: context)
            foodInfoNutrient.nutrientId = nutrientId
            foodInfo.addToNutrients_(foodInfoNutrient)
        }
        
        egg.foodInfo?.nutrients[.calories]?.value = 100
        breakfast.addToFoodEntries_(egg)
        
        return mealPlan
    }()
}
