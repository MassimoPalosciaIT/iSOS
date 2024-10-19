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
    
    // Phone number to call to
    var callNumber: String
    
    var body: some View {
        
        Button(action: {
            // Start phone call
            startCall(to: callNumber)
            
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
        .accessibilityLabel("Call \(callNumber)")
        
    }
}

#Preview {
    AppButtonCall(gradientColor1: .redGradient1, gradientColor2: .redGradient2, callNumber: "+112")
}
