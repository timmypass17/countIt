////
////  FoodInfo+CoreDataProperties.swift
////  FoodApp
////
////  Created by Timmy Nguyen on 5/1/25.
////
////
//
//import Foundation
//import CoreData
//
//
//extension FoodInfo {
//
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodInfo> {
//        return NSFetchRequest<FoodInfo>(entityName: "FoodInfo")
//    }
//
//    @NSManaged public var brandName_: String?
//    @NSManaged public var dataType_: String?
//    @NSManaged public var description_: String?
//    @NSManaged public var fdcId: Int64
//    @NSManaged public var food_: NSSet?
//    @NSManaged public var nutrients_: NSSet?
//    @NSManaged public var portions_: NSSet?
//
//}
//
//// MARK: Generated accessors for food_
//extension FoodInfo {
//
//    @objc(addFood_Object:)
//    @NSManaged public func addToFood_(_ value: Food)
//
//    @objc(removeFood_Object:)
//    @NSManaged public func removeFromFood_(_ value: Food)
//
//    @objc(addFood_:)
//    @NSManaged public func addToFood_(_ values: NSSet)
//
//    @objc(removeFood_:)
//    @NSManaged public func removeFromFood_(_ values: NSSet)
//
//}
//
//// MARK: Generated accessors for nutrients_
//extension FoodInfo {
//
//    @objc(addNutrients_Object:)
//    @NSManaged public func addToNutrients_(_ value: Nutrient)
//
//    @objc(removeNutrients_Object:)
//    @NSManaged public func removeFromNutrients_(_ value: Nutrient)
//
//    @objc(addNutrients_:)
//    @NSManaged public func addToNutrients_(_ values: NSSet)
//
//    @objc(removeNutrients_:)
//    @NSManaged public func removeFromNutrients_(_ values: NSSet)
//
//}
//
//// MARK: Generated accessors for portions_
//extension FoodInfo {
//
//    @objc(addPortions_Object:)
//    @NSManaged public func addToPortions_(_ value: Portion)
//
//    @objc(removePortions_Object:)
//    @NSManaged public func removeFromPortions_(_ value: Portion)
//
//    @objc(addPortions_:)
//    @NSManaged public func addToPortions_(_ values: NSSet)
//
//    @objc(removePortions_:)
//    @NSManaged public func removeFromPortions_(_ values: NSSet)
//
//}
