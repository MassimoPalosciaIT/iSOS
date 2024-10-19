//
//  NoLocationView.swift
//  Yaha
//
//  Created by Matt Novoselov on 27/08/24.
//

import SwiftUI

struct NoLocationView: View {
    
    @Environment(LocationModel.self) var locationModel: LocationModel
    
    var body: some View {
        
        VStack {
            Text("The app does not have location permissions")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Text("To provide you with accurate emergency service numbers, the app needs access to your location. This helps us determine which emergency service number is relevant for your area.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            VStack(alignment: .leading, spacing: 8) {
                Label("Your location data is not stored, shared, or transmitted.", systemImage: "lock.shield")
                    .font(.footnote)
                
                Divider()
                
                Label("Your location data is used to provide you with the correct emergency contact information.", systemImage: "info.circle")
                    .font(.footnote)
                
                Divider()
                
                Label("We respect your privacy and are committed to keeping your data secure.", systemImage: "hand.raised.fill")
                    .font(.footnote)
            }
            .padding()
            .background(.mainGray)
            .cornerRadius(10)
            
            Spacer()
            
            Button(action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }) {
                Label("Open settings", systemImage: "gearshape.fill")
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .tint(.redGradient2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background{
            TopGradient(colorCombination: .init(main: .redGradient1, secondary: .redGradient2))
        }
        .background(.mainBackground)
        
    }
}

#Preview {
    NoLocationView()
        .environment(LocationModel())
}
