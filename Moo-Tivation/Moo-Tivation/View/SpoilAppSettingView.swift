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
            VStack (alignment: .leading) {
                HStack {
                    Button(action: {presentationMode.wrappedValue.dismiss()},
                           label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17, height: 22)
                    })
                }.padding()
                
                HStack {
                   
                    Spacer()
                    
                    Text("1")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(AppColor.blackTypo100)
                    
                    Text("/ 4")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(AppColor.blackTypo25)
                    
                    
                } .padding(.horizontal)
                
                Spacer().frame(height: 40)
                
                HStack {
                    Spacer().frame(width: 25)
                    
                    VStack(alignment: .leading){
                        
                        Text("스포일 앱을 정해보세요")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(AppColor.blackTypo100)
                        
                        Spacer().frame(height: 11)
                        
                        Text("스포일앱은 우유를 만드는데 망치는 앱을 뜻해요")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(AppColor.blackTypo50)
                        
                        Spacer().frame(height: 50)
                        
                        HStack {
                            Text("설정된 앱들")
                                .font(.system(size: 13))
                                .foregroundStyle(AppColor.blackTypo50)
                                .offset(y: 8)
                            
                            Spacer()
                            
                            Button(action: {
                                
                            }, label: {
                                Text("변경")
                                    .font(.system(size: 16, weight: .bold))
                            })
                        }
                    }
                    
                    Spacer().frame(width: 25)
                }
                HStack {
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 10) //앱을 정해보세요.
                        .foregroundStyle(Color.white)
                        .frame(width: 369, height: 56)
                    
                    Spacer()
                }
                Spacer().frame(height: 10)
                
                HStack {
                    Spacer().frame(width: 20)
                    
                    Text("변경하기 버튼을 눌러 선택한 시간동안 사용을 제한하고 싶은 앱을 \n선택할 수 있습니다.")
                        .font(.system(size: 13))
                        .foregroundStyle(AppColor.blackTypo50)
                }
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    NavigationLink {
                        TimeSettingView()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 369, height: 56)
                            
                            Text("다음")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                                    }
                    }
                    
                    Spacer()
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SpoilAppSettingView()
}
