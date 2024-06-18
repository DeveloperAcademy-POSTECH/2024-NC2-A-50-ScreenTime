//
//  SettingView.swift
//  Moo-Tivation
//
//  Created by 신승재 on 6/19/24.
//

import SwiftUI
import FamilyControls

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var appPickerPresented = false
    @State var tempSelection = FamilyActivitySelection()
    @State var notificationText = ""
    @State var hours = 0
    @State var minutes = 0
    
    @Binding var path: [String]
    @Binding var userSettings: UserSettings
    
    var characterLimit: Int = 25
    
    var body: some View {
        ZStack {
            Color.settingBackround.ignoresSafeArea()
            VStack(alignment: .leading, spacing:0) {
                HStack {
                    Button(action: { presentationMode.wrappedValue.dismiss() },
                           label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17, height: 22)
                    })
                    
                    Spacer()
                }.padding(.leading, 25)
                
                Spacer().frame(height: 35)
                
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("설정된 앱들")
                                .font(.system(size: 13))
                                .foregroundStyle(AppColor.blackTypo50)
                            
                            Spacer()
                            
                            Button(action: {
                                appPickerPresented = true
                            }, label: {
                                VStack(spacing: 0) {
                                    Text("변경")
                                        .font(.system(size: 16, weight: .bold))
                                    Spacer().frame(height: 8)
                                }
                            }).familyActivityPicker(isPresented: $appPickerPresented, selection: $tempSelection)
                        }
                    }
                }.padding(.horizontal, 25)
                
                VStack {
                    VStack {
                        ForEach(Array(tempSelection.applicationTokens.enumerated()), id: \.element) { index, token in
                            HStack(alignment: .center) {
                                Label(token)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            
                            if index < tempSelection.applicationTokens.count - 1 {
                                Divider()
                            }
                            
                        }
                        ForEach(Array(tempSelection.categoryTokens.enumerated()), id: \.element) { index, token in
                            HStack(alignment: .center) {
                                Label(token)
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            
                            if index < tempSelection.categoryTokens.count - 1 {
                                Divider()
                            }
                            
                        }
                    }.padding(.vertical, 5)
                    
                }
                .background(.white)
                .cornerRadius(10)
                .padding(.horizontal, 8)
                
                Spacer().frame(height: 7)
                
                LittleTitleView(text: "설정된 시간")
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.white)
                        .frame(height: 50)
                        .padding(.horizontal, 8)
                    HStack {
                        Text("\(userSettings.thresholdHour)시간 \(userSettings.thresholdMinutes)분")
                        Spacer()
                    }.padding(.horizontal, 16)
                }
                
//                HStack {
//                    
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 10)
//                            .foregroundStyle(Color.white)
//                            .frame(height: 230)
//                            .padding(.horizontal, 8)
//                        
//                        HStack(spacing: 0) {
//                                Picker("", selection: $hours){
//                                    ForEach(0..<12, id: \.self) { i in
//                                                Text("\(i)").tag(i)
//                                    }
//                                }.pickerStyle(.)
//                            Text("시간")
//                                        Picker("", selection: $minutes){
//                                            ForEach(0..<60, id: \.self) { i in
//                                                Text("\(i)").tag(i)
//                                            }
//                                        }.pickerStyle(WheelPickerStyle())
//                            Text("분")
//                        }.padding(.horizontal, 20)
//                    }.padding(.horizontal, 8)
//                }
                
                Spacer().frame(height: 7)
                
                LittleTitleView(text: "작성된 문구")
                VStack {
                    VStack {
                        TextField("", text: $notificationText)
                            .frame(height: 48)
                            .padding(.horizontal, 10)
                            .onChange(of: notificationText) { newValue, _ in
                                if newValue.count > characterLimit {
                                    notificationText = String(newValue.prefix(characterLimit))
                                }
                            }
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                }.padding(.horizontal, 8)
                
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        let newUserSettings = UserSettings(applications: tempSelection, thresholdHour: 2, thresholdMinutes: 30, notificationText: notificationText, onboardingCompleted: true)
                        
                        UserSettingsManager.shared.saveSettings(newUserSettings)
                        
                        let appTokens = UserSettingsManager.shared.loadAppTokkens()
                        let notificationText = UserSettingsManager.shared.loadNotificationText()
                        DeviceActivityManager.shared.handleStopDeviceActivityMonitoring()
                        DeviceActivityManager.shared.startDeviceActivityMonitoring(appTokens: appTokens, hour: 1, minute: 1) { result in
                            switch result {
                            case .success():
                                print("성공")
                            case .failure(let error):
                                print("실패")
                            }
                        }
                        
                        path.removeLast()
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 56)
                                .foregroundColor(AppColor.blueActive)
                            
                            Text("완료")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    })
                }.padding(.horizontal, 12)
            }.onAppear() {
                tempSelection = userSettings.applications
                notificationText = userSettings.notificationText
                hours = userSettings.thresholdHour
                minutes = userSettings.thresholdMinutes
            }
        }.navigationBarBackButtonHidden(true)

    }
}

//#Preview {
//    SettingView()
//}
