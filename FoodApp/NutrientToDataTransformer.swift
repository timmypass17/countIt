//
//  NutrientToDataTransformer.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/16/24.
//

import Foundation

class NutrientToDataTransformer: NSSecureUnarchiveFromDataTransformer {
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override class func transformedValueClass() -> AnyClass {
        return FoodNutrient.self
    }
    
    override class var allowedTopLevelClasses: [AnyClass] {
        return [FoodNutrient.self]
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            fatalError("Wrong data type: value must be a Data object; received \(type(of: value))")
        }
        return super.transformedValue(data)
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let color = value as? FoodNutrient else {
            fatalError("Wrong data type: value must be a FoodNutrient object; received \(type(of: value))")
        }
        return super.reverseTransformedValue(color)
    }
}

extension NSValueTransformerName {
    static let nutrientToDataTransformer = NSValueTransformerName(rawValue: "NutrientToDataTransformer")
}
