//
//  FoodAPIRequest.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/13/25.
//

import Foundation

struct FoodAPIRequest: APIRequest {
    var fdcId: Int
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: "https://api.nal.usda.gov/fdc/v1/food/\(fdcId)")!
        urlComponents.queryItems = [
            "api_key": apiKey
        ].map { URLQueryItem(name: $0.key, value: $0.value) }

        let request = URLRequest(url: urlComponents.url!)
        return request
    }
    
    func decodeResponse(data: Data) throws -> FoodItem {
        let decoder = JSONDecoder()
        let foodItem = try decoder.decode(AnyFoodItem.self, from: data)
        return foodItem
    }
}
