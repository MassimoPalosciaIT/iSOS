//
//  FirstAidSelectionButton.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

struct FirstAidSelectionButton: View {
    let side_padding: CGFloat = 20
    var iconName: String
    var title: String
    
    var body: some View {
        ZStack{
            AppStandartButton(gradientColor1: .mainGray, gradientColor2: .mainGray, iconName: "xmark", frameHeight: 80, iconOpacity: 0)
            
            VStack
            {
                HStack {
                    Group {
                        Image(systemName:"xmark")
                            .padding(.leading, side_padding)
                            .opacity(0)
                            .overlay(
                                Image(systemName:iconName)
                                    .padding(.leading, side_padding)
                            )
                        
                        
                        Text(title)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        Spacer()
                        Image(systemName: "chevron.right")
                            .padding(.trailing, side_padding)
                    }
                    .font(.title)
                    .fontWeight(.medium)
                    
                }
            }.frame(height: 80)
        }
    }
}

#Preview {
    FirstAidSelectionButton(iconName: "lungs", title: "Test")
}
