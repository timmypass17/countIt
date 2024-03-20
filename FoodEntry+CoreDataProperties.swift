//
//  FoodEntry+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/17/24.
//
//

import Foundation
import CoreData


extension FoodEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodEntry> {
        return NSFetchRequest<FoodEntry>(entityName: "FoodEntry")
    }

    @NSManaged public var index: Int16
    @NSManaged public var numberOfServings_: Int16
    @NSManaged public var servingSize_: String?
    @NSManaged public var food: CDFood?
    @NSManaged public var meal: Meal?

    var numberOfServings: Int {
        get { return Int(numberOfServings_) }
        set { numberOfServings_ = Int16(newValue) }
    }
    
    var servingSize : FoodPortion {
        get { return CoreDataStack.decode(jsonString: servingSize_!) }
        set { servingSize_ = CoreDataStack.encode(value: newValue) }
    }
    
    func getTotalNutrients(_ nutrientID: NutrientID) -> Float {
        guard let food = food?.convertToFDCFood() else { return 0 }
        let nutrientAmount = food.getNutrientPerServing(nutrientID, foodPortion: servingSize) * Float(numberOfServings)
        return nutrientAmount
    }
}


extension FoodEntry : Identifiable {

}

extension FoodEntry: Comparable {
    public static func < (lhs: FoodEntry, rhs: FoodEntry) -> Bool {
        return lhs.index < rhs.index
    }
}
