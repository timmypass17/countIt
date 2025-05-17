//
//  Meal+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/1/25.
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
        request.predicate = NSPredicate(format: "mealPlan_ == %@", mealPlan)
        request.sortDescriptors = [NSSortDescriptor(key: "index", ascending: true)] // keypath
        return request
    }

    @NSManaged public var index: Int16
    @NSManaged public var name_: String?
    @NSManaged public var foods_: NSSet?
    @NSManaged public var mealPlan: MealPlan?
    
    var name: String {
        get { name_ ?? "" }
        set { name_ = newValue }
    }
    
    var foods: [Food] {
        get { (foods_?.allObjects as! [Food]).sorted { $0.index < $1.index } }
        set { foods_ = NSSet(array: newValue) }
    }
}

// MARK: Generated accessors for foods
extension Meal {

    @objc(addFoods_Object:)
    @NSManaged public func addToFoods_(_ value: Food)

    @objc(removeFoods_Object:)
    @NSManaged public func removeFromFoods_(_ value: Food)

    @objc(addFoods_:)
    @NSManaged public func addToFoods_(_ values: NSSet)

    @objc(removeFoods_:)
    @NSManaged public func removeFromFoods_(_ values: NSSet)

}
