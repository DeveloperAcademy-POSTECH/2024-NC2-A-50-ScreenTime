//
//  TotalActivityView.swift
//  ScreenActivityReport
//
//  Created by 신승재 on 6/17/24.
//

import SwiftUI
import FamilyControls

// MARK: - MonitoringView에서 보여줄 SwiftUI 뷰
struct TotalActivityView: View {
    var activityReport: ActivityReport
    
    var body: some View {
        HStack {
            if activityReport.totalDuration < 0 {
                Text(activityReport.totalDuration.toString())
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundStyle(.red)
            } else {
                Text(activityReport.totalDuration.toString())
                    .font(.system(size: 40, weight: .heavy))
            }
            
            Spacer()
        }
    }
}
