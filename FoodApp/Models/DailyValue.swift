//
//  DailyValue.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/7/24.
//

import Foundation

struct UserDailyValues: Codable {
    var calories: UserNutrientGoal    // Carbohydrate, by difference, g 1005
    var carbs: UserNutrientGoal    // Carbohydrate, by difference, g 1005
    var protein: UserNutrientGoal         // Protein, g, 1003
    var fat: UserNutrientGoal             // Total lipid (fat), g, 1004
    var saturatedFat: UserNutrientGoal
    var transFat: UserNutrientGoal
    var cholesterol: UserNutrientGoal
    var sodium: UserNutrientGoal
    var fiber: UserNutrientGoal
    var totalSugar: UserNutrientGoal
//    var addedSugar: UserNutrientGoal
    
    var vitaminA: UserNutrientGoal
    var vitaminC: UserNutrientGoal
    var vitaminD: UserNutrientGoal
    var vitaminB6: UserNutrientGoal
    var vitaminE: UserNutrientGoal
    var vitaminK: UserNutrientGoal
    var thiamin: UserNutrientGoal
    var vitaminB12: UserNutrientGoal
    var riboflavin: UserNutrientGoal
    var folate: UserNutrientGoal
    var niacin: UserNutrientGoal
    var choline: UserNutrientGoal
    var pantothenicAcid: UserNutrientGoal
    var biotin: UserNutrientGoal
    
    var calcium: UserNutrientGoal
    var chlorine: UserNutrientGoal
    var chromium: UserNutrientGoal
    var copper: UserNutrientGoal
    var iodine: UserNutrientGoal
    var iron: UserNutrientGoal
    var magnesium: UserNutrientGoal
    var manganese: UserNutrientGoal
    var molybdenum: UserNutrientGoal
    var phosphorus: UserNutrientGoal
    var potassium: UserNutrientGoal
    var selenium: UserNutrientGoal
    var zinc: UserNutrientGoal
    
    
    func getUserNutrientGoal(for nutrient: FoodNutrient) -> UserNutrientGoal? {
        switch nutrient.nutrient.id {
        case .calories:
            return calories
        case .totalFat:
            return fat
        case .saturatedFat:
            return saturatedFat
        case .transFat:
            return transFat
        case .cholesterol:
            return cholesterol
        case .carbs:
            return carbs
        case .sodium:
            return sodium
        case .fiber:
            return fiber
        case .totalSugar:
            return totalSugar
//        case .addedSugar:
//            return addedSugar
        case .protein:
            return protein
        case .vitaminA:
            return vitaminA
        case .vitaminC:
            return vitaminC
        case .vitaminD:
            return vitaminD
        case .vitaminB6:
            return vitaminB6
        case .vitaminE:
            return vitaminE
        case .vitaminK:
            return vitaminK
        case .thiamin:
            return thiamin
        case .vitaminB12:
            return vitaminB12
        case .riboflavin:
            return riboflavin
        case .folate:
            return folate
        case .niacin:
            return niacin
        case .choline:
            return choline
        case .pantothenicAcid:
            return pantothenicAcid
        case .biotin:
            return biotin
        case .calcium:
            return calcium
        case .chlorine:
            return chlorine
        case .chromium:
            return chromium
        case .copper:
            return copper
        case .iodine:
            return iodine
        case .iron:
            return iron
        case .magnesium:
            return magnesium
        case .manganese:
            return manganese
        case .molybdenum:
            return molybdenum
        case .phosphorus:
            return phosphorus
        case .potassium:
            return potassium
        case .selenium:
            return selenium
        case .zinc:
            return zinc
        default:
            return nil
        }
    }
}

struct UserNutrientGoal: Codable {
    var nutrient: NutrientID
    var goal: Float
}

extension UserDailyValues {
    static let default2000 = UserDailyValues(
        calories: UserNutrientGoal(nutrient: .calories, goal: 2000),
        carbs: UserNutrientGoal(nutrient: .carbs, goal: 275),
        protein: UserNutrientGoal(nutrient: .protein, goal: 50),
        fat: UserNutrientGoal(nutrient: .totalFat, goal: 78),
        saturatedFat: UserNutrientGoal(nutrient: .saturatedFat, goal: 20),
        transFat: UserNutrientGoal(nutrient: .transFat, goal: 2),
        cholesterol: UserNutrientGoal(nutrient: .cholesterol, goal: 300),
        sodium: UserNutrientGoal(nutrient: .sodium, goal: 2300),
        fiber: UserNutrientGoal(nutrient: .fiber, goal: 28),
        totalSugar: UserNutrientGoal(nutrient: .totalSugar, goal: 50),
//        addedSugar: UserNutrientGoal(nutrient: .addedSugar, goal: 50), // maybe remove this
        vitaminA: UserNutrientGoal(nutrient: .vitaminA, goal: 900),
        vitaminC: UserNutrientGoal(nutrient: .vitaminC, goal: 90),
        vitaminD: UserNutrientGoal(nutrient: .vitaminD, goal: 20),
        vitaminB6: UserNutrientGoal(nutrient: .vitaminB6, goal: 2),
        vitaminE: UserNutrientGoal(nutrient: .vitaminE, goal: 15),
        vitaminK: UserNutrientGoal(nutrient: .vitaminK, goal: 120),
        thiamin: UserNutrientGoal(nutrient: .thiamin, goal: 1.2),
        vitaminB12: UserNutrientGoal(nutrient: .vitaminB12, goal: 2.4),
        riboflavin: UserNutrientGoal(nutrient: .riboflavin, goal: 1.3),
        folate: UserNutrientGoal(nutrient: .folate, goal: 400),
        niacin: UserNutrientGoal(nutrient: .niacin, goal: 16),
        choline: UserNutrientGoal(nutrient: .choline, goal: 550),
        pantothenicAcid: UserNutrientGoal(nutrient: .pantothenicAcid, goal: 5),
        biotin: UserNutrientGoal(nutrient: .biotin, goal: 30),
        calcium: UserNutrientGoal(nutrient: .calcium, goal: 1300),
        chlorine: UserNutrientGoal(nutrient: .chlorine, goal: 2300),
        chromium: UserNutrientGoal(nutrient: .chromium, goal: 35),
        copper: UserNutrientGoal(nutrient: .copper, goal: 0.9),
        iodine: UserNutrientGoal(nutrient: .iodine, goal: 150),
        iron: UserNutrientGoal(nutrient: .iron, goal: 18),
        magnesium: UserNutrientGoal(nutrient: .magnesium, goal: 420),
        manganese: UserNutrientGoal(nutrient: .manganese, goal: 2.3),
        molybdenum: UserNutrientGoal(nutrient: .molybdenum, goal: 45),
        phosphorus: UserNutrientGoal(nutrient: .phosphorus, goal: 1250),
        potassium: UserNutrientGoal(nutrient: .potassium, goal: 4700),
        selenium: UserNutrientGoal(nutrient: .selenium, goal: 55),
        zinc: UserNutrientGoal(nutrient: .zinc, goal: 11)
    )
}

//struct DailyNutrients {
//    var carbohydrate: Nutrient    // Carbohydrate, by difference, 1005
//    var fiber: Nutrient           // Fiber, total dietary, 1079
//    var totalSugar: Nutrient      // Total Sugars, 2000
//    var protein: Nutrient         // Protein, 1003
//    var fat: Nutrient             // Total lipid (fat), 1004
//    var saturatedFat: Nutrient    // Fatty acids, total saturated, 1258
//    var transFat: Nutrient        // Fatty acids, total trans, 1257
//    var cholesterol: Nutrient     // Cholesterol, 1253
//}

//// μg == microgram
//struct DailyVitamins {
//    var vitaminA: Nutrient        // Vitamin A, RAE, 1106, μg (note: there is Vitamin A, IU. I think its just diff units)
//    var vitaminC: Nutrient        // Vitamin C, total ascorbic acid, 1162, mg
//    var vitamindD: Nutrient       // Vitamin D (D2 + D3), 1114, μg
//    var vitaminB6: Nutrient       // Vitamin B-6, 1175
//    var vitaminE: Nutrient        // Vitamin E (alpha-tocopherol), 1109, mg
//    var vitaminK: Nutrient        // Vitamin K
//    var thiamin: Nutrient         // Thiamin
//    var vitaminB12: Nutrient      //
//    var riboflavin: Nutrient
//    var folate: Nutrient
//    var niacin: Nutrient
//    var choline: Nutrient
//    var pantothenicAcid: Nutrient
//    var biotin: Nutrient
//    var carotenoids: Nutrient
//}

//struct DailyMinerals {
//    var calcium: Nutrient
//    var chloride: Nutrient
//    var chromium: Nutrient
//    var copper: Nutrient
//    var fluoride: Nutrient
//    var iodine: Nutrient
//    var iron: Nutrient
//    var magnesium: Nutrient
//    var maganese: Nutrient
//    var molybdenum: Nutrient
//    var phosphorus: Nutrient
//    var potassium: Nutrient     // Potassium, K, 1092
//    var selenium: Nutrient
//    var sodium: Nutrient        // Sodium, Na, 1093
//    var zinc: Nutrient
//}

//extension DailyValues {
//    static let sample2000 = DailyValues(
//        nutrients: DailyNutrients(
//            carbohydrate: Nutrient,
//            fiber: <#T##Nutrient#>,
//            totalSugar: <#T##Nutrient#>,
//            protein: <#T##Nutrient#>,
//            fat: <#T##Nutrient#>,
//            saturatedFat: <#T##Nutrient#>,
//            transFat: <#T##Nutrient#>,
//            cholesterol: <#T##Nutrient#>),
//        vitaminsAndCholine: <#T##DailyVitamins#>,
//        minerals: <#T##DailyMinerals#>)
//}
