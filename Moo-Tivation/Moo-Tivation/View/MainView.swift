//
//  MainView.swift
//  Moo-Tivation
//
//  Created by 신승재 on 6/17/24.
//

import SwiftUI
import DeviceActivity

struct MainView: View {
    let segment = ["우유 상태", "스포일 앱"]
    
    @State private var context: DeviceActivityReport.Context = .totalActivity
    @State private var contextsub: DeviceActivityReport.Context = .listActivity
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
    
    struct DairyChangeInMainView: Identifiable {
        var id = UUID()
        var dairyName : String
        var dairyImage : String
        var dairyDescription : String
    }
    @State private var currentDairy: DairyChangeInMainView = DairyChangeInMainView(dairyName: "", dairyImage: "", dairyDescription: "")

    @State var dairyChangeInMain: [DairyChangeInMainView] = [
    DairyChangeInMainView(dairyName: "푸른 곰팡이", dairyImage: "dairy_bluemold", dairyDescription: "자낭균류 진정자낭균목 페니실륨속 곰팡이를 통틀어 이르는 말\n부패 작용 또는 독극물에 의한 유해균이 많으며, 페니실린과 같은 유익한 것도 있다."),
    DairyChangeInMainView(dairyName: "신선한 우유", dairyImage: "dairy_milk", dairyDescription: "영양소가 많아 그대로 마시기도 한다. 오늘날 우유는 치즈, 버터, 크림, 요구르트 등의 다양한 유제품으로 가공되어 널리 소비된다."),
    DairyChangeInMainView(dairyName: "콜비 잭 치즈", dairyImage: "dairy_colbycheese", dairyDescription: "1960년대 위스콘신 주에서 노란색 콜비 치즈와 하얀색의 몬테레이 잭 치즈를 혼합해서 만든 치즈이다. 벽돌 형식으로 굳힌 뒤에 포장을 해서 판다.")]
    
    func updateDairy() {
        var userHour : Int = userSettings.thresholdHour
        var userMinite : Int = userSettings.thresholdMinutes
        
        if userHour <= 1 && userMinite <= 30 {
            currentDairy = dairyChangeInMain[2]
        } else if userHour < 0 && userMinite < 0 {
            currentDairy = dairyChangeInMain[0]
        } else {currentDairy = dairyChangeInMain[1]
        }
    }
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
                
                if segmentpick == 0 {
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
                                Image("\(currentDairy.dairyImage)")
                                    .resizable()
                                    .frame(width: 224, height: 224)
                                
                                Spacer().frame(height: 29)
                                
                                Text("\(userSettings.notificationText)")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundStyle(AppColor.blackTypo100)
                                
                            } .frame(maxWidth: .infinity, alignment: .center)
                            
                            Spacer().frame(height: 49)
                            
                            Text("\(currentDairy.dairyName)")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(AppColor.blackTypo70)
                            
                            Spacer().frame(height: 3)
                            
                            Text("\(currentDairy.dairyDescription)")
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
                } else {
                    DeviceActivityReport(contextsub, filter: filter)
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
            .navigationDestination(for: String.self) { value in
                switch value {
                case "SettingView":
                    SettingView(path: $path, userSettings: $userSettings)
                case "OnBoardingFirstView":
                    OnBoardingFirstView(path: $path)
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
                    path.append("OnBoardingFirstView")
                }
                updateDairy()
            }
            .onChange(of: path) { _, newPath in
                if newPath.isEmpty {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        reloadID = UUID()
                        print("redraw")
                    }
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
