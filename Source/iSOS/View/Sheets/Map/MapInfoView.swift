//
//  MapInfo.swift
//  Yaha
//
//  Created by Matt Novoselov on 13/04/24.
//

import SwiftUI

struct MapInfoView: View {
    
    var travelTime: String?
    
    var body: some View {
        
        HStack{
//            Text("Directions")
//                .fontWeight(.bold)
//            
//            Spacer()
            
            Image(systemName: "car.fill")
            
            Text(travelTime ?? "0m")
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.thinMaterial)
        .clipShape(.rect(cornerRadius: 90))
        .padding()
        .transition(.move(edge: .bottom))
        
    }
    
}

#Preview {
    MapInfoView()
}
