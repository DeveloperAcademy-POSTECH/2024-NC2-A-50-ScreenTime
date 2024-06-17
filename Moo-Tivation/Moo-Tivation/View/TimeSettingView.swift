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
            
            VStack (alignment: .leading) {
                HStack {
                    Button(action: {presentationMode.wrappedValue.dismiss()},
                           label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17, height: 22)
                    })
                }.padding(.leading, 25)
                
                HStack {
                    
                    Spacer()
                    
                    Text("2")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(AppColor.blackTypo100)
                    
                    Text("/ 4")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(AppColor.blackTypo25)
                    
                    
                } .padding(.trailing, 25)
                
                Spacer().frame(height: 40)
                
                HStack {
                    Spacer().frame(width: 25)
                    
                    VStack (alignment: .leading) {
                        
                        Text("제한 시간을 정해보세요")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(AppColor.blackTypo100)
                        
                        Spacer().frame(height: 11)
                        
                        Text("여유롭게 시작해 조금씩 줄여가는 방법도 있어요\n조금씩 목표에 가까워지는 자신을 느껴보세요!")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(AppColor.blackTypo50)
                            .lineSpacing(2)
                        
                        Spacer().frame(height: 50)
                        
                        Text("설정된 시간")
                                .font(.system(size: 13))
                                .foregroundStyle(AppColor.blackTypo50)
                                .offset(y: 12)
                    }
                }
                HStack {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.white)
                            .frame(height: 230)
                            .padding(.horizontal, 8)
                        HStack {
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
                        }.padding()
                    }
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 56)
                            
                            Text("다음")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    })
                    
                    Spacer()
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TimeSettingView()
}
