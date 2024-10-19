//
//  TopGradient.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

// Top gradient is used on the background of al main views
struct TopGradient: View {
    
    var colorCombination: ColorCombination
    
    var body: some View {
        
        VStack{
            LinearGradient(colors: [colorCombination.main, colorCombination.secondary.opacity(0)], startPoint: .top, endPoint: .bottom)
                .frame(height: 270)
                .ignoresSafeArea()
                .opacity(0.7)
            
            Spacer()
        }
        
    }
}

#Preview {
    TopGradient(colorCombination: ColorCombination(main: .redGradient1, secondary: .redGradient2))
}
