//
//  Utility.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/18/25.
//

import Foundation

extension String {
    var firstUppercased: String {
        guard let first else { return "" }
        return first.uppercased() + dropFirst().lowercased()
    }
}
