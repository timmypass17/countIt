//
//  FoodSearchResponse.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/2/24.
//

import Foundation

struct SearchResponse: Codable {
    var foodSearchCriteria: SearchCriteria
    var foods: [FoodSearchResults]
}

struct SearchCriteria: Codable {
    var query: String
    var pageNumber: Int // Page number to retrieve. The offset into the overall result set is expressed as (pageNumber * pageSize)
    var numberOfResultsPerPage: Int
    var pageSize: Int // Maximum number of results to return for the current page
}
