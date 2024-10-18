//
//  AppButtonCall.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

struct AppButtonCall: View {
    
    // Colors for button fill
    var gradientColor1: Color
    var gradientColor2: Color
    var emergencyType: EmergencyType
    
    @Environment(LocationModel.self) var locationModel: LocationModel
    
    var body: some View {
        
        let emergencyNumber: String = getEmergencyNumber(for: locationModel.getCountry(), emergencyType: emergencyType)
        
        Button(action: {
            startCall(to: emergencyType, locationModel: locationModel)
            
            // Play medium haptic feedback
            mediumHaptic()
        })
        {
            Circle()
                .fill(LinearGradient(colors: [gradientColor1, gradientColor2], startPoint: .top, endPoint: .bottom))
                .frame(height: 165)
                .shadow(color: gradientColor1.opacity(0.8), radius: 50)
                .overlay{
                    Image(systemName: "phone.fill")
                        .font(.system(size: 64))
                }
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel("Call \(emergencyNumber)")
        
    }
}
