//
//  FirstAidSelectionButton.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

struct FirstAidSelectionButton: View {
    
    var iconName: String
    var title: String
    
    var body: some View {
        
        AppStandartButton(gradientColor1: .mainGray, gradientColor2: .mainGray, iconName: "xmark", frameHeight: 80, iconOpacity: 0)
            .overlay{
                
                HStack {
                    Group {
                        Image(systemName:"xmark")
                            .foregroundStyle(.clear)
                            .overlay(
                                Image(systemName: iconName)
                            )
                        
                        Text(title)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .font(.title)
                    .fontWeight(.medium)
                    
                }
                .padding()
                
            }
        
    }
}

#Preview {
    FirstAidSelectionButton(iconName: "lungs", title: "Test")
}
