//
//  FoodEntry+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/15/25.
//
//

import Foundation
import CoreData


extension FoodEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodEntry> {
        return NSFetchRequest<FoodEntry>(entityName: "FoodEntry")
    }

    @NSManaged public var amount_: NSNumber?    // TODO: Part of modifier? (e.g. "1 banana", 1 is part of modifier, not quantity)
    @NSManaged public var gramWeight: Double
    @NSManaged public var index: Int16
    @NSManaged public var modifier: String?
    @NSManaged public var portionId: Int32
    @NSManaged public var quantity: Int16
    @NSManaged public var foodInfo: FoodInfo?
    @NSManaged public var history: History?
    @NSManaged public var meal: Meal?

    var amount: Double? {
        get { amount_?.doubleValue }
        set { amount_ = newValue.map(NSNumber.init) }
    }
    
    func getNutrientAmount(_ nutrientID: NutrientId) -> Double {
        guard let amountPer100g = foodInfo?.nutrients[nutrientID]?.value else { return 0 }
        let totalGrams = Double(gramWeight ?? 0) * Double(quantity)
        let nutrientPerGram = amountPer100g / 100
        let totalNutrientAmount = nutrientPerGram * totalGrams
        
        return totalNutrientAmount
    }
    
    func convertToFDCFood() -> FoodItem? {
        guard let fdcId = foodInfo?.fdcId,
              let name = foodInfo?.name,
              let brandName = foodInfo?.brandName_
        else {
            return nil
        }
        
              
        let food: CDFoodItem = CDFoodItem(
            fdcId: Int(fdcId),
            description: name,
            dataType: .foundation, // TODO: Don't think this matters
            foodNutrients: foodInfo?.convertToFoodNutrients() ?? [],
            foodPortions: foodInfo?.convertToFoodPortions() ?? [],
            brandName: brandName
        )

        return food
    }
}
