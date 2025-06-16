//
//  History+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/6/25.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var createdAt_: Date?
    @NSManaged public var fdcId: Int64
    @NSManaged public var foodEntry: FoodEntry?

}
