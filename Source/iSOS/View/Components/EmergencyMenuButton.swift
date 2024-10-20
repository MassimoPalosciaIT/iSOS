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
    var colorCombination: ColorCombination
    
    // Action that should happen after the button is pressed
    var action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            
            AppStandardButton(colorCombination: colorCombination, iconName: iconName,iconOpacity: 0.12)
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
