//
//  UserSettings.swift
//  Moo-Tivation
//
//  Created by 신승재 on 6/18/24.
//

import Foundation
import FamilyControls
import ManagedSettings

final class UserSettings: Codable {
    var applications: FamilyActivitySelection
    var thresholdHour: Int
    var thresholdMinutes: Int
    var notificationText: String
    var onboardingCompleted: Bool
    
    init(applications: FamilyActivitySelection = .init(), thresholdHour: Int = 0, thresholdMinutes: Int = 0, notificationText: String = "", onboardingCompleted: Bool = false) {
        self.applications = applications
        self.thresholdHour = thresholdHour
        self.thresholdMinutes = thresholdMinutes
        self.notificationText = notificationText
        self.onboardingCompleted = onboardingCompleted
    }
}
