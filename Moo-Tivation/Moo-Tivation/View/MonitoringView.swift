//
//  MonitoringView.swift
//  Moo-Tivation
//
//  Created by 신승재 on 6/19/24.
//

import SwiftUI
import DeviceActivity

struct MonitoringView: View {
    @State private var context: DeviceActivityReport.Context = .totalActivity
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
                of: .day,
                for: .now
            ) ?? DateInterval()
        )
    )
    var body: some View {
        DeviceActivityReport(context, filter: filter)
            .onAppear {
                filter = DeviceActivityFilter(
                    segment: .daily(
                        during: Calendar.current.dateInterval(
                            of: .day, for: .now
                        ) ?? DateInterval()
                    ),
                    users: .all,
                    devices: .init([.iPhone]),
                    applications: UserSettingsManager.shared.loadAppTokkens().applicationTokens,
                    categories: UserSettingsManager.shared.loadAppTokkens().categoryTokens
                )
            }
    }
}

#Preview {
    MonitoringView()
}
