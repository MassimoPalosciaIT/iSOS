//
//  EmergencySelectionButton.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

struct EmergencySelectionButton: View {
    var selectedEmergency: Emergency
    @Binding var activeSheet: ActiveSheet? // Add this line
    let side_padding: CGFloat = 20
    
    var body: some View {
        NavigationLink(destination: EmergencyView(activeSheet: $activeSheet, selectedEmergecny: selectedEmergency)) {
            ZStack{
                AppStandartButton(gradientColor1: selectedEmergency.gradientColor1, gradientColor2: selectedEmergency.gradientColor2, iconName: selectedEmergency.iconName)
                
                VStack
                {
                    HStack {
                        Group {
                            Image(systemName: selectedEmergency.iconName)
                                .padding(.leading, side_padding)
                            Text(selectedEmergency.title)
                                .fontWeight(.bold)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .padding(.trailing, side_padding)
                        }
                        .font(.system(size: 26))
                        .fontWeight(.medium)
                        
                    }
                }.frame(height: 120)
            }
        }
    }
}
