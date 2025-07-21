//
//  FoodInfoNutrient+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/15/25.
//
//

import Foundation
import CoreData


extension FoodInfoNutrient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodInfoNutrient> {
        return NSFetchRequest<FoodInfoNutrient>(entityName: "FoodInfoNutrient")
    }

    @NSManaged public var nutrientId_: NSNumber?
    @NSManaged public var value_: NSNumber?
    @NSManaged public var foodInfo: FoodInfo?

    // Set default value in to "empty" .xcdatamodeld or else it will use default value 0
    var value: Double? {
        get {
            return value_?.doubleValue
        }
        set {
            value_ = newValue.map(NSNumber.init)
        }
    }
    
    var nutrientId: NutrientId? {
        get {
            guard let id = nutrientId_?.int32Value else { return nil }
            return NutrientId(rawValue: Int(id))
        }
        set {
            nutrientId_ = (newValue?.rawValue).map(NSNumber.init)
        }
    }
}

extension FoodInfoNutrient: NutrientIdentifiable {

}
