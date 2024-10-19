//
//  FlagsView.swift
//  Yaha
//
//  Created by Matt Novoselov on 18/10/24.
//

import SwiftUI

// Flags View for on top overlay of PhrasesView
struct FlagsView: View {
    
    var flag1: String
    var flag2: String
    
    var body: some View {
        VStack{
            
            HStack{
                Group{
                    Text("🇬🇧")
                    Spacer()
                    Text("🇮🇹")
                }
                .font(.system(size: 64))
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .background(.thinMaterial)
            .clipShape(.rect(cornerRadius: 10))
            
            Spacer()
            
        }
    }
}
