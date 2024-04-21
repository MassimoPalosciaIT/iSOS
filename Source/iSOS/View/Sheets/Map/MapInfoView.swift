//
//  MapInfo.swift
//  Yaha
//
//  Created by Matt Novoselov on 13/04/24.
//

import SwiftUI
import MapKit

struct MapInfoView: View {
    
    // Optional travel time
    var travelTime: String?
    
    // State variables
    @State private var computedTravelTime: String = "0m" // Initially set to "0m"
    @State var isFirstRouteComputed: Bool = false // Initially false
    
    // Selected map item
    var selectedResult: MKMapItem
    
    // State for showing options
    @State var showingOptions: Bool = false
    
    // Array to hold handlers
    @State var handlers: [(String, URL)] = []
    
    var body: some View {
        
        // Button to get directions
        Button(action: {
            openMaps(latitude: selectedResult.placemark.coordinate.latitude, longitude: selectedResult.placemark.coordinate.longitude, title: selectedResult.placemark.title)
        }) {
            HStack{
                Text("Get Directions")
                    .fontWeight(.medium)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .overlay{
                // Display computed travel time if available
                if isFirstRouteComputed {
                    HStack{
                        Spacer()
                        
                        HStack{
                            Image(systemName: "car.fill")
                            
                            Text(computedTravelTime)
                                .contentTransition(.numericText())
                        }
                        .padding()
                        .background(.gray.opacity(0.2))
                        .clipShape(.rect(cornerRadius: 90))
                    }
                    .transition(.move(edge: .trailing))
                }
                
            }
            .background(.thinMaterial)
            .clipShape(.rect(cornerRadius: 90))
            .shadow(color: .black.opacity(0.4), radius: 10)
            .padding()
            .transition(.move(edge: .bottom))
            .onChange(of: travelTime) { // Triggered when travelTime changes
                if let travelTime { // If travelTime is not nil
                    withAnimation { // Animate the change
                        isFirstRouteComputed = true // Set isFirstRouteComputed to true
                        computedTravelTime = travelTime // Update computedTravelTime
                    }
                }
            }
            .confirmationDialog("Select an app to open location", isPresented: $showingOptions, titleVisibility: .visible) {
                // Dialog to select map app
                ForEach(handlers, id: \.0) { singleHandler in
                    Button(singleHandler.0) {
                        UIApplication.shared.open(singleHandler.1)
                    }
                }
            }
            
        }
    }
    
    // Function to open maps with given coordinates and title
    func openMaps(latitude: Double, longitude: Double, title: String?) {
        let application = UIApplication.shared
        let coordinate = "\(latitude),\(longitude)"
        let encodedTitle = title?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        // Supported map handlers with their respective URLs
        let handlers = [
            ("Apple Maps", "http://maps.apple.com/?q=\(encodedTitle)&ll=\(coordinate)"),
            ("Google Maps", "comgooglemaps://?q=\(coordinate)"),
            ("Waze", "waze://?ll=\(coordinate)"),
            ("Citymapper", "citymapper://directions?endcoord=\(coordinate)&endname=\(encodedTitle)")
        ]
            // Convert URLs to URL objects and filter out unsupported URLs
            .compactMap { (name, address) in URL(string: address).map { (name, $0) } }
            .filter { (_, url) in application.canOpenURL(url) }
        
        // If there are multiple handlers available, show options dialog
        guard handlers.count > 1 else {
            if let (_, url) = handlers.first {
                application.open(url, options: [:])
            }
            return
        }
        
        // Set handlers and show options dialog
        self.handlers = handlers
        showingOptions = true
        
    }
}
