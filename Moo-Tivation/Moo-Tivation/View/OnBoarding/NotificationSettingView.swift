//
//  NotificationSettingView.swift
//  Moo-Tivation
//
//  Created by 신승재 on 6/17/24.
//

import SwiftUI

struct NotificationSettingView: View {
    @Binding var path: [String]
    
    @State var notificationText: String = "생각한대로 말하는대로 삶은 흘러간다."
    var characterLimit: Int = 25
    
    var body: some View {
        ZStack {
            Color.settingBackround.ignoresSafeArea()
                
            
            VStack(spacing: 0) {
                
                OnBoardingHeaderView(title: "알림문구를 작성해보세요",
                                     subTitle: "제한시간에 가까워지면 알림으로 보여드릴게요",
                                     page: 3)
                
                Spacer().frame(height: 57)
                
                HStack {
                    Text("작성된 문구")
                        .font(.system(size: 13))
                        .foregroundStyle(AppColor.blackTypo50)
                    
                    Spacer()
                }.padding(.leading, 25)
                
                Spacer().frame(height: 2)
            
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
                    
                    Spacer().frame(height: 42)
                    
                    LockScreenPreview(notificationText: notificationText)
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            path.append("TotalSettingView")
                        }, label: {
                            ZStack{
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
            .ignoresSafeArea(.keyboard)
        }.navigationBarBackButtonHidden(true)
    }
}

// MARK: - 잠금화면 프리뷰
fileprivate struct LockScreenPreview: View {
    
    private var notificationText: String
    
    init(notificationText: String) {
        self.notificationText = notificationText
    }
    
    fileprivate var body: some View {
        HStack {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(red: 32/255, green: 124/255, blue: 171/255),
                                                        Color(red: 233/255, green: 153/255, blue: 152/255)]),
                                                startPoint: .top,
                                                endPoint: .bottom
                        )
                    )
                    .frame(height: 250)
                VStack(spacing: 0) {
                    Spacer().frame(height: 30)
                    
                    Text("10월 15일 토요일")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                    Text("12:00")
                        .font(.system(size: 64, weight: .semibold))
                        .foregroundStyle(.white)
                    
                    Spacer().frame(height: 20)
                    
                    VStack {
                        HStack {
                            
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 44, height: 44)
                                    .foregroundColor(.white)
                            }
                            
                            VStack(alignment:.leading, spacing: 0) {
                                Text("Moo-Tivation")
                                    .font(.system(size: 15,weight: .semibold))
                                    .foregroundStyle(.white)
                                
                                Spacer().frame(height: 3)
                                
                                Text(notificationText)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 15))
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        
                    }
                    .background(Color(red: 0, green: 0, blue: 0, opacity: 0.2))
                    .cornerRadius(15)
                    
                }.padding(.horizontal, 23)
            }
        }
    }
}


//#Preview {
//    NotificationSettingView()
//}
