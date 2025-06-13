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
    @NSManaged public var weightInKg: Double

}

extension UserWeight : Identifiable {

}
