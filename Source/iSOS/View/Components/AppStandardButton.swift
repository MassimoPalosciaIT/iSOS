//
//  AppStandardButton.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

// App standard button is a base of all main buttons in the app
struct AppStandardButton: View {
    
    // Colors of the button
    var colorCombination: ColorCombination
    
    // Icon name for the trailing SF Symbol
    var iconName: String
    
    // Height of the button
    var frameHeight: Double = 120
    
    // Opacity of the trailing SF Symbol
    var iconOpacity: Double = 0.15
    
    // Corner radius of the button
    let cornerRadius: Double = 20
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(LinearGradient(colors: [colorCombination.main, colorCombination.secondary], startPoint: .leading, endPoint: .trailing))
            .frame(height: frameHeight)
            .overlay(
                HStack {
                    Spacer()
                    Image(systemName: iconName)
                        .opacity(iconOpacity)
                        .font(.system(size: 130))
                        .padding(.trailing, -35)
                }
            )
            .clipShape(.rect(cornerRadius: cornerRadius))
        
    }
}

#Preview {
    AppStandardButton(colorCombination: ColorCombination(main: .redGradient1, secondary: .redGradient2), iconName: "xmark", frameHeight: 120, iconOpacity: 1.0)
}
