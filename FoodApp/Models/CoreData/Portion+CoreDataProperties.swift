//
//  Portion+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/1/25.
//
//

import Foundation
import CoreData


extension Portion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Portion> {
        return NSFetchRequest<Portion>(entityName: "Portion")
    }

    @NSManaged public var value: Double
    @NSManaged public var grams: Double
    @NSManaged public var modifier_: String?
    @NSManaged public var foodInfo_: FoodInfo?

}
