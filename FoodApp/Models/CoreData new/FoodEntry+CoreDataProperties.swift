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
    @NSManaged public var gramWeight_: NSNumber?
    @NSManaged public var index: Int16
    @NSManaged public var modifier: String?
    @NSManaged public var portionId: Int32
    @NSManaged public var quantity: Int16
    @NSManaged public var foodInfo: FoodInfo?
    @NSManaged public var history: History?
    @NSManaged public var meal: Meal?
    @NSManaged public var isCustom: Bool    // negative fdcId also means "custom"
    @NSManaged public var isRecipe: Bool
    @NSManaged public var parent: FoodEntry?
    @NSManaged public var ingredients: NSSet?
    
    var amount: Double? {
        get { amount_?.doubleValue }
        set { amount_ = newValue.map(NSNumber.init) }
    }
    
    var gramWeight: Double? {
        get { gramWeight_?.doubleValue }
        set { gramWeight_ = newValue.map(NSNumber.init) }
    }
    
    func getNutrientAmount(_ nutrientID: NutrientId) -> Double {
        if isCustom {
            return foodInfo?.nutrients[nutrientID]?.value ?? 0
        } else {
            // Values stored per 100g (e.g. USDA API)
            guard let amountPer100g = foodInfo?.nutrients[nutrientID]?.value else { return 0 }
            let totalGrams = Double(gramWeight ?? 0) * Double(quantity)
            let nutrientPerGram = amountPer100g / 100
            let totalNutrientAmount = nutrientPerGram * totalGrams
            return totalNutrientAmount
        }
    }
    
    func convertToFDCFood() -> FoodItem? {
        guard let fdcId = foodInfo?.fdcId,
              let name = foodInfo?.name
        else {
            return nil
        }
        
              
        let food: CDFoodItem = CDFoodItem(
            fdcId: Int(fdcId),
            description: name,
            dataType: .foundation, // TODO: Don't think this matters
            foodNutrients: foodInfo?.convertToFoodNutrients() ?? [],
            foodPortions: foodInfo?.convertToFoodPortions() ?? [],
            brandName: foodInfo?.brandName_
        )

        return food
    }
    
    // "2 tbsp" - modifier
    // "2 tbsp (32 g)" - modifier + gram
    // "2 tbsp (32 g), USDA" - modifier + gram + brandName
    // "32 g, USDA" - gram + brandName
    // "32 g" - gram
    func description() -> String {
        let brandName = foodInfo?.brandName_
        let totalAmountText = ((amount ?? 1) * Double(quantity)).trimmed
        let totalGramWeight = (gramWeight ?? 0) * Double(quantity)

        // Case: No gram weight, user-generated entry
        if gramWeight == nil, let modifier {
            return ["\(totalAmountText) \(modifier)", brandName].compactMap { $0 }.joined(separator: ", ")
        }

        // Case: Has gram weight
        if let modifier {
            let modifierText = "\(totalAmountText) \(modifier) (\(totalGramWeight.trimmed) g)"
            return [modifierText, brandName].compactMap { $0 }.joined(separator: ", ")
        } else {
            return ["\(totalGramWeight.trimmed) g", brandName].compactMap { $0 }.joined(separator: ", ")
        }
    }

}

// MARK: Generated accessors for ingredients
extension FoodEntry {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: FoodEntry)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: FoodEntry)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}
