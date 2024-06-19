//
//  SpoilAppSettingView.swift
//  Moo-Tivation
//
//  Created by kyunglimkim on 6/17/24.
//

import SwiftUI
import FamilyControls

struct SpoilAppSettingView: View {
    
    @Binding var path: [String]
    @Binding var userSettings: UserSettings
    @State var appPickerPresented = false
    @State var tempSelection = FamilyActivitySelection()
    @State var disableButton = true
    
    var body: some View {
        ZStack {
            Color.settingBackround.ignoresSafeArea()
            VStack (alignment: .leading, spacing: 0) {
                
               OnBoardingHeaderView(title: "스포일 앱을 정해보세요", subTitle: "스포일앱은 우유를 만드는데 망치는 앱을 뜻해요", page: 1)
                
                Spacer().frame(height: 50)
                
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
                    if tempSelection.applicationTokens.isEmpty &&
                        tempSelection.categoryTokens.isEmpty &&
                        tempSelection.webDomainTokens.isEmpty {
                        HStack(alignment: .center) {
                            Text("앱을 선택하세요.")
                            Spacer()
                        }
                        .frame(height: 50)
                        .padding(.horizontal, 16)
                    } else {
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
                }
                .background(.white)
                .cornerRadius(10)
                .padding(.horizontal, 8)
                
                
                Spacer().frame(height: 10)
                
                HStack {
                    Text("변경하기 버튼을 눌러 선택한 시간동안 사용을 제한하고 싶은 앱을 \n선택할 수 있습니다.")
                        .font(.system(size: 13))
                        .foregroundStyle(AppColor.blackTypo50)
                }.padding(.leading, 20)
                
                Spacer()
                

                HStack {
                    
                    if tempSelection.applicationTokens.isEmpty &&
                        tempSelection.categoryTokens.isEmpty &&
                        tempSelection.webDomainTokens.isEmpty {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 56)
                                .foregroundColor(AppColor.blackTypo25)
                            
                            Text("다음")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    } else {
                        Button(action: {
                            userSettings.applications = tempSelection
                            path.append("TimeSettingView")
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 56)
                                    .foregroundColor(AppColor.blueActive)
                                
                                Text("다음")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        })
                    }
                }.padding(.horizontal, 12)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    SpoilAppSettingView(path: )
//}
