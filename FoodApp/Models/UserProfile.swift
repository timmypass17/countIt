//
//  UserProfile.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/10/25.
//

import Foundation

//class UserProfile {
//    var weightGoal: WeightGoal
//    var currentWeightKg: Double?
//    var goalWeightKg: Double?
//    var weeklyGoal: WeeklyWeightGoal
//    var activityLevel: ActivityLevel
//    var unitPreference: UnitPreference // break this
//    var heightCm: Int?
//    var dateOfBirth: Date
//    var dailyCalories: Int?
//    var macroSplit: MacroSplit  // break this into separate fields
//    var sex: Gender?
//    
//    init(weightGoal: WeightGoal, currentWeight: Double?, goalWeight: Double?, weeklyGoal: WeeklyWeightGoal, unitPreference: UnitPreference, activityLevel: ActivityLevel, heightCm: Int?, dateOfBirth: Date, dailyCalories: Int?, macroSplit: MacroSplit, sex: Gender?) {
//        self.weightGoal = weightGoal
//        self.currentWeightKg = currentWeight
//        self.goalWeightKg = goalWeight
//        self.weeklyGoal = weeklyGoal
//        self.unitPreference = unitPreference
//        self.activityLevel = activityLevel
//        self.heightCm = heightCm
//        self.dateOfBirth = dateOfBirth
//        self.dailyCalories = dailyCalories
//        self.macroSplit = macroSplit
//        self.sex = sex
//    }
//    
//    var heightInFeetAndInches: (feet: Int, inches: Int)? {
//        guard let cm = heightCm else { return nil }
//        let totalInches = Double(cm) / 2.54
//        let feet = Int(totalInches / 12)
//        let inches = Int(round(totalInches.truncatingRemainder(dividingBy: 12)))
//        return (feet, inches)
//    }
//    
//    func setHeight(feet: Int, inches: Int) {
//        let totalInches = feet * 12 + inches
//        let heightInCm = Double(totalInches) * 2.54
//        self.heightCm = Int(round(heightInCm))
//    }
//    
//    func setCurrentWeight(weight: Double) {
//        switch unitPreference.weightUnit {
//        case .pounds:
//            currentWeightKg = convertPoundsToKilograms(weight)
//        case .kilograms:
//            currentWeightKg = weight
//        }
//    }
//    
//    func setGoalWeight(weight: Double) {
//        switch unitPreference.weightUnit {
//        case .pounds:
//            goalWeightKg = convertPoundsToKilograms(weight)
//        case .kilograms:
//            goalWeightKg = weight
//        }
//    }
//    
//    var age: Int {
//        let ageComponents = Calendar.current.dateComponents([.year], from: dateOfBirth, to: .now)
//        return ageComponents.year ?? 0
//    }
//    
//    var bmr: Double {
//        guard let currentWeightKg, let heightCm else { return 0 }
//        let base = 10 * currentWeightKg + 6.25 * Double(heightCm) - 5 * Double(age)
//        return sex == .male ? base + 5 : base - 161
//    }
//
//    var tdee: Double { bmr * activityLevel.activityFactor }
//
//    func recalculateDailyCalories() {
//        switch unitPreference.weightUnit {
//        case .pounds:
//            let dailyAdj = weeklyGoal.poundsPerWeek * 3500 / 7
//            dailyCalories = Int(tdee + dailyAdj)
//        case .kilograms:
//            let dailyAdj = weeklyGoal.kilogramsPerWeek * 7700 / 7
//            dailyCalories = Int(tdee + dailyAdj)
//        }
//    }
//
//    func recalculateMacroSplitGrams() {
//        func grams(from percentage: Int, caloriesPerGram: Double) -> Int {
//            guard let dailyCalories else { return 0 }
//            let fraction = Double(percentage) / 100
//            let cals = Double(dailyCalories) * fraction
//            return Int(round(cals / caloriesPerGram))
//        }
//
//        macroSplit.carbsGrams = grams(from: macroSplit.carbsPercentage, caloriesPerGram: 4)
//        macroSplit.proteinGrams = grams(from: macroSplit.proteinPercentage, caloriesPerGram: 4)
//        macroSplit.fatsGrams = grams(from: macroSplit.fatsPercentage, caloriesPerGram: 9)
//        
//        print(macroSplit)
//    }
//}

//extension UserProfile: ReflectedStringConvertible { }

// https://medium.com/swift-programming/struct-style-printing-of-classes-in-swift-7ee34f1c975a
public protocol ReflectedStringConvertible : CustomStringConvertible { }

extension ReflectedStringConvertible {
    public var description: String {
        let mirror = Mirror(reflecting: self)
        
        var str = "\(mirror.subjectType)("
        var first = true
        for (label, value) in mirror.children {
            if let label = label {
                if first {
                    first = false
                } else {
                    str += ", "
                }
                str += label
                str += ": "
                str += "\(value)"
            }
        }
        str += ")"
        
        return str
    }
}

func convertPoundsToKilograms(_ pounds: Double) -> Double {
    return pounds * 0.453592
}

func convertKilogramsToPounds(_ kilograms: Double) -> Double {
    return kilograms / 0.453592
}

//struct UnitPreference {
//    var weightUnit: WeightUnit
//    var heightUnit: HeightUnit
//}
//
//struct MacroSplit {
//    var carbsPercentage: Int
//    var proteinPercentage: Int
//    var fatsPercentage: Int
//    
//    // User-customized grams
//    var carbsGrams: Int?
//    var proteinGrams: Int?
//    var fatsGrams: Int?
//}

//enum WeightGoal: CaseIterable {
//    case loseWeight, gainWeight, maintainWeight
//    
//    var description: String {
//        switch self {
//        case .loseWeight:
//            return "Lose Weight"
//        case .gainWeight:
//            return "Gain Weight"
//        case .maintainWeight:
//            return "Maintain Weight"
//        }
//    }
//}

//enum WeeklyWeightGoal: CaseIterable {
//    case lose0_25, lose0_5, lose0_75, lose1_0, lose1_25, lose1_5, lose1_75, lose2_0
//    case maintain
//    case gain0_25, gain0_5, gain0_75, gain1_0, gain1_25, gain1_5, gain1_75, gain2_0
//    
//    var poundsPerWeek: Double {
//        switch self {
//        case .lose2_0: return -2.0
//        case .lose1_75: return -1.75
//        case .lose1_5: return -1.5
//        case .lose1_25: return -1.25
//        case .lose1_0: return -1.0
//        case .lose0_75: return -0.75
//        case .lose0_5: return -0.5
//        case .lose0_25: return -0.25
//        case .maintain: return 0.0
//        case .gain0_25: return 0.25
//        case .gain0_5: return 0.5
//        case .gain0_75: return 0.75
//        case .gain1_0: return 1.0
//        case .gain1_25: return 1.25
//        case .gain1_5: return 1.5
//        case .gain1_75: return 1.75
//        case .gain2_0: return 2.0
//        }
//    }
//    
//    var kilogramsPerWeek: Double {
//        switch self {
//        case .lose2_0: return -1.0
//        case .lose1_75: return -0.8
//        case .lose1_5: return -0.7
//        case .lose1_25: return -0.6
//        case .lose1_0: return -0.5
//        case .lose0_75: return -0.35
//        case .lose0_5: return -0.25
//        case .lose0_25: return -0.1
//        case .maintain: return 0.0
//        case .gain0_25: return 0.1
//        case .gain0_5: return 0.25
//        case .gain0_75: return 0.35
//        case .gain1_0: return 0.5
//        case .gain1_25: return 0.6
//        case .gain1_5: return 0.7
//        case .gain1_75: return 0.8
//        case .gain2_0: return 1.0
//        }
//    }
//    
//    func displayName(unit: WeightUnit) -> String {
//        switch unit {
//        case .pounds:
//            let absValue = abs(poundsPerWeek).trimmed
//            return poundsPerWeek == 0 ? "Maintenance" :
//                poundsPerWeek < 0 ? "-\(absValue) lb/week" : "+\(absValue) lb/week"
//        case .kilograms:
//            let kg = kilogramsPerWeek
//            let absValue = abs(kg).trimmed
//            return kg == 0 ? "Maintenance" :
//                kg < 0 ? "-\(absValue) kg/week" : "+\(absValue) kg/week"
//        }
//    }
//    
//    func description(unit: WeightUnit) -> String {
//        func trimmed(_ value: Double) -> String {
//            let formatted = String(format: "%.2f", value)
//            return formatted.replacingOccurrences(of: #"(\.0+|(?<=\.\d)0)$"#, with: "", options: .regularExpression)
//        }
//        
//        switch unit {
//        case .pounds:
//            let absValue = abs(poundsPerWeek).trimmed
//            return poundsPerWeek == 0 ? "Maintain current weight" :
//                poundsPerWeek < 0 ? "Lose \(absValue) lb per week" : "Gain \(absValue) lb per week"
//        case .kilograms:
//            let kg = kilogramsPerWeek
//            let absValue = abs(kg).trimmed
//            return kg == 0 ? "Maintain current weight" :
//                kg < 0 ? "Lose \(absValue) kg per week" : "Gain \(absValue) kg per week"
//        }
//    }
//    
//    static let lossGoals: [WeeklyWeightGoal] = [
//        .lose2_0, .lose1_75, .lose1_5, .lose1_25, .lose1_0, .lose0_75, .lose0_5, .lose0_25
//    ]
//
//    static let gainGoals: [WeeklyWeightGoal] = [
//        .gain0_25, .gain0_5, .gain0_75, .gain1_0, .gain1_25, .gain1_5, .gain1_75, .gain2_0
//    ]
//
//    static let maintainGoal: [WeeklyWeightGoal] = [.maintain]
//}

extension Double {
    var trimmed: String {
        let formatted = String(format: "%.2f", self)
        return formatted.replacingOccurrences(of: #"(\.0+|(?<=\.\d)0)$"#, with: "", options: .regularExpression)
    }
    
}

//enum WeightUnit {
//    case pounds
//    case kilograms
//    
//    var shortSymbol: String {
//        switch self {
//        case .pounds:
//            return "lb"
//        case .kilograms:
//            return "kg"
//        }
//    }
//}
//
//enum HeightUnit: String {
//    case feet
//    case cm
//}


//enum Sex: String, CaseIterable {
//    case female, male
//    
//    var description: String {
//        switch self {
//        case .female:
//            return "Female"
//        case .male:
//            return "Male"
//        }
//    }
//}
//
//enum ActivityLevel: String, CaseIterable {
//    case sedentary, lightlyActive, moderatelyActive, veryActive, extremelyActive
//
//    var displayName: String {
//        switch self {
//        case .sedentary:
//            return "Sedentary"
//        case .lightlyActive:
//            return "Lightly Active"
//        case .moderatelyActive:
//            return "Moderately Active"
//        case .veryActive:
//            return "Very Active"
//        case .extremelyActive:
//            return "Extremely Active"
//        }
//    }
//    
//    var description: String {
//        switch self {
//        case .sedentary:
//            return "Little to no exercise"
//        case .lightlyActive:
//            return "Light exercise 1–3 days per week"
//        case .moderatelyActive:
//            return "Moderate exercise 3–5 days per week"
//        case .veryActive:
//            return "Hard exercise 6–7 days per week"
//        case .extremelyActive:
//            return "Very intense daily exercise or physical job"
//        }
//    }
//    
//    var activityFactor: Double {
//        switch self {
//        case .sedentary:
//            return 1.2
//        case .lightlyActive:
//            return 1.375
//        case .moderatelyActive:
//            return 1.55
//        case .veryActive:
//            return 1.725
//        case .extremelyActive:
//            return 1.9
//        }
//    }
//}
