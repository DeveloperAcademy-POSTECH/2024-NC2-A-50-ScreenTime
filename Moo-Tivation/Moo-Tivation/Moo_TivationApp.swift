//
//  Moo_TivationApp.swift
//  Moo-Tivation
//
//  Created by 신승재 on 6/17/24.
//

import SwiftUI
import FamilyControls
import DeviceActivity

@main
struct Moo_TivationApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear() {
                    reqNotificationPermission()
                    reqScreenTimePermission()
                }
        }
    }
}

extension Moo_TivationApp {
    //MARK: 스크린타임 권한 요청
    private func reqScreenTimePermission() {
        let center = AuthorizationCenter.shared
        
        if center.authorizationStatus == .approved {
            print("ScreenTime Permission approved")
        } else {
            Task {
                do {
                    try await center.requestAuthorization(for: .individual)
                } catch {
                    print("Failed to enroll Aniyah with error: \(error)")
                }
            }
        }
    }
    
    //MARK: 유저노티피케이션 권한 요청
    private func reqNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings { settings in
            switch settings.alertSetting {
            case .enabled:
                print("Notification Permission approved")
            default:
                print("not..!")
                Task {
                    do {
                        try await center.requestAuthorization(options: [.alert, .badge, .sound])
                    } catch {
                        print("Failed to enroll Aniyah with error: \(error)")
                    }
                    
                }
            }
        }
    }
}
