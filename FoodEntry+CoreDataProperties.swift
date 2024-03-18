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
    @NSManaged public var numberOfServings: Int16
    @NSManaged public var servingSize_: String?
    @NSManaged public var food: CDFood?
    @NSManaged public var meal: Meal?

    var servingSize : FoodPortion {
        get {
            return (try? JSONDecoder().decode(FoodPortion.self, from: Data(servingSize_!.utf8)))!
        }
        set {
           do {
               let servingSizeData = try JSONEncoder().encode(newValue)
               servingSize_ = String(data: servingSizeData, encoding:.utf8)!
           } catch {
               servingSize_ = ""
           }
        }
    }
}

extension FoodEntry : Identifiable {

}

extension FoodEntry: Comparable {
    public static func < (lhs: FoodEntry, rhs: FoodEntry) -> Bool {
        return lhs.index < rhs.index
    }
}
