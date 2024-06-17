//
//  MainView.swift
//  Moo-Tivation
//
//  Created by 신승재 on 6/17/24.
//

import SwiftUI

struct MainView: View {
    let segment = ["우유 상태", "완료 여부"]
       @State private var segmentpick = 0
    
    var body: some View {
        VStack{
            VStack {
                Picker(selection: $segmentpick, label: Text("menu")) {
                    ForEach(0..<2, id: \.self) { index in
                        Text(self.segment[index]).tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .frame(width: 192)
            }
            Spacer().frame(height: 22)
            HStack{
                Spacer().frame(width: 300)
                Button(action: {
                    
                }, label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 25,height: 25)
                })
            }
            VStack{
            VStack(alignment: .leading){
                Text("스포일앱를 사용할 수 있는 시간")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(AppColor.blueTypo)
                Spacer().frame(height: 5)
                Text("1시간 20분")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundStyle(AppColor.blackTypo100)
                Spacer().frame(height: 40)
                VStack(){
                    Image("colbycheese")
                        .resizable()
                        .frame(width: 224, height: 224)
                    Spacer().frame(height: 29)
                    Text("사용자가 설정한 문구가 나오는 곳")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(AppColor.blackTypo100)
                } .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer().frame(height: 49)
                
                Text("콜비치즈")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(AppColor.blackTypo70)
                Spacer().frame(height: 3)
                Text("프랑스의 노르망디 지방에서 생산되는 부드러운 연질의 치즈이다. 카망베르 마을에서 처음 만들어져 그 이름을 땄다.")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(AppColor.blackTypo50)
                
                Spacer()
            }
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.colorTypo15)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(height: 140)
                    
                    VStack{
                        Text("현재 아낀 시간")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(AppColor.blueTypo)
                        
                        Spacer().frame(height: 10)
                        
                        Text("00일 00시간 00분")
                            .font(.system(size: 32, weight: .bold))
                    }
                }
                Spacer().frame(height: 17)
            }.padding(.horizontal, 44)
        }
    }
}

#Preview {
    MainView()
}
