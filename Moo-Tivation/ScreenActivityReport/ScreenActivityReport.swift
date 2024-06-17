//
//  ScreenActivityReport.swift
//  ScreenActivityReport
//
//  Created by 신승재 on 6/17/24.
//

import DeviceActivity
import SwiftUI

@main
struct ScreenActivityReport: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}
