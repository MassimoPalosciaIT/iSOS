//
//  EmergencyMenuButton.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

struct EmergencyMenuButton: View {
    
    var title: String
    var iconName: String
    var gradientColor1: Color
    var gradientColor2: Color
    var action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            
            AppStandartButton(gradientColor1: gradientColor1, gradientColor2: gradientColor2, iconName: iconName,iconOpacity: 0.12)
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
        
    }
}
