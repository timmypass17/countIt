//
//  UserProfile+CoreDataProperties.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/11/25.
//
//

import Foundation
import CoreData


extension UserProfile {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserProfile> {
        return NSFetchRequest<UserProfile>(entityName: "UserProfile")
    }
    
    @NSManaged public var weightGoal_: String?
    @NSManaged public var currentWeightKg_: NSNumber?   // all
    @NSManaged public var goalWeightKg_: NSNumber?
    @NSManaged public var weeklyGoal_: String?
    @NSManaged public var heightCm_: NSNumber?
    @NSManaged public var dateOfBirth_: Date?
    @NSManaged public var dailyCalories_: NSNumber? // Int32
    @NSManaged public var weightUnit_: String?
    @NSManaged public var heightUnit_: String?
    @NSManaged public var activityLevel_: String?
    @NSManaged public var sex_: String?
    @NSManaged public var proteinPercentage: Int16 // Int16
    @NSManaged public var carbsPercentage: Int16
    @NSManaged public var fatsPercentage: Int16
    @NSManaged public var carbsGrams_: NSNumber?
    @NSManaged public var proteinGrams_: NSNumber?
    @NSManaged public var fatsGrams_: NSNumber?
    @NSManaged public var userNutrientGoals_: NSSet?
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        activityLevel = .lightlyActive
        carbsPercentage = 40
        proteinPercentage = 30
        fatsPercentage = 30
        dateOfBirth = .now
        heightUnit = .feet
        weeklyGoal = .lose1_0
        weightGoal = .loseWeight
        weightUnit = .pounds
    }
    
    var currentWeightKg: Double? {
        get { currentWeightKg_?.doubleValue }
        set { currentWeightKg_ = newValue.map(NSNumber.init) }
    }
        
    var goalWeightKg: Double? {
        get { goalWeightKg_?.doubleValue }
        set { goalWeightKg_ = newValue.map(NSNumber.init) }
    }

    var heightCm: Int16? {
        get { heightCm_?.int16Value }
        set { heightCm_ = newValue.map(NSNumber.init) }
    }

    var dailyCalories: Int32? {
        get { dailyCalories_?.int32Value }
        set { dailyCalories_ = newValue.map(NSNumber.init) }
    }
    
    var carbsGrams: Int16? {
        get { carbsGrams_?.int16Value }
        set { carbsGrams_ = newValue.map(NSNumber.init) }
    }
    
    var proteinGrams: Int16? {
        get { proteinGrams_?.int16Value }
        set { proteinGrams_ = newValue.map(NSNumber.init) }
    }
    
    var fatsGrams: Int16? {
        get { fatsGrams_?.int16Value }
        set { fatsGrams_ = newValue.map(NSNumber.init) }
    }
    
    var weightGoal: WeightGoal {
        get {
            return WeightGoal(rawValue: weightGoal_ ?? "") ?? .loseWeight
        }
        set {
            weightGoal_ = newValue.rawValue
        }
    }
    
    var weeklyGoal: WeeklyWeightGoal {
        get {
            return WeeklyWeightGoal(rawValue: weeklyGoal_ ?? "") ?? .lose1_0
        }
        set {
            weeklyGoal_ = newValue.rawValue
        }
    }
    
    var dateOfBirth: Date {
        get {
            return dateOfBirth_ ?? .now
        }
        set {
            dateOfBirth_ = newValue
        }
    }
    
    var weightUnit: WeightUnit {
        get {
            return WeightUnit(rawValue: weightUnit_ ?? "") ?? .pounds
        }
        set {
            weightUnit_ = newValue.rawValue
        }
    }
    
    var heightUnit: HeightUnit {
        get {
            return HeightUnit(rawValue: heightUnit_ ?? "") ?? .feet
        }
        set {
            heightUnit_ = newValue.rawValue
        }
    }
    
    var activityLevel: ActivityLevel {
        get {
            return ActivityLevel(rawValue: activityLevel_ ?? "") ?? .lightlyActive
        }
        set {
            activityLevel_ = newValue.rawValue
        }
    }
    
    var sex: Sex? {
        get {
            return Sex(rawValue: sex_ ?? "")
        }
        set {
            sex_ = newValue?.rawValue
        }
    }
    
    var age: Int {
        let ageComponents = Calendar.current.dateComponents([.year], from: dateOfBirth, to: .now)
        return ageComponents.year ?? 0
    }
    
    var bmr: Double {
        guard let currentWeightKg, let heightCm else { return 0}
        let base = 10 * currentWeightKg + 6.25 * Double(heightCm) - 5 * Double(age)
        return sex == .male ? base + 5 : base - 161
    }

    var tdee: Double { bmr * activityLevel.activityFactor }
    
    var heightInFeetAndInches: (feet: Int, inches: Int)? {
        guard let heightCm else { return (0, 0)}
        let totalInches = Double(heightCm) / 2.54
        let feet = Int(totalInches / 12)
        let inches = Int(round(totalInches.truncatingRemainder(dividingBy: 12)))
        return (feet, inches)
    }
    
    func setHeight(feet: Int, inches: Int) {
        let totalInches = feet * 12 + inches
        let newHeightCm = Double(totalInches) * 2.54
        self.heightCm = Int16(round(newHeightCm))
    }
    
    func setCurrentWeight(weight: Double) {
        switch weightUnit {
        case .pounds:
            currentWeightKg = convertPoundsToKilograms(weight)
        case .kilograms:
            currentWeightKg = weight
        }
    }
    
    func setGoalWeight(weight: Double) {
        switch weightUnit {
        case .pounds:
            goalWeightKg = convertPoundsToKilograms(weight)
        case .kilograms:
            goalWeightKg = weight
        }
    }

    func recalculateDailyCalories() {
        switch weightUnit {
        case .pounds:
            let dailyAdj = weeklyGoal.poundsPerWeek * 3500 / 7
            dailyCalories = Int32(tdee + dailyAdj)
        case .kilograms:
            let dailyAdj = weeklyGoal.kilogramsPerWeek * 7700 / 7
            dailyCalories = Int32(tdee + dailyAdj)
        }
        
        print("recalculate calories: \(dailyCalories)")
    }

    func recalculateMacroSplitGrams() {
        print("recalculateMacroSplitGrams")
        func grams(from percentage: Int16, caloriesPerGram: Double) -> Int16 {
            guard let dailyCalories else { return 0 }
            let fraction = Double(percentage) / 100
            let cals = Double(dailyCalories) * fraction
            return Int16(round(cals / caloriesPerGram))
        }
        
        carbsGrams = grams(from: carbsPercentage, caloriesPerGram: 4)
        proteinGrams = grams(from: proteinPercentage, caloriesPerGram: 4)
        fatsGrams = grams(from: fatsPercentage, caloriesPerGram: 9)
    }
}

// MARK: Generated accessors for userNutrientGoals_
extension UserProfile {

    @objc(addUserNutrientGoals_Object:)
    @NSManaged public func addToUserNutrientGoals_(_ value: UserNutrientGoal)

    @objc(removeUserNutrientGoals_Object:)
    @NSManaged public func removeFromUserNutrientGoals_(_ value: UserNutrientGoal)

    @objc(addUserNutrientGoals_:)
    @NSManaged public func addToUserNutrientGoals_(_ values: NSSet)

    @objc(removeUserNutrientGoals_:)
    @NSManaged public func removeFromUserNutrientGoals_(_ values: NSSet)

}

extension UserProfile : Identifiable {

}

enum WeightGoal: String, CaseIterable {
    case loseWeight, gainWeight, maintainWeight
    
    var description: String {
        switch self {
        case .loseWeight:
            return "Lose Weight"
        case .gainWeight:
            return "Gain Weight"
        case .maintainWeight:
            return "Maintain Weight"
        }
    }
}

enum WeeklyWeightGoal: String, CaseIterable {
    case lose0_25, lose0_5, lose0_75, lose1_0, lose1_25, lose1_5, lose1_75, lose2_0
    case maintain
    case gain0_25, gain0_5, gain0_75, gain1_0, gain1_25, gain1_5, gain1_75, gain2_0
    
    var poundsPerWeek: Double {
        switch self {
        case .lose2_0: return -2.0
        case .lose1_75: return -1.75
        case .lose1_5: return -1.5
        case .lose1_25: return -1.25
        case .lose1_0: return -1.0
        case .lose0_75: return -0.75
        case .lose0_5: return -0.5
        case .lose0_25: return -0.25
        case .maintain: return 0.0
        case .gain0_25: return 0.25
        case .gain0_5: return 0.5
        case .gain0_75: return 0.75
        case .gain1_0: return 1.0
        case .gain1_25: return 1.25
        case .gain1_5: return 1.5
        case .gain1_75: return 1.75
        case .gain2_0: return 2.0
        }
    }
    
    var kilogramsPerWeek: Double {
        switch self {
        case .lose2_0: return -1.0
        case .lose1_75: return -0.8
        case .lose1_5: return -0.7
        case .lose1_25: return -0.6
        case .lose1_0: return -0.5
        case .lose0_75: return -0.35
        case .lose0_5: return -0.25
        case .lose0_25: return -0.1
        case .maintain: return 0.0
        case .gain0_25: return 0.1
        case .gain0_5: return 0.25
        case .gain0_75: return 0.35
        case .gain1_0: return 0.5
        case .gain1_25: return 0.6
        case .gain1_5: return 0.7
        case .gain1_75: return 0.8
        case .gain2_0: return 1.0
        }
    }
    
    func displayName(unit: WeightUnit) -> String {
        switch unit {
        case .pounds:
            let absValue = abs(poundsPerWeek).trimmed
            return poundsPerWeek == 0 ? "Maintenance" :
                poundsPerWeek < 0 ? "-\(absValue) lb/week" : "+\(absValue) lb/week"
        case .kilograms:
            let kg = kilogramsPerWeek
            let absValue = abs(kg).trimmed
            return kg == 0 ? "Maintenance" :
                kg < 0 ? "-\(absValue) kg/week" : "+\(absValue) kg/week"
        }
    }
    
    func description(unit: WeightUnit) -> String {
        func trimmed(_ value: Double) -> String {
            let formatted = String(format: "%.2f", value)
            return formatted.replacingOccurrences(of: #"(\.0+|(?<=\.\d)0)$"#, with: "", options: .regularExpression)
        }
        
        switch unit {
        case .pounds:
            let absValue = abs(poundsPerWeek).trimmed
            return poundsPerWeek == 0 ? "Maintain current weight" :
                poundsPerWeek < 0 ? "Lose \(absValue) lb per week" : "Gain \(absValue) lb per week"
        case .kilograms:
            let kg = kilogramsPerWeek
            let absValue = abs(kg).trimmed
            return kg == 0 ? "Maintain current weight" :
                kg < 0 ? "Lose \(absValue) kg per week" : "Gain \(absValue) kg per week"
        }
    }
    
    static let lossGoals: [WeeklyWeightGoal] = [
        .lose2_0, .lose1_75, .lose1_5, .lose1_25, .lose1_0, .lose0_75, .lose0_5, .lose0_25
    ]

    static let gainGoals: [WeeklyWeightGoal] = [
        .gain0_25, .gain0_5, .gain0_75, .gain1_0, .gain1_25, .gain1_5, .gain1_75, .gain2_0
    ]

    static let maintainGoal: [WeeklyWeightGoal] = [.maintain]
}

enum WeightUnit: String {
    case pounds
    case kilograms
    
    var shortSymbol: String {
        switch self {
        case .pounds:
            return "lb"
        case .kilograms:
            return "kg"
        }
    }
}


enum HeightUnit: String {
    case feet
    case cm
}


enum ActivityLevel: String, CaseIterable {
    case sedentary, lightlyActive, moderatelyActive, veryActive, extremelyActive

    var displayName: String {
        switch self {
        case .sedentary:
            return "Sedentary"
        case .lightlyActive:
            return "Lightly Active"
        case .moderatelyActive:
            return "Moderately Active"
        case .veryActive:
            return "Very Active"
        case .extremelyActive:
            return "Extremely Active"
        }
    }
    
    var description: String {
        switch self {
        case .sedentary:
            return "Little to no exercise"
        case .lightlyActive:
            return "Light exercise 1–3 days per week"
        case .moderatelyActive:
            return "Moderate exercise 3–5 days per week"
        case .veryActive:
            return "Hard exercise 6–7 days per week"
        case .extremelyActive:
            return "Very intense daily exercise or physical job"
        }
    }
    
    var activityFactor: Double {
        switch self {
        case .sedentary:
            return 1.2
        case .lightlyActive:
            return 1.375
        case .moderatelyActive:
            return 1.55
        case .veryActive:
            return 1.725
        case .extremelyActive:
            return 1.9
        }
    }
}

enum Sex: String, CaseIterable {
    case female, male
    
    var description: String {
        switch self {
        case .female:
            return "Female"
        case .male:
            return "Male"
        }
    }
}

//  Core Data does support truly optional numeric attributes—but you cannot simply declare a Swift Double? as @NSManaged. Under the hood, Core Data represents all numbers as NSNumber, so to get a nullable double you must:
//  2. Disable “Use Scalar Type”, use NSNumber? instead
//  3. Wrap the NSNumber? in a Swift-friendly Double? computed property.
//  4. Remove default value of 0
