//
//  FoodInfo+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/15/25.
//
//

import Foundation
import CoreData


extension FoodInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodInfo> {
        return NSFetchRequest<FoodInfo>(entityName: "FoodInfo")
    }

    @NSManaged public var brandName_: String?
    @NSManaged public var name_: String?
    @NSManaged public var fdcId: Int64
    @NSManaged public var foods_: NSSet?
    @NSManaged public var nutrients_: NSSet?

    var name: String {
        get {
            return name_ ?? ""
        }
        set {
            name_ = newValue
        }
    }
    
    var nutrients: [FoodInfoNutrient] {
        get {
            return (nutrients_?.allObjects as! [FoodInfoNutrient])
        }
        set {
            nutrients_ = NSSet(array: newValue)
        }
    }
}

// MARK: Generated accessors for food
extension FoodInfo {

    @objc(addFoods_Object:)
    @NSManaged public func addToFoods_(_ value: Food)

    @objc(removeFoods_Object:)
    @NSManaged public func removeFromFoods_(_ value: Food)

    @objc(addFoods_:)
    @NSManaged public func addToFoods_(_ values: NSSet)

    @objc(removeFoods_:)
    @NSManaged public func removeFromFoods_(_ values: NSSet)

}

// MARK: Generated accessors for nutrients_
extension FoodInfo {

    @objc(addNutrients_Object:)
    @NSManaged public func addToNutrients_(_ value: FoodInfoNutrient)

    @objc(removeNutrients_Object:)
    @NSManaged public func removeFromNutrients_(_ value: FoodInfoNutrient)

    @objc(addNutrients_:)
    @NSManaged public func addToNutrients_(_ values: NSSet)

    @objc(removeNutrients_:)
    @NSManaged public func removeFromNutrients_(_ values: NSSet)

}
