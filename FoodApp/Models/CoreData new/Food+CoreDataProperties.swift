//
//  Food+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/3/25.
//
//

import Foundation
import CoreData


extension Food {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        return NSFetchRequest<Food>(entityName: "Food")
    }

    @NSManaged public var index: Int16
    @NSManaged public var quantity: Int16   // 1x (actually amount e.g. 2x "1 banana")
    @NSManaged public var gramWeight: Double // 32g
    @NSManaged public var amount_: NSNumber?   // 1 -> part of modifier (e.g. 1 banana)
    @NSManaged public var modifier: String? // "banana"
    @NSManaged public var foodInfo: FoodInfo?
    @NSManaged public var meal: Meal?
    
    var amount: Double? {
        get { amount_?.doubleValue }
        set { amount_ = newValue.map(NSNumber.init) }
    }

    func getNutrientAmount(_ nutrientID: NutrientId) -> Double {
        guard let amountPer100g = foodInfo?.nutrients[nutrientID]?.value else { return 0 }
        let totalGrams = Double(gramWeight) * Double(quantity)
        let nutrientPerGram = amountPer100g / 100
        let totalNutrientAmount = nutrientPerGram * totalGrams
        
        return totalNutrientAmount
    }
}
