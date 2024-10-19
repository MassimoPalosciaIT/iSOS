//
//  EmergencySelectionButton.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

// EmergencySelectionButton is used in main menu to select between different types of emergencies (medical, police, fire department)
struct EmergencySelectionButton: View {
    
    var selectedEmergency: Emergency
    @Binding var activeSheet: ActiveSheet?
    
    var body: some View {
        
        // Navigation link to proceed to detail View
        NavigationLink(destination: EmergencyView(activeSheet: $activeSheet, selectedEmergency: selectedEmergency)) {
            
            AppStandardButton(gradientColor1: selectedEmergency.gradientColor1, gradientColor2: selectedEmergency.gradientColor2, iconName: selectedEmergency.iconName)
                .overlay{
                    HStack {
                        Group {
                            Label(selectedEmergency.title, systemImage: selectedEmergency.iconName)
                                .fontWeight(.bold)
                            
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
}
