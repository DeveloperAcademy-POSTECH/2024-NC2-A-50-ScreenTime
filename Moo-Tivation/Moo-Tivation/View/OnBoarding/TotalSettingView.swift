//
//  TotalSettingView.swift
//  Moo-Tivation
//
//  Created by 신승재 on 6/18/24.
//

import SwiftUI

struct TotalSettingView: View {
    @Binding var path: [String]
    @Binding var userSettings: UserSettings
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.settingBackround.ignoresSafeArea()
            VStack(alignment: .leading, spacing:0) {
                OnBoardingHeaderView(title: "이렇게 설정하면 될까요?", subTitle: "목표가 부담스러우면\n설정을 통해 언제든지 바꿀 수 있습니다.", page: 4)
                
                Spacer().frame(height: 35)
                
                LittleTitleView(text: "설정된 앱들")
                
                VStack {
                    ForEach(Array(userSettings.applications.applicationTokens.enumerated()), id: \.element) { index, token in
                        HStack(alignment: .center) {
                            Label(token)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        if index < userSettings.applications.applicationTokens.count - 1 {
                            Divider()
                        }
                        
                    }
                    ForEach(Array(userSettings.applications.categoryTokens.enumerated()), id: \.element) { index, token in
                        HStack(alignment: .center) {
                            Label(token)
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        
                        if index < userSettings.applications.categoryTokens.count - 1 {
                            Divider()
                        }
                        
                    }
                }
                .padding(.vertical, 5)
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
                
                
                Spacer().frame(height: 7)
                
                LittleTitleView(text: "작성된 문구")
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.white)
                        .frame(height: 50)
                        .padding(.horizontal, 8)
                    HStack {
                        Text(userSettings.notificationText)
                        Spacer()
                    }.padding(.horizontal, 16)
                }
                
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        path.removeLast(path.count)
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
            }
        }.navigationBarBackButtonHidden(true)
    }
}


//#Preview {
//    TotalSettingView()
//}
