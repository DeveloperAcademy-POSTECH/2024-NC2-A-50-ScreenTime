//
//  ExampleComponentView.swift
//  Moo-Tivation
//
//  Created by 신승재 on 6/17/24.
//

import SwiftUI

struct OnBoardingHeaderView: View {
    @Environment(\.presentationMode) var presentationMode
    
    private var title: String
    private var subTitle: String
    private var page: Int
    
    init(title: String, subTitle: String, page: Int) {
        self.title = title
        self.subTitle = subTitle
        self.page = page
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() },
                       label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 17, height: 22)
                })
                
                Spacer()
            }
            
            Spacer().frame(height: 8)
            
            HStack {
                
                Spacer()
                
                Text("\(page)")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(AppColor.blackTypo100)
                
                Text("/ 4")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(AppColor.blackTypo25)
                
                
            }
            
            Spacer().frame(height: 40)
            
            HStack {
                
                VStack(alignment: .leading) {
                    
                    Text(title)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(AppColor.blackTypo100)
                    
                    Spacer().frame(height: 11)
                    
                    Text(subTitle)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(AppColor.blackTypo50)
                        .lineSpacing(2)
                }
                
                Spacer()
            }
        }.padding(.horizontal, 25)
    }
}

#Preview {
    OnBoardingHeaderView(title: "스포일 앱을 정해보세요", subTitle: "스포일앱은 우유를 만드는데 망치는 앱을 뜻해요", page: 1)
}
