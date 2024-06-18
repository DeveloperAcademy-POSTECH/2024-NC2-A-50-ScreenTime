//
//  UserSettingsManager.swift
//  Moo-Tivation
//
//  Created by 신승재 on 6/18/24.
//

import Foundation

class UserSettingsManager {
    static let shared = UserSettingsManager()
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    private let settingsKey = "UserSettings"
    
    func saveSettings(_ settings: UserSettings) {
        do {
            let data = try JSONEncoder().encode(settings)
            userDefaults.set(data, forKey: settingsKey)
        } catch {
            print("Failed to save user settings: \(error)")
        }
    }
    
    func loadSettings() -> UserSettings {
        guard let data = userDefaults.data(forKey: settingsKey) else {
            return UserSettings()
        }
        
        do {
            let settings = try JSONDecoder().decode(UserSettings.self, from: data)
            return settings
        } catch {
            print("Failed to load user settings: \(error)")
            return UserSettings()
        }
    }
}
