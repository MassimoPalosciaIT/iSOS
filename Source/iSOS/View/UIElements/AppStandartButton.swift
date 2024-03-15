//
//  AppStandartButton.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

struct AppStandartButton: View {
    var gradientColor1: Color
    var gradientColor2: Color
    var iconName: String
    var frameHeight: Double = 120
    var iconSize: Int = 130
    var iconOpacity: Double = 0.15
    let cornerRadius: Double = 20
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(LinearGradient(colors: [gradientColor1, gradientColor2], startPoint: .leading, endPoint: .trailing))
            .frame(height: frameHeight)
            .overlay(
                HStack() {
                    Spacer()
                    Image(systemName: iconName)
                        .opacity(iconOpacity)
                        .font(.system(size: CGFloat(iconSize)))
                        .padding(.trailing, -35)
                }.mask(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(height: frameHeight)
                )
            )
    }
}
