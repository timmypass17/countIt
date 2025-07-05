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
    @NSManaged public var ingredients_: NSSet?
    
    var ingredients: [FoodEntry] {
        get { (ingredients_?.allObjects as? [FoodEntry] ?? []).sorted { $0.index < $1.index } }
        set { ingredients_ = NSSet(array: newValue) }
    }
    
    var amount: Double? {
        get { amount_?.doubleValue }
        set { amount_ = newValue.map(NSNumber.init) }
    }
    
    var gramWeight: Double? {
        get { gramWeight_?.doubleValue }
        set { gramWeight_ = newValue.map(NSNumber.init) }
    }
    
    // Ingredients can only be other FoodEntry, not recipe
    func getNutrientAmount(_ nutrientID: NutrientId, quantity: Int = 1) -> Double {
        if isCustom {
            print("timmy isCustom: \(foodInfo?.name)")
            if isRecipe {
                print("timmy isRecipe \(foodInfo?.name)")
                var ingredientAmount = 0.0
                for ingredient in ingredients {
                    ingredientAmount += ingredient.getNutrientAmount(nutrientID, quantity: Int(ingredient.quantity))
                    print("timmy ingredient: \(ingredient.foodInfo?.name) \(ingredient.quantity) \(ingredientAmount) cal")
                }
                return (ingredientAmount) * Double(quantity)
            } else {
                print("timmy isCustom: \(foodInfo?.name)")
                let ingredientAmount = (foodInfo?.nutrients[nutrientID]?.value ?? 0) * Double(quantity)
                return ingredientAmount
            }
        } else {
            print("timmy fdc: \(foodInfo?.name)")
            guard let amountPer100g = foodInfo?.nutrients[nutrientID]?.value else { return 0 }
            return (amountPer100g / 100) * Double(gramWeight ?? 0) * Double(quantity)
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
            dataType: .foundation,
            foodNutrients: foodInfo?.convertToFoodNutrients() ?? [],
            foodPortions: foodInfo?.convertToFoodPortions() ?? [],
            brandName: foodInfo?.brandName_,
            ingredients: ingredients.compactMap { $0.convertToFDCFood() as? CDFoodItem },
            selectedFoodPortion: FoodPortion(id: Int(portionId), amount: amount, gramWeight: gramWeight, modifier: modifier),
            quantity: Int(quantity)
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

    @objc(addIngredients_Object:)
    @NSManaged public func addToIngredients_(_ value: FoodEntry)

    @objc(removeIngredients_Object:)
    @NSManaged public func removeFromIngredients_(_ value: FoodEntry)

    @objc(addIngredients_:)
    @NSManaged public func addToIngredients_(_ values: NSSet)

    @objc(removeIngredients_:)
    @NSManaged public func removeFromIngredients_(_ values: NSSet)

}
