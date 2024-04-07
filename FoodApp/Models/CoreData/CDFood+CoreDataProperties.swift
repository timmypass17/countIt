//
//  CDFood+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/17/24.
//
//

import Foundation
import CoreData


extension CDFood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFood> {
        return NSFetchRequest<CDFood>(entityName: "CDFood")
    }

    @NSManaged public var brandName_: String?
    @NSManaged public var dataType_: String?
    @NSManaged public var description_: String?
    @NSManaged public var fdcId: Int64
    @NSManaged public var foodNutrients_: String?
    @NSManaged public var foodPortions_: String?
    @NSManaged public var servingSize: Float
    @NSManaged public var servingSizeUnit_: String?
    @NSManaged public var foodEntries_: NSSet?
    @NSManaged public var updatedAt_: Date?

    var brandName: String {
        get { brandName_ ?? "" }
        set { brandName_ = newValue }
    }
    
    var dataType: String {
        get { dataType_ ?? "SR Legacy" }
        set { dataType_ = newValue }
    }
    
    var name: String {
        get { description_ ?? "" }
        set { description_ = newValue }
    }
    
    var foodNutrients: [FoodNutrient] {
        get { return CoreDataStack.decode(jsonString: foodNutrients_!) }
        set { foodNutrients_ = CoreDataStack.encode(value: newValue) }
    }
    
    var foodPortions: [FoodPortion] {
        get { return CoreDataStack.decode(jsonString: foodPortions_!) }
        set { foodPortions_ = CoreDataStack.encode(value: newValue) }
    }
    
    
    var servingSizeUnit: String {
        get { servingSizeUnit_ ?? "" }
        set { servingSizeUnit_ = newValue }
    }
    
    var updatedAt: Date {
        get { updatedAt_ ?? .now }
        set { updatedAt_ = newValue }
    }
}

// MARK: Generated accessors for foodEntries_
extension CDFood {

    @objc(addFoodEntries_Object:)
    @NSManaged public func addToFoodEntries_(_ value: FoodEntry)

    @objc(removeFoodEntries_Object:)
    @NSManaged public func removeFromFoodEntries_(_ value: FoodEntry)

    @objc(addFoodEntries_:)
    @NSManaged public func addToFoodEntries_(_ values: NSSet)

    @objc(removeFoodEntries_:)
    @NSManaged public func removeFromFoodEntries_(_ values: NSSet)

}

extension CDFood : Identifiable {

}

extension CDFood {
    static let sample = {
        let context = CoreDataStack.shared.context
        let banana = CDFood(context: context)
        banana.name = "Banana"
        banana.brandName = "USDA"
        banana.dataType = "SR Legacy"
        banana.fdcId = 1
        banana.foodNutrients_ = ""
        banana.foodPortions_ = ""
//        banana.foodNutrients = [FoodNutrient(nutrient: Nutrient(id: .calories, name: "Calories", unitName: "g"), amount: 105)]
//        banana.foodPortions = [FoodPortion(amount: 1, gramWeight: 126, modifier: "NLEA serving")]
        banana.servingSize = 1
        banana.servingSizeUnit = "g"
        return banana
    }()
    
    func convertToFDCFood() -> Food {
        let food = Food(
            fdcId: Int(fdcId),
            description: name,
            foodNutrients: foodNutrients,
            foodPortions: foodPortions,
            brandName: brandName,
            dataType: DataType(rawValue: dataType) ?? .srLegacy,
            servingSize: servingSize,
            servingSizeUnit: servingSizeUnit
        )
        return food
    }
}
