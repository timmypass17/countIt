//
//  APIService.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/2/24.
//

import Foundation
import UIKit
import CoreData

let apiKey = "tbRKfhWJR3T2FFbwOiEShaXHrTljAGkVa232iZPx"

struct FoodsSearchAPIRequest: APIRequest {
    let query: String
    var dataTypes: [DataType] = DataType.allCases
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: "https://api.nal.usda.gov/fdc/v1/foods/search")!

        urlComponents.queryItems = [
            "query": query,
            "requireAllWords": "true",
            "dataType": dataTypes.map { $0.rawValue }.joined(separator: ","),
            "pageSize": "10",
            "api_key": apiKey
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        let request = URLRequest(url: urlComponents.url!)
        return request
    }
    
    func decodeResponse(data: Data) throws -> FoodSearchResponse {
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(FoodSearchResponse.self, from: data)
        return searchResponse
    }
}

struct FoodListAPIRequest: APIRequest {
    var fdcIds: [Int]
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: "https://api.nal.usda.gov/fdc/v1/foods")!
        urlComponents.queryItems = [
            "fdcIds": fdcIds.map { String($0) }.joined(separator: ","),
            "api_key": apiKey
        ].map { URLQueryItem(name: $0.key, value: $0.value) }

        let request = URLRequest(url: urlComponents.url!)
        return request
    }
    
    func decodeResponse(data: Data) throws -> [FoodItem] {
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode([AnyFoodItem].self, from: data)
        return searchResponse
    }
}
