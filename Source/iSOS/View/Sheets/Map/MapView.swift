//
//
//
//
//
//

import SwiftUI
import MapKit

// Define a SwiftUI view for displaying a map with search functionality
struct MapView: View {
    
    // EnvironmentObject to access location data
    @EnvironmentObject var locationModel: LocationModel
    
    // State variables for managing search results, map position, selected result, route, and info view visibility
    @State private var searchResults: [MKMapItem] = []
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var selectedResult: MKMapItem?
    @State private var route: MKRoute?
    @State private var showingInfo: Bool = false
    
    // Properties for gradient colors, search query, and binding to activeSheet
    var gradientColor1: Color
    var gradientColor2: Color
    var searchQuery: String
    @Binding var activeSheet: ActiveSheet?
    
    // Computed property to format travel time for display
    private var travelTime: String? {
        // Check if there is a route available
        guard let route else { return nil }
        
        // Set up a date formatter
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        
        // Format the travel time
        return withAnimation {
            formatter.string(from: route.expectedTravelTime)
        }
    }
    
    var body: some View {
        NavigationStack {
            // Map view with markers, polyline, and user annotation
            Map(position: $position, selection: $selectedResult) {
                ForEach(searchResults, id: \.self) { result in
                    Marker(item: result)
                }
                
                // Display route polyline if available
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
                // Show info view if selected result exists and showingInfo is true
                if showingInfo {
                    if let selectedResult {
                        MapInfoView(travelTime: travelTime, selectedResult: selectedResult)
                    }
                }
            }
            // Add map controls
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            // Perform search on view appear
            .onAppear {
                search(for: searchQuery, locationModel: locationModel)
            }
            // Get directions when selected result changes
            .onChange(of: selectedResult) {
                getDirections(locationModel: locationModel)
                withAnimation {
                    showingInfo = true
                }
            }
            // Set navigation bar title and button
            .navigationBarTitle(searchQuery, displayMode: .inline)
            .navigationBarItems(
                trailing: Button(
                    action: { self.activeSheet = nil }
                ) {
                    Text("Done").bold()
                }
            )
        }
    }
    
    // Function to get directions from user's location to selected result
    func getDirections(locationModel: LocationModel) {
        route = nil
        guard let selectedResult else { return }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: locationModel.coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)))
        request.destination = selectedResult
        
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            route = response?.routes.first
        }
    }
    
    // Async function to perform search based on query and location
    @MainActor
    func search(for query: String, locationModel: LocationModel) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(
            center: locationModel.coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
            span: MKCoordinateSpan(latitudeDelta: 0.125, longitudeDelta: 0.125)
        )
        
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
}

// Preview for MapView
#Preview {
    MapView(
        gradientColor1: .redGradient1,
        gradientColor2: .redGradient2,
        searchQuery: "Hospitals",
        activeSheet: .constant(nil)
    )
    .environmentObject(LocationModel())
}
