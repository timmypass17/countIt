//
//  FoodsSearchAPIRequest.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/4/25.
//

import Foundation

struct FoodsSearchAPIRequest: APIRequest {
    let query: String
    var dataTypes: [DataType] = DataType.allCases
    var pageSize: Int
    var pageNumber: Int
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: "https://api.nal.usda.gov/fdc/v1/foods/search")!

        urlComponents.queryItems = [
            "query": query,
            "requireAllWords": "true",
            "dataType": dataTypes.map { $0.rawValue }.joined(separator: ","),
            "pageSize": "\(pageSize)",
            "pageNumber": "\(pageNumber)",
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
