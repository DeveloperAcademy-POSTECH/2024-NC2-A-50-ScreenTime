//
//  TotalListView.swift
//  Moo-Tivation
//
//  Created by 신승재 on 6/19/24.
//

import SwiftUI

struct TotalListView: View {
    var activityReport: ActivityReport
    
    var body: some View {
        ScrollView {
            
            Spacer().frame(height: 10)
            
            ForEach(activityReport.apps) { eachApp in
                ListRow(eachApp: eachApp)
            }
        }
    }
}


struct ListRow: View {
    var eachApp: AppDeviceActivity
    
    var body: some View {
        
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray)
                .foregroundColor(.white)
                .frame(height: 70)
                .padding(.horizontal, 20)
            
            VStack(spacing: 4) {
                
                
                
                HStack(spacing: 0) {
                    if let token = eachApp.token {
                        Label(token)
                            .labelStyle(.iconOnly)
                            .offset(x: -4)
                    }
                    Text(eachApp.displayName)
                    Spacer()
                    //                VStack(alignment: .trailing, spacing: 2) {
                    //                    HStack(spacing: 4) {
                    //                        Text("화면 깨우기")
                    //                            .font(.footnote)
                    //                            .foregroundColor(.secondary)
                    //                            .frame(width: 72, alignment: .leading)
                    //                        Text("\(eachApp.numberOfPickups)회")
                    //                            .font(.headline)
                    //                            .bold()
                    //                            .frame(minWidth: 52, alignment: .trailing)
                    //                    }
                    //                    HStack(spacing: 4) {
                    //                        Text("모니터링 시간")
                    //                            .font(.footnote)
                    //                            .foregroundColor(.secondary)
                    //                            .frame(width: 72, alignment: .leading)
                    //                        Text(String(eachApp.duration.toString()))
                    //                            .font(.headline)
                    //                            .bold()
                    //                            .frame(minWidth: 52, alignment: .trailing)
                    //                    }
                    //                }
                }
                HStack {
                    Text("실제 사용 시간:")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Text(String(eachApp.duration.toString()))
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            .padding(.leading, 30)
            .background(.clear)
        }
    }
}

//#Preview {
//    TotalListView()
//}
