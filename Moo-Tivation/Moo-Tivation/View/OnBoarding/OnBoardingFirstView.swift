//
//  OnBoardingFirstView.swift
//  Moo-Tivation
//
//  Created by 신승재 on 6/19/24.
//

import SwiftUI

struct OnBoardingFirstView: View {
    @Binding var path: [String]
    
    var body: some View {
        Spacer().frame(height: 82)
        
        Text("사용을 줄이고 싶은 앱을 선택하고,\n하루 동안 사용할 시간을 설정해보세요")
            .font(.system(size: 22, weight: .semibold))
            .foregroundStyle(AppColor.blackTypo100)
            .multilineTextAlignment(.center)
        
        Spacer().frame(height: 11)
        
        Text("무티베이션과 함께 건강한 사용습관을 만들어보세요")
            .font(.system(size: 16, weight: .regular))
            .foregroundStyle(AppColor.blackTypo50)
            .lineSpacing(2)
        
        Spacer().frame(height: 50)
        
        Image("OnBoardingImage")
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 47)
        
        Spacer()
        
        HStack {
            Button(action: {
                DeviceActivityManager.shared.reqScreenTimePermission()
                NotifiactionManager.shared.reqNotificationPermission()
                path.append("SpoilAppSettingView")
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
        }.padding(.horizontal, 16)
            .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    OnBoardingFirstView()
//}
