//
//  UserMealType+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/7/25.
//
//

import Foundation
import CoreData


extension UserMealType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserMealType> {
        return NSFetchRequest<UserMealType>(entityName: "UserMealType")
    }

    @NSManaged public var index: Int16
    @NSManaged public var name_: String?
    @NSManaged public var userProfile: UserProfile?

    var name: String {
        get {
            return name_ ?? ""
        }
        
        set {
            name_ = newValue
        }
    }
}
