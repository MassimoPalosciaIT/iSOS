//
//  AppButtonCall.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

struct AppButtonCall: View {
    var callModel: CallModel = CallModel()
    var gradientColor1: Color
    var gradientColor2: Color
    var callNumber: String
    let iconName: String = "phone.fill"
    
    var body: some View {
        Button(action: {
            callModel.startCall(to: callNumber)
            mediumHaptic()
        }) {
            ZStack{
                Circle()
                    .fill(LinearGradient(colors: [gradientColor1, gradientColor2], startPoint: .top, endPoint: .bottom))
                    .frame(height: 165)
                    .shadow(color: gradientColor1.opacity(0.8), radius: 50)
                
                Image(systemName: iconName)
                    .font(.system(size: 64))
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
