//
//  UserNutrientGoal+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/11/25.
//
//

import Foundation
import CoreData


extension UserNutrientGoal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserNutrientGoal> {
        return NSFetchRequest<UserNutrientGoal>(entityName: "UserNutrientGoal")
    }
    
    @NSManaged public var nutrientId_: NSNumber?
    @NSManaged public var value: Double
    @NSManaged public var userProfile: UserProfile?

    var nutrientId: NutrientId? {
        get {
            guard let rawValue = nutrientId_?.intValue,
                  let id = NutrientId(rawValue: rawValue) else {
                fatalError("Invalid or missing nutrientId_")
            }
            return id
        }
        set {
            guard let id = newValue?.rawValue else {
                nutrientId_ = nil
                return
            }
            nutrientId_ = NSNumber(value: id)
        }
    }
    
}

extension UserNutrientGoal : Identifiable {

}
