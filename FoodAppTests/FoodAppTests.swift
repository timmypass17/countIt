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
        let fdcFoods: [FDCFood] = try await foodService.getFoods(query: "banana", dataTypes: DataType.allCases)
         
        #expect(fdcFoods.count > 0)
        #expect(fdcFoods.contains { $0.fdcId == 2709224 })
        #expect(fdcFoods.contains { $0.description == "Banana, raw" })
    }
    
    @Test func getFoodsByNameFoundation() async throws {
        let fdcFoods: [FDCFood] = try await foodService.getFoods(query: "banana", dataTypes: [.foundation])
        
        #expect(fdcFoods.count > 0)
        #expect(fdcFoods.contains { $0.fdcId == 1105073 })
        #expect(fdcFoods.contains { $0.description == "Bananas, overripe, raw" })
    }
    
    @Test func getFoodsByFdcIds() async throws {
        let srLegacyFdcId = 173944
        let brandedFdcId = 2643119
        let foundationFdcId = 2262072
        
        let fdcFoods: [FDCFood] = try await foodService.getFoods(fdcIds: [srLegacyFdcId, brandedFdcId, foundationFdcId], dataTypes: DataType.allCases)
        
        #expect(fdcFoods.count > 0)
        #expect(fdcFoods.contains { $0.fdcId == 1105073 })
        #expect(fdcFoods.contains { $0.description == "Bananas, overripe, raw" })
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
}

