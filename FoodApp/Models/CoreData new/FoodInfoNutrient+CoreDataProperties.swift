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
    @NSManaged public var value: Double
    @NSManaged public var foodInfo: FoodInfo?

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
