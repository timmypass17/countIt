//
//  FoodListAPIRequest.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/4/25.
//

import Foundation

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
