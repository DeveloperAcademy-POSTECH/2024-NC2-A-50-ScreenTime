//
//  TotalSettingView.swift
//  Moo-Tivation
//
//  Created by 신승재 on 6/18/24.
//

import SwiftUI

struct TotalSettingView: View {
    
    @Binding var path: [String]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.settingBackround.ignoresSafeArea()
            VStack(alignment: .leading, spacing:0) {
                OnBoardingHeaderView(title: "이렇게 설정하면 될까요?", subTitle: "목표가 부담스러우면\n설정을 통해 언제든지 바꿀 수 있습니다.", page: 4)
                
                Spacer().frame(height: 35)
                
                LittleTitleView(text: "설정된 앱들")
                
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.white)
                        .frame(height: 56)
                        .padding(.horizontal, 8)
                }.padding(.horizontal, 8)
                
                Spacer().frame(height: 7)
                
                LittleTitleView(text: "설정된 시간")
                
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.white)
                        .frame(height: 56)
                        .padding(.horizontal, 8)
                }.padding(.horizontal, 8)
                
                Spacer().frame(height: 7)
                
                LittleTitleView(text: "작성된 문구")
                
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.white)
                        .frame(height: 56)
                        .padding(.horizontal, 8)
                }.padding(.horizontal, 8)
                
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
