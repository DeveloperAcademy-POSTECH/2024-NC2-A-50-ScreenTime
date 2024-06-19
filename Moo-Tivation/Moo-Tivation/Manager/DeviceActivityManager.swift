//
//  DeviceActivityManager.swift
//  Moo-Tivation
//
//  Created by 신승재 on 6/17/24.
//

import Foundation
import ManagedSettings
import DeviceActivity
import FamilyControls

class DeviceActivityManager {
    
    static let shared = DeviceActivityManager()
    private init() {}
    
    let deviceActivityCenter = DeviceActivityCenter()
    
    //MARK: 스크린타임 권한 요청
    func reqScreenTimePermission() {
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
    
    func startDeviceActivityMonitoring(appTokens: FamilyActivitySelection, hour: Int, minute: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        // 선택한 앱 토큰 가져오기
        let selectedAppTokens = appTokens.applicationTokens
        
        // 임계값
        // let threshold = DateComponents(hour: hour, minute: minute)
        let threshold = DateComponents(second: 10)
        
        // 모니터 DeviceActivitySchedule 설정 - 매일 24시간
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: 0, minute: 0),
            intervalEnd: DateComponents(hour: 23, minute: 59),
            repeats: true
        )
        
        // 이벤트 설정
        let events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [
            .encouraged: DeviceActivityEvent(
                applications: selectedAppTokens,
                threshold: threshold
            )
        ]
        
        do {
            // 앱 모니터링 시작
            try deviceActivityCenter.startMonitoring(DeviceActivityName.daily, during: schedule, events: events)
            print("\n\n")
            print("모니터링 시작 --> \(deviceActivityCenter.activities.description)\n")
            print("이벤트 --> \(events)\n")
            print("스케줄 --> \(schedule)\n")
            print("앱 토큰 --> \(selectedAppTokens)\n")
        } catch {
            completion(.failure(error))
            return
        }
        
        completion(.success(()))
    }
    
    // 모니터링 stop
    func handleStopDeviceActivityMonitoring() {
        deviceActivityCenter.stopMonitoring()
    }
}

extension DeviceActivityName {
    static let daily = Self("daily")
}

extension DeviceActivityEvent.Name {
    static let encouraged = Self("encouraged")
}
