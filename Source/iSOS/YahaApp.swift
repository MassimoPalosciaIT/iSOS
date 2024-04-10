import SwiftUI

@main
struct YahaApp: App {
    @StateObject var locationViewModel = LocationViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group{
                switch locationViewModel.authorizationStatus {
                case .notDetermined:
                    AnyView(RequestLocationView())
                        .environmentObject(locationViewModel)
                case .restricted:
                    ErrorView(errorText: "Location use is restricted")
                case .denied:
                    ErrorView(errorText: "The app does not have location permissions")
                case .authorizedAlways, .authorizedWhenInUse:
                    ContentView()
                default:
                    Text("Unexpected status. Contact support")
                }
            }
            .environmentObject(locationViewModel)
            .preferredColorScheme(.dark)
        }
    }
}
