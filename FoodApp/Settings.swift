//
//  Settings.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/8/24.
//

import Foundation


struct Settings {
    static var shared = Settings()
    private let defaults = UserDefaults.standard
    
    private func archiveJSON<T: Encodable>(value: T, key: String) {
        let data = try! JSONEncoder().encode(value)
        let string = String(data: data, encoding: .utf8)
        defaults.set(string, forKey: key)
    }
    
    private func unarchiveJSON<T: Decodable>(key: String) -> T? {
        guard let string = defaults.string(forKey: key),
              let data = string.data(using: .utf8) else {
            return nil
        }
        
        return try! JSONDecoder().decode(T.self, from: data)
    }
    
    var userDailyValues: [NutrientID: Float] {
        get {
            return unarchiveJSON(key: "UserDailyValues") ?? UserDailyValues.default2000
        }
        set {
            archiveJSON(value: newValue, key: "UserDailyValues")
        }
    }
}
