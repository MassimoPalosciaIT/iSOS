//
//  AppPopupCopy.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

struct AppPopupCopy: View {
    
    let title: String = "Coordinates copied to the clipboard"
    let iconName = "doc.on.doc.fill"
    
    var body: some View {
        
        AppStandartButton(
            gradientColor1: .mainGray,
            gradientColor2: .mainGray,
            iconName: iconName,
            frameHeight: 45,
            iconOpacity: 0
        )
        .overlay{
            Label(title, systemImage: iconName)
                .font(.headline)
                .fontWeight(.medium)
        }
        
    }
}

#Preview {
    AppPopupCopy()
}
