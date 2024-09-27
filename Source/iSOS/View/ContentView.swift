//
//  ContentView.swift
//  Yaha
//
//  Created by Matt Novoselov on 26/09/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(LocationModel.self) var locationModel: LocationModel
    @Environment(\.openURL) var openURL
    
    var body: some View {
        
        // Show view based on the state of the Location Model
        switch locationModel.authorizationStatus {
        // Location permit is not granted, asking user to allow
        case .notDetermined:
            LocationRequestView(title: "We need your permission to track the location", symbolBackground: "location.fill", symbol: "location.circle", buttonTitle: "Continue", action: {locationModel.requestPermission()})
        // Location permit is restricted or denied
        case .restricted, .denied:
            NoLocationView()
        // Location permit is granted and working correctly
        case .authorizedAlways, .authorizedWhenInUse:
            EmergencySelectionView()
        // Unexpected status
        default:
            LocationRequestView(title: "Unexpected status. Please contact support", symbolBackground: "xmark", symbol: "xmark.circle", buttonTitle: "Contact support", buttonSymbol: "envelope.fill", action: {openURL(URL(string: "https://novoselov.dev")!)})
        }
        
    }
}
