//
//  SpoilAppSettingView.swift
//  Moo-Tivation
//
//  Created by kyunglimkim on 6/17/24.
//

import SwiftUI

struct SpoilAppSettingView: View {
    @Environment(\.presentationMode) var presentationMode
    
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
                                
                            }, label: {
                                VStack(spacing: 0) {
                                    Text("변경")
                                        .font(.system(size: 16, weight: .bold))
                                    Spacer().frame(height: 8)
                                }
                            })
                        }
                    }
                }.padding(.horizontal, 25)
                
                
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.white)
                        .frame(height: 56)
                        .padding(.horizontal, 8)
                }.padding(.horizontal, 8)
                
                Spacer().frame(height: 10)
                
                HStack {
                    Text("변경하기 버튼을 눌러 선택한 시간동안 사용을 제한하고 싶은 앱을 \n선택할 수 있습니다.")
                        .font(.system(size: 13))
                        .foregroundStyle(AppColor.blackTypo50)
                }.padding(.leading, 20)
                
                Spacer()
                
                HStack {
                    NavigationLink {
                        TimeSettingView()
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
    SpoilAppSettingView()
}
