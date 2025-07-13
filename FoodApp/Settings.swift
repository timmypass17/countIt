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
    private init() {}

    private func save<T: Encodable>(_ value: T, for key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            defaults.set(data, forKey: key)
        } catch {
            print("⚠️ Settings save failed:", error)
        }
    }
    
    private func load<T: Decodable>(_ key: String, default defaultValue: T) -> T {
        guard
            let data = defaults.data(forKey: key),
            let value = try? JSONDecoder().decode(T.self, from: data)
        else {
            return defaultValue
        }
        return value
    }

    var currentTheme: AppTheme {
        get {
            return load("currentTheme", default: DarkTheme())
        }
        set {
            save(newValue, for: "currentTheme")
        }
    }
}
