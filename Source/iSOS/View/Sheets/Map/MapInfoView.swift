//
//  MapInfo.swift
//  Yaha
//
//  Created by Matt Novoselov on 13/04/24.
//

import SwiftUI
import MapKit

struct MapInfoView: View {
    
    var travelTime: String?
    @State private var computedTravelTime: String = "0m"
    @State var isFirstRouteComputed: Bool = false
    
    var selectedResult: MKMapItem
    
    @State var showingOptions: Bool = false
    @State var handlers: [(String, URL)] = []
    
    var body: some View {
        
        Button(action: {openMaps(latitude: selectedResult.placemark.coordinate.latitude, longitude: selectedResult.placemark.coordinate.longitude, title: selectedResult.placemark.title)}) {
            HStack{
                Text("Get Directions")
                    .fontWeight(.medium)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .overlay{
                if isFirstRouteComputed{
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
            .onChange(of: travelTime){
                if let travelTime {
                    withAnimation {
                        isFirstRouteComputed = true
                        
                        computedTravelTime = travelTime
                    }
                }
            }
            .confirmationDialog("Select an app to open location", isPresented: $showingOptions, titleVisibility: .visible) {
                ForEach(handlers, id: \.0) { singleHandler in
                    Button(singleHandler.0) {
                        UIApplication.shared.open(singleHandler.1)
                    }
                }
            }
            
        }
    }
    
    func openMaps(latitude: Double, longitude: Double, title: String?) {
        let application = UIApplication.shared
        let coordinate = "\(latitude),\(longitude)"
        let encodedTitle = title?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let handlers = [
            ("Apple Maps", "http://maps.apple.com/?q=\(encodedTitle)&ll=\(coordinate)"),
            ("Google Maps", "comgooglemaps://?q=\(coordinate)"),
            ("Waze", "waze://?ll=\(coordinate)"),
            ("Citymapper", "citymapper://directions?endcoord=\(coordinate)&endname=\(encodedTitle)")
        ]
            .compactMap { (name, address) in URL(string: address).map { (name, $0) } }
            .filter { (_, url) in application.canOpenURL(url) }
        
        guard handlers.count > 1 else {
            if let (_, url) = handlers.first {
                application.open(url, options: [:])
            }
            return
        }
        
        self.handlers = handlers
        showingOptions = true
        
    }
}
