//
//  DailyValue.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/7/24.
//

import Foundation


struct UserNutrientGoal: Codable {
    var nutrient: NutrientID
    var goal: Float
}

struct UserDailyValues: Codable {
//    var calories: UserNutrientGoal    // Carbohydrate, by difference, g 1005
//    var carbs: UserNutrientGoal    // Carbohydrate, by difference, g 1005
//    var protein: UserNutrientGoal         // Protein, g, 1003
//    var fat: UserNutrientGoal             // Total lipid (fat), g, 1004
//    var saturatedFat: UserNutrientGoal
//    var transFat: UserNutrientGoal
//    var cholesterol: UserNutrientGoal
//    var sodium: UserNutrientGoal
//    var fiber: UserNutrientGoal
//    var totalSugar: UserNutrientGoal
////    var addedSugar: UserNutrientGoal
//    
//    var vitaminA: UserNutrientGoal
//    var vitaminC: UserNutrientGoal
//    var vitaminD: UserNutrientGoal
//    var vitaminB6: UserNutrientGoal
//    var vitaminE: UserNutrientGoal
//    var vitaminK: UserNutrientGoal
//    var thiamin: UserNutrientGoal
//    var vitaminB12: UserNutrientGoal
//    var riboflavin: UserNutrientGoal
//    var folate: UserNutrientGoal
//    var niacin: UserNutrientGoal
//    var choline: UserNutrientGoal
//    var pantothenicAcid: UserNutrientGoal
//    var biotin: UserNutrientGoal
//    
//    var calcium: UserNutrientGoal
//    var chlorine: UserNutrientGoal
//    var chromium: UserNutrientGoal
//    var copper: UserNutrientGoal
//    var iodine: UserNutrientGoal
//    var iron: UserNutrientGoal
//    var magnesium: UserNutrientGoal
//    var manganese: UserNutrientGoal
//    var molybdenum: UserNutrientGoal
//    var phosphorus: UserNutrientGoal
//    var potassium: UserNutrientGoal
//    var selenium: UserNutrientGoal
//    var zinc: UserNutrientGoal
}

extension UserDailyValues {
    static let default2000: [NutrientID: Float] = [
        .calories: 2000,
        .carbs: 275,
        .protein: 50,
        .totalFat: 78,
        .saturatedFat: 20,
        .transFat: 2,
        .cholesterol: 300,
        .sodium: 2300,
        .fiber: 28,
        .totalSugar: 50,
        .addedSugar: 24,
        .vitaminA: 900,
        .vitaminC: 90,
        .vitaminD: 20,
        .vitaminB6: 2,
        .vitaminE: 15,
        .vitaminK: 120,
        .thiamin: 1.2,
        .vitaminB12: 2.4,
        .riboflavin: 1.3,
        .folate: 400,
        .niacin: 16,
        .choline: 550,
        .pantothenicAcid: 5,
        .biotin: 30,
        .calcium: 1300,
        .chlorine: 2300,
        .chromium: 35,
        .copper: 0.9,
        .iodine: 150,
        .iron: 18,
        .magnesium: 420,
        .manganese: 2.3,
        .molybdenum: 45,
        .phosphorus: 1250,
        .potassium: 4700,
        .selenium: 55,
        .zinc: 11
    ]
}
