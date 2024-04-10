//
//  EmergencyMenuButton.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

struct EmergencyMenuButton: View {
    var title: String
    var iconName: String
    var gradientColor1: Color
    var gradientColor2: Color
    let side_padding: CGFloat = 10
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                AppStandartButton(gradientColor1: gradientColor1, gradientColor2: gradientColor2, iconName: iconName,iconOpacity: 0.12)
                
                VStack {
                    HStack {
                        Group {
                            Image(systemName: iconName)
                                .padding(.leading, side_padding)
                            Text(title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .font(.title2)
                        .fontWeight(.medium)
                    }
                    .padding(.top, side_padding)
                    Spacer()
                }
                .frame(height: 120)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
