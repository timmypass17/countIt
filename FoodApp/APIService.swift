//
//  APIService.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/2/24.
//

import Foundation

let apiKey = "tbRKfhWJR3T2FFbwOiEShaXHrTljAGkVa232iZPx"

struct SearchAPIRequest: APIRequest {
    let query: String
    
    enum DataType: String {
        case branded = "Branded"
        case foundation = "Foundation"
        case survey = "Survey (FNDDS)"
        case srLegacy = "SR Legacy"
    }
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: "https://api.nal.usda.gov/fdc/v1/foods/search")!
        urlComponents.queryItems = [
            "query": query,
//            "dataType": DataType.srLegacy.rawValue,
            "pageSize": "10",
            "api_key": apiKey
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        let request = URLRequest(url: urlComponents.url!)
        return request
    }
    
    func decodeResponse(data: Data) throws -> SearchResponse {
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(SearchResponse.self, from: data)
        return searchResponse
    }
}

struct FoodAPIRequest: APIRequest {
    let id: Int
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: "https://api.nal.usda.gov/fdc/v1/food/\(id)")!
        urlComponents.queryItems = [
            "api_key": apiKey
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        let request = URLRequest(url: urlComponents.url!)
        return request
    }
    
    func decodeResponse(data: Data) throws -> Food {
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(Food.self, from: data)
        return searchResponse
    }
}
