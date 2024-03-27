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

struct AbridgedSearchAPIRequest: APIRequest {
    let query: String
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: "https://api.nal.usda.gov/fdc/v1/foods/search")!
        urlComponents.queryItems = [
            "query": "\(query)",
            "dataType": DataType.allCases.map { $0.rawValue }.joined(separator: ","),
            "pageSize": "10",
            "api_key": apiKey
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        let request = URLRequest(url: urlComponents.url!)
        return request
    }
    
    func decodeResponse(data: Data) throws -> AbridgedSearchResponse {
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(AbridgedSearchResponse.self, from: data)
        return searchResponse
    }
}

struct FoodListAPIRequest: APIRequest {
    var foodIDs: [Int]
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: "https://api.nal.usda.gov/fdc/v1/foods")!
        urlComponents.queryItems = [
            "fdcIds": foodIDs.map { String($0) }.joined(separator: ","),
            "api_key": apiKey
        ].map { URLQueryItem(name: $0.key, value: $0.value) }

        let request = URLRequest(url: urlComponents.url!)
        return request
    }
    
    func decodeResponse(data: Data) throws -> [Food] {
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode([Food].self, from: data)
        return searchResponse
    }
}
