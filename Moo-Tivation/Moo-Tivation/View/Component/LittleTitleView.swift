//
//  LittleTitleView.swift
//  Moo-Tivation
//
//  Created by 신승재 on 6/18/24.
//

import SwiftUI

struct LittleTitleView: View {
    private var text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 13))
                .foregroundStyle(AppColor.blackTypo50)
            
            Spacer()
        }
        .padding(.leading, 25)
        .padding(.bottom, 2)
    }
}

#Preview {
    LittleTitleView(text: "hello")
}
