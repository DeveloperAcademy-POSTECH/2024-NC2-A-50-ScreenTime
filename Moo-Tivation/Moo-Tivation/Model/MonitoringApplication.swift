//
//  MonitoringApplication.swift
//  Moo-Tivation
//
//  Created by 신승재 on 6/17/24.
//

import Foundation
import FamilyControls
import ManagedSettings

class MonitoringApplication {
    static let shared = MonitoringApplication()
    private init() {}
    
    @Published var newSelection: FamilyActivitySelection = .init()
    
    var selectedAppsTokens: Set<ApplicationToken> {
        newSelection.applicationTokens
    }
}
