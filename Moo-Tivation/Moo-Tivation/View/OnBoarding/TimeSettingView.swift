//
//  TimeSettingView.swift
//  Moo-Tivation
//
//  Created by kyunglimkim on 6/17/24.
//

import SwiftUI

struct TimeSettingView: View {
    @State var hours: Int = 2
    @State var minutes: Int = 30
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.settingBackround.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                
                OnBoardingHeaderView(title: "제한 시간을 정해보세요", 
                                     subTitle: "여유롭게 시작해 조금씩 줄여가는 방법도 있어요\n조금씩 목표에 가까워지는 자신을 느껴보세요!",
                                     page: 2)
                
                Spacer().frame(height: 35)
                
                HStack {
                    Text("설정된 시간")
                        .font(.system(size: 13))
                        .foregroundStyle(AppColor.blackTypo50)
                }.padding(.leading, 25)
                
                Spacer().frame(height: 2)
                
                HStack {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.white)
                            .frame(height: 230)
                            .padding(.horizontal, 8)
                        
                        HStack(spacing: 0) {
                                Picker("", selection: $hours){
                                    ForEach(0..<12, id: \.self) { i in
                                                Text("\(i)").tag(i)
                                    }
                                        }.pickerStyle(WheelPickerStyle())
                            Text("시간")
                                        Picker("", selection: $minutes){
                                            ForEach(0..<60, id: \.self) { i in
                                                Text("\(i)").tag(i)
                                            }
                                        }.pickerStyle(WheelPickerStyle())
                            Text("분")
                        }.padding(.horizontal, 20)
                    }.padding(.horizontal, 8)
                }
                
                Spacer()
                
                HStack {
                    NavigationLink {
                        NotificationSettingView()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 56)
                                .foregroundColor(AppColor.blueActive)
                            
                            Text("다음")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                }.padding(.horizontal, 12)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TimeSettingView()
}
