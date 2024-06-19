//
//  MainView.swift
//  Moo-Tivation
//
//  Created by 신승재 on 6/17/24.
//

import SwiftUI
import DeviceActivity

struct MainView: View {
    let segment = ["우유 상태", "완료 여부"]
    
    @State private var context: DeviceActivityReport.Context = .totalActivity
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
                of: .day,
                for: .now
            ) ?? DateInterval()
        )
    )
    
    @State private var userSettings = UserSettings()
    @State var path: [String] = []
    @State private var segmentpick = 0
    
    @State private var reloadID = UUID()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                VStack {
                    Picker(selection: $segmentpick, label: Text("menu")) {
                        ForEach(0..<2, id: \.self) { index in
                            Text(self.segment[index]).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                        .frame(width: 192)
                    
                }
                Spacer().frame(height: 22)
                
                HStack {
                    Spacer()
                    Button(action: {
                        path.append("SettingView")
                    }, label: {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width: 25,height: 25)
                    })
                }.padding(.trailing, 25)
                
                VStack {
                    VStack(alignment: .leading) {
                        Text("스포일앱를 사용할 수 있는 시간")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundStyle(AppColor.blueTypo)
                        
                        Spacer().frame(height: 5)
                        
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
                            .frame(height: 40)

                        Spacer().frame(height: 40)
                        
                        VStack {
                            Image("colbycheese")
                                .resizable()
                                .frame(width: 224, height: 224)
                            
                            Spacer().frame(height: 29)
                            
                            Text("문구 수정해볼곳")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(AppColor.blackTypo100)
                            
                        } .frame(maxWidth: .infinity, alignment: .center)
                        
                        Spacer().frame(height: 49)
                        
                        Text("콜비치즈")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(AppColor.blackTypo70)
                        
                        Spacer().frame(height: 3)
                        
                        Text("프랑스의 노르망디 지방에서 생산되는 부드러운 연질의 \n치즈이다. 카망베르 마을에서 처음 만들어져 그 이름을 땄다.")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(AppColor.blackTypo50)
                        
                        Spacer()
                    }.padding(.horizontal, 44)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.colorTypo15)
                            .foregroundColor(.white)
                            .frame(height: 123)
                            .padding(.horizontal, 20)
                        
                        VStack {
                            Text("내가 설정한 시간")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundStyle(AppColor.blueTypo)
                            
                            Spacer().frame(height: 10)
                            
                            Text("\(userSettings.thresholdHour)시간 \(userSettings.thresholdMinutes)분")
                                .font(.system(size: 32, weight: .bold))
                        }
                    }
                    Spacer().frame(height: 17)
                }
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                case "SettingView":
                    SettingView(path: $path, userSettings: $userSettings)
                case "SpoilAppSettingView":
                    SpoilAppSettingView(path: $path, userSettings: $userSettings)
                case "TimeSettingView":
                    TimeSettingView(path: $path, userSettings: $userSettings)
                case "NotificationSettingView":
                    NotificationSettingView(path: $path, userSettings: $userSettings)
                case "TotalSettingView":
                    TotalSettingView(path: $path, userSettings: $userSettings)
                default:
                    EmptyView()
                }
            }
            .onAppear() {
                userSettings = UserSettingsManager.shared.loadSettings()
                if !userSettings.onboardingCompleted {
                    path.append("SpoilAppSettingView")
                }
            }
            .onChange(of: path) { _, newPath in
                if newPath.isEmpty {
                    reloadID = UUID()
                    print("redraw")
                }
            }
        }
        .id(reloadID)
        .ignoresSafeArea()
    }
}

#Preview {
    MainView()
}
