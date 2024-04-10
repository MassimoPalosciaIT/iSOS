//
//
//
//
//
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    @State private var searchResults: [MKMapItem] = []
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var selectedResult: MKMapItem?
    @State private var route: MKRoute?
    @Binding var activeSheet: ActiveSheet?
    
    var searchQuery: String
    var gradientColor1: Color
    var gradientColor2: Color
    
    init(gradientColor1: Color, gradientColor2: Color, searchQuery: String, activeSheet: Binding<ActiveSheet?>) {
        self._activeSheet = activeSheet
        self.gradientColor1 = gradientColor1
        self.gradientColor2 = gradientColor2
        self.searchQuery = searchQuery
    }
    
    private var travelTime: String? {
        // Check if there is a route to get the info from
        guard let route else { return nil }
    
        // Set up a date formater
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
    
        // Format the travel time to the format you want to display it
        return formatter.string(from: route.expectedTravelTime)
    }
    
    var body: some View {
        NavigationView {
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
                if selectedResult != nil{
                    HStack{
                        Spacer()
                        Image(systemName: "car.fill")
                        Text(travelTime ?? "0m")
                        Spacer()
                    }
                    .padding()
                    .background(.thinMaterial)
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
            }
            
            .navigationBarTitle(Text(searchQuery), displayMode: .inline)
            
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
