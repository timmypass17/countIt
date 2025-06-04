//
//  FoodInfoPortion+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/20/25.
//
//

import Foundation
import CoreData


extension FoodInfoPortion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodInfoPortion> {
        return NSFetchRequest<FoodInfoPortion>(entityName: "FoodInfoPortion")
    }
    
    // 1 banana (100g)
    @NSManaged public var gramWeight: Double // 100
    @NSManaged public var amount_: NSNumber? // 1
    @NSManaged public var modifier: String?  // banana
    // Add unitName? g or ml
    @NSManaged public var id: Int32
    @NSManaged public var foodInfo: FoodInfo?
    @NSManaged public var food: Food?

    var amount: Double? {
        get { amount_?.doubleValue }
        set { amount_ = newValue.map(NSNumber.init) }
    }
}
