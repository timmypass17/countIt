//
//  NutrientGoal+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/12/25.
//
//

import Foundation
import CoreData


extension NutrientGoal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NutrientGoal> {
        return NSFetchRequest<NutrientGoal>(entityName: "NutrientGoal")
    }

    @NSManaged public var nutrientId_: NSNumber?
    @NSManaged public var value: Double
    @NSManaged public var mealPlan: MealPlan?

    var nutrientId: NutrientId {
        get {
            guard let rawValue = nutrientId_?.intValue,
                  let id = NutrientId(rawValue: rawValue) else {
                fatalError("Invalid or missing nutrientId_")
            }
            return id
        }
        set {
            nutrientId_ = NSNumber(value: newValue.rawValue)
        }
    }
}

extension NutrientGoal : Identifiable {

}

extension NutrientGoal: NutrientIdentifiable {

}

