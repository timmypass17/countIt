//
//  APIRequest.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/2/24.
//

import Foundation

import Foundation
import CoreData
import UIKit

let apiKey = "tbRKfhWJR3T2FFbwOiEShaXHrTljAGkVa232iZPx"

protocol APIRequest {
    associatedtype Response
    
    var urlRequest: URLRequest { get }
    
    func decodeResponse(data: Data) throws -> Response
}

enum APIRequestError: Error {
    case itemNotFound
}

// Generic utility func for sending network requests
func sendRequest<Request: APIRequest>(_ request: Request) async throws -> Request.Response {
    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .returnCacheDataElseLoad

    let session = URLSession(configuration: config)
    let (data, response) = try await session.data(for: request.urlRequest)
    
    data.prettyPrintedJSONString()
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
        throw APIRequestError.itemNotFound
    }
    
    let decodedResponse = try request.decodeResponse(data: data)
    return(decodedResponse)
}

extension Data {
    func prettyPrintedJSONString() {
        guard
            let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
            let prettyJSONString = String(data: jsonData, encoding: .utf8) else {
                print("Failed to read JSON Object.")
                return
        }
        print(prettyJSONString)
    }
}
