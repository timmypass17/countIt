//
//  UserWeight+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/13/25.
//
//

import Foundation
import CoreData


extension UserWeight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserWeight> {
        return NSFetchRequest<UserWeight>(entityName: "UserWeight")
    }

    @NSManaged public var date_: Date?
    @NSManaged public var weightInKg_: NSNumber?
    
    var weightInKg: Double? {
        get {
            return weightInKg_?.doubleValue
        }
        set {
            weightInKg_ = newValue.map(NSNumber.init)
        }
    }
    
    func getWeight(_ weightUnit: WeightUnit) -> Double? {
        guard let weightInKg else { return nil }
        switch weightUnit {
        case .pounds:
            return convertKilogramsToPounds(weightInKg)
        case .kilograms:
            return weightInKg
        }
    }
}

extension UserWeight : Identifiable {

}
