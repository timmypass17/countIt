//
//  Nutrient+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/1/25.
//
//

import Foundation
import CoreData


extension Nutrient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Nutrient> {
        return NSFetchRequest<Nutrient>(entityName: "Nutrient")
    }

    @NSManaged public var value: Double
    @NSManaged public var nutrientId: Int32
    @NSManaged public var foodInfo_: FoodInfo?

}
