//
//  TopGradient.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

struct TopGradient: View {
    var gradientColor1: Color = .pink
    var gradientColor2: Color = .pink
    
    var body: some View {
        VStack {
            LinearGradient(colors: [gradientColor1, gradientColor2.opacity(0)], startPoint: .top, endPoint: .bottom)
                .frame(height: 270)
                .ignoresSafeArea()
                .opacity(0.7)
            Spacer()
        }
    }
}
