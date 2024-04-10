//
//  AppPopupButton.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

struct AppPopupButton: View {
    var backgrpundColor: Color = .mainGray
    let cornerRadius: Double = 20
    var iconName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(backgrpundColor)
            .aspectRatio(1.0, contentMode: .fit)
            .overlay(
                HStack() {
                    Spacer()
                    Image(systemName: iconName)
                        .fontWeight(.black)
                        .opacity(0.02)
                        .font(.system(size: 300))
                        .padding(.trailing, -100)
                }.mask(
                    RoundedRectangle(cornerRadius: cornerRadius)
                )
            )
    }
}
