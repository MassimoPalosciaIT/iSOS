//
//  AppPopupButton.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

// App Popup button is used to grant permissions or indicate that location permit is denied
struct AppPopupButton: View {
    
    var backgroundColor: Color = .mainGray
    let cornerRadius: Double = 20
    var iconName: String
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 20)
            .fill(backgroundColor)
            .aspectRatio(1.0, contentMode: .fit)
            .overlay{
                HStack {
                    Spacer()
                    Image(systemName: iconName)
                        .fontWeight(.black)
                        .opacity(0.02)
                        .font(.system(size: 300))
                        .padding(.trailing, -100)
                }
            }
            .clipped()
        
    }
}

#Preview {
    AppPopupButton(backgroundColor: .mainBackground, iconName: "xmark")
}
