//
//  EmergencyMenuButton.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

// EmergencyMenuButtons are used in Detail View of selected emergency
struct EmergencyMenuButton: View {
    
    var title: String
    var iconName: String
    
    // Colors of the button
    var gradientColor1: Color
    var gradientColor2: Color
    
    // Action that should happen after the button is pressed
    var action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            
            AppStandardButton(gradientColor1: gradientColor1, gradientColor2: gradientColor2, iconName: iconName,iconOpacity: 0.12)
                .overlay{
                    VStack{
                        HStack{
                            Label(title, systemImage: iconName)
                                .fontWeight(.bold)
                                .font(.title3)
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                    .padding()
                }
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityElement()
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(title)
        
    }
}
