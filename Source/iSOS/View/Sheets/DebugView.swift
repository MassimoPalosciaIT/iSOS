//
//  DebugView.swift
//  Yaha
//
//  Created by Matt Novoselov on 27/09/24.
//

import SwiftUI

struct DebugView: View {
    
    // Get onboarding complete value from the user defaults
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(LocationModel.self) var locationModel: LocationModel
    
    var body: some View {
        
        VStack{
            VStack(alignment: .leading, spacing: 20){
                Text("AuthorizationStatus: \(locationModel.authorizationStatus)")
                Text("LastSeenLocation: \(locationModel.lastSeenLocation.debugDescription)")
                Text("CurrentPlacemark: \(locationModel.currentPlacemark.debugDescription)")
                Text("Latitude: \(locationModel.getLatitude())")
                Text("Longitude: \(locationModel.getLongitude())")
                Text("Formatted Coordinates: \(locationModel.getFormattedCoordinates())")
            }
            
            Spacer()
            
            Button("Reset Onboarding", role: .destructive) {
                presentationMode.wrappedValue.dismiss()
                isOnboarding = true
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        
    }
}

#Preview {
    DebugView()
        .environment(LocationModel())
}
