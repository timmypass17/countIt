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

    @NSManaged public var id: Int32
    @NSManaged public var goalValue: Double
    @NSManaged public var userProfile: UserProfile?

}

extension UserNutrientGoal : Identifiable {

}
