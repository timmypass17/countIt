//
//  CDFood+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/17/24.
//
//

import Foundation
import CoreData


extension CDFood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFood> {
        return NSFetchRequest<CDFood>(entityName: "CDFood")
    }

    @NSManaged public var brandName_: String?
    @NSManaged public var dataType_: String?
    @NSManaged public var description_: String?
    @NSManaged public var fdcId: Int64
    @NSManaged public var foodNutrients_: [FoodNutrient]?
    @NSManaged public var foodPortions_: [FoodPortion]?
    @NSManaged public var servingSize: Float
    @NSManaged public var servingSizeUnit_: String?
    @NSManaged public var foodEntries_: NSSet?

    var foodNutrients: [FoodNutrient] {
        get { foodNutrients_ ?? [] }
        set { foodNutrients_ = newValue }
    }
    
    var foodPortions: [FoodPortion] {
        get { foodPortions_ ?? [] }
        set { foodPortions_ = newValue }
    }
    
    var brandName: String {
        get { brandName_ ?? "" }
        set { brandName_ = newValue }
    }
    
    var servingSizeUnit: String {
        get { servingSizeUnit_ ?? "" }
        set { servingSizeUnit_ = newValue }
    }
}

// MARK: Generated accessors for foodEntries_
extension CDFood {

    @objc(addFoodEntries_Object:)
    @NSManaged public func addToFoodEntries_(_ value: FoodEntry)

    @objc(removeFoodEntries_Object:)
    @NSManaged public func removeFromFoodEntries_(_ value: FoodEntry)

    @objc(addFoodEntries_:)
    @NSManaged public func addToFoodEntries_(_ values: NSSet)

    @objc(removeFoodEntries_:)
    @NSManaged public func removeFromFoodEntries_(_ values: NSSet)

}

extension CDFood : Identifiable {

}
