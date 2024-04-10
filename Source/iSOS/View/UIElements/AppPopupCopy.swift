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
    let side_padding: CGFloat = 10
    
    var body: some View {
        ZStack{
            AppStandartButton(
                gradientColor1: .mainGray,
                gradientColor2: .mainGray,
                iconName: iconName,
                frameHeight: 45,
                iconOpacity: 0
            )
            
            HStack {
                Group {
                    Image(systemName: iconName)
                    Text(title)
                }
                .font(.system(size: 18))
                .fontWeight(.medium)
            }
        }
    }
}
