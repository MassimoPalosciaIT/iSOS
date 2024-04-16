//
//
//
//
//
//

import SwiftUI
import MapKit


struct MapView: View {
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    @State private var searchResults: [MKMapItem] = []
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var selectedResult: MKMapItem?
    @State private var route: MKRoute?
    @State private var showingInfo: Bool = false
    
    var gradientColor1: Color
    var gradientColor2: Color
    var searchQuery: String
    @Binding var activeSheet: ActiveSheet?
    
    private var travelTime: String? {
        // Check if there is a route to get the info from
        guard let route else { return nil }
        
        // Set up a date formater
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        
        // Format the travel time to the format you want to display it
        return withAnimation{
            formatter.string(from: route.expectedTravelTime)
        }
    }
    
    var body: some View {
        
        NavigationStack {
            Map(position: $position, selection: $selectedResult){
                
                ForEach(searchResults, id: \.self) { result in
                    Marker(item: result)
                }
                
                if let route {
                    MapPolyline(route)
                        .stroke(
                            
                            Gradient(
                                colors: [
                                    gradientColor1, gradientColor2
                                ]
                            ),
                            
                            style: StrokeStyle(
                                lineWidth: 8,
                                lineCap: .round,
                                lineJoin: .round
                            )
                        )
                }
                
                UserAnnotation()
            }
            .safeAreaInset(edge: .bottom) {
                if showingInfo{
                    if let selectedResult{
                        MapInfoView(travelTime: travelTime, selectedResult: selectedResult)
                    }
                }
            }
            
            .mapControls{
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            
            .onAppear {
                search(for: searchQuery, locationViewModel: locationViewModel)
            }
            
            .onChange(of: selectedResult){
                getDirections(locationViewModel: locationViewModel)
                
                withAnimation{
                    showingInfo = true
                }
            }
            
            .navigationBarTitle(searchQuery, displayMode: .inline)
            
            .navigationBarItems(
                trailing: Button(
                    action: { self.activeSheet = nil }
                )
                {
                    Text("Done").bold()
                }
            )
        }
    }
    
    
    func getDirections(locationViewModel: LocationViewModel) {
        route = nil
        guard let selectedResult else { return }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: locationViewModel.coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)))
        
        request.destination = selectedResult
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            route = response?.routes.first
        }
    }
    
    
    @MainActor
    func search(for query: String, locationViewModel: LocationViewModel){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(
            center: locationViewModel.coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
            span: MKCoordinateSpan(latitudeDelta: 0.125, longitudeDelta: 0.125)
        )
        
        Task{
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
}

#Preview {
    MapView(
        gradientColor1: .redGradient1,
        gradientColor2: .redGradient2,
        searchQuery: "Hospitals",
        activeSheet: .constant(nil)
    )
    .environmentObject(LocationViewModel())
}
