//
//  NutritientGoal+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/1/25.
//
//

import Foundation
import CoreData


extension NutritientGoal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NutritientGoal> {
        return NSFetchRequest<NutritientGoal>(entityName: "NutritientGoal")
    }

    @NSManaged public var nutrientId: Int32
    @NSManaged public var value: Double
    @NSManaged public var mealPlan: MealPlan?

}
