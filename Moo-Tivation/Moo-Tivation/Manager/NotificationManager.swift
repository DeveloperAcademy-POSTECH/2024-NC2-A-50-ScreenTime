//
//  NotificationManager.swift
//  Moo-Tivation
//
//  Created by 신승재 on 6/17/24.
//

import Foundation
import UserNotifications

class NotifiactionManager {
    static let shared = NotifiactionManager()
    private init() {}
    
    // MARK: - 푸시 알림 전송
    func sendNotification(text: String) -> Void {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized, .provisional:
                let content = UNMutableNotificationContent()
                content.subtitle = "종료 알림"
                content.body = text
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.5, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { error in
                    guard error == nil else { return }
                    print("scheduling notification with id:\(request.identifier)")
                }
                
            default:
                break
            }
        }
    }
}
