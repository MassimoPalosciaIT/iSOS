import SwiftUI
import CoreLocation

struct Bootstrap: View {
    @StateObject var locationViewModel = LocationModel()
    
    var body: some View {
        switch locationViewModel.authorizationStatus {
        case .notDetermined:
            AnyView(RequestLocationView())
                .environmentObject(locationViewModel)
        case .restricted:
            ErrorView(errorText: "Location use is restricted.")
        case .denied:
            ErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
        case .authorizedAlways, .authorizedWhenInUse:
            SelectionView()
                .environmentObject(locationViewModel)
        default:
            Text("Unexpected status")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Bootstrap()
    }
}
