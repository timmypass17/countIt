//
//  Food+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/1/25.
//
//

import Foundation
import CoreData


extension Food {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        return NSFetchRequest<Food>(entityName: "Food")
    }

    @NSManaged public var index: Int16
    @NSManaged public var numberOfServings: Int16
    @NSManaged public var servingSize: Double
    @NSManaged public var modifier_: String?
    @NSManaged public var foodInfo_: FoodInfo?
    @NSManaged public var meal_: Meal?

}
