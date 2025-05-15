//
//  FoodAppTests.swift
//  FoodAppTests
//
//  Created by Timmy Nguyen on 5/2/25.
//

import Testing
@testable import BananaBite
import Foundation

struct FoodAppTests {
    
    let foodService: FoodServiceProtocol = FoodService()

    @Test func getFoodsByName() async throws {
        let response: FoodSearchResponse = try await foodService.getFoods(query: "banana", dataTypes: DataType.allCases, pageSize: 5, pageNumber: 1)
        let foods: [SearchResultFood] = response.foods
        #expect(foods.count > 0)
        #expect(foods.contains { $0.fdcId == 2709224 })
        #expect(foods.contains { $0.description == "Banana, raw" })
    }
    
//    @Test func getFoodsByNameFoundation() async throws {
//        let fdcFoods: [FDCFood] = try await foodService.getFoods(query: "banana", dataTypes: [.foundation])
//        
//        #expect(fdcFoods.count > 0)
//        #expect(fdcFoods.contains { $0.fdcId == 1105073 })
//        #expect(fdcFoods.contains { $0.description == "Bananas, overripe, raw" })
//    }
    
    @Test func getFoodsByFdcIds() async throws {
        let surveyFdcId = 2709225
        let brandedFdcId = 2643119
        let foundationFdcId = 2262072
        
        var surveyCount = 0
        var brandedCount = 0
        var foundationCount = 0
        
        let foodItems: [FoodItem] = try await foodService.getFoods(fdcIds: [surveyFdcId, brandedFdcId, foundationFdcId], dataTypes: DataType.allCases)
        
        for item in foodItems {
            switch item.dataType {
            case .foundation:
                foundationCount += 1
            case .branded:
                brandedCount += 1
            case .survey:
                surveyCount += 1
            }
        }
        
        #expect(foodItems.count == 3)
        #expect(surveyCount == 1)
        #expect(brandedCount == 1)
        #expect(foundationCount == 1)

    }
    
    @Test func getFoodByFdcId() async throws {
        let foundationFdcId = 2262072
        let foodItem = try await foodService.getFood(fdcId: foundationFdcId)
        
        #expect(foodItem.description == "Peanut butter, creamy")
    }
    
    @Test func decodeSurveyFoodItem() throws {
        let surveyFood = try JSONDecoder().decode(SurveyFoodItem.self, from: surveyFoodJSON)
        #expect(surveyFood.description == "Banana, baked")
    }
    
    @Test func decodeBrandedFoodItem() throws {
        let brandedFood = try JSONDecoder().decode(BrandedFoodItem.self, from: brandedFoodJSON)
        #expect(brandedFood.description == "PEANUT BUTTER CUPS, PEANUT BUTTER")
    }
    
    @Test func decodeFoundationFoodItem() throws {
        let foundationFood = try JSONDecoder().decode(FoundationFoodItem.self, from: foundationFoodJSON)
        #expect(foundationFood.description == "Peanut butter, creamy")
    }
    
    @Test func decodeFoodSearchResponse() throws {
        let foodSearchResponse = try JSONDecoder().decode(FoodSearchResponse.self, from: foodSearchResponseJSON)
        #expect(foodSearchResponse.foods.first?.description == "BANANA")
    }
}

