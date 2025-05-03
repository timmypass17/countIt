//
//  FoodAppTests.swift
//  FoodAppTests
//
//  Created by Timmy Nguyen on 5/2/25.
//

import Testing
@testable import BananaBite

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
    

//    @Test func testRecipeDecoding() throws {
//        let recipe = try JSONDecoder().decode(Recipe.self, from: recipeJSON)
//        
//        #expect(recipe.cuisine == "Malaysian")
//        #expect(recipe.name == "Apam Balik")
//        #expect(recipe.photoUrlSmall == "https://example.com/apam.jpg")
//        #expect(recipe.sourceUrl == "https://example.com/recipe")
//        #expect(recipe.id == "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
//    }
//    
//    @Test func testRecipeResponseDecoding() throws {
//        let response = try JSONDecoder().decode(RecipesResponse.self, from: recipeResponseJSON)
//        
//        #expect(response.recipes.count > 0)
//    }
}

