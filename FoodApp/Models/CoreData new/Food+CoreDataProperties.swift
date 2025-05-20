//
//  Food+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/15/25.
//
//

import Foundation
import CoreData


extension Food {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        return NSFetchRequest<Food>(entityName: "Food")
    }

//    @NSManaged public var amount: Double
    @NSManaged public var index: Int16
    @NSManaged public var modifier_: String?    // "large"
    @NSManaged public var numberOfServings: Int16   // 1x
    @NSManaged public var gramWeight: Double    // 126
    @NSManaged public var servingSizeUnit_: String? // g, everything is in grams? Only branded specifies "g" or "ml"
//    @NSManaged public var servingSize_: String? // 1
    @NSManaged public var foodInfo: FoodInfo?
    @NSManaged public var meal: Meal?

    func getNutrientAmount(_ nutrientID: NutrientId) -> Double {
        guard let amountPer100g = foodInfo?.nutrients[nutrientID]?.value else { return 0 }
        let totalGrams = Double(gramWeight) * Double(numberOfServings)
        let nutrientPerGram = amountPer100g / 100
        let totalNutrientAmount = nutrientPerGram * totalGrams
        
        return totalNutrientAmount
//        let nutrientAmount = (amountPer100g * Float(foodMeasurement.gramWeight)) / 100
//        return nutrientAmount * Float(quantity)
    }
}
