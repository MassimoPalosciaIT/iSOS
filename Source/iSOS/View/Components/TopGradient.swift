//
//  TopGradient.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

// Top gradient is used on the background of al main views
struct TopGradient: View {
    
    var gradientColor1: Color
    var gradientColor2: Color
    
    var body: some View {
        
        VStack{
            LinearGradient(colors: [gradientColor1, gradientColor2.opacity(0)], startPoint: .top, endPoint: .bottom)
                .frame(height: 270)
                .ignoresSafeArea()
                .opacity(0.7)
            
            Spacer()
        }
        
    }
}

#Preview {
    TopGradient(gradientColor1: .redGradient1, gradientColor2: .redGradient2)
}
