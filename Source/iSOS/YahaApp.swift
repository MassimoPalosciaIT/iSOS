//
//
//
//
//
//

import SwiftUI

// Yaha stands for:
//
// Yet
// Another
// Help
// App
//
// Yaha

@main
struct YahaApp: App {
    
    // Load Location Model
    @State var locationModel = LocationModel()
    @Environment(\.openURL) var openURL
    
    var body: some Scene {
        WindowGroup {
            Group{
                // Show view based on the state of the Location Model
                switch locationModel.authorizationStatus {
                // Location permit is not granted, asking user to allow
                case .notDetermined:
                    LocationRequestView(title: "We need your permission to track the location", symbolBackground: "location.fill", symbol: "location.circle", buttonTitle: "Continue", action: {locationModel.requestPermission()})
                // Location permit is restricted, asking user to allow in settings
                case .restricted:
                    LocationRequestView(title: "Location use is restricted", symbolBackground: "xmark", symbol: "xmark.circle", buttonTitle: "Open settings", buttonSymbol: "gearshape.fill", action: {UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)})
                // Location permit is denied, asking user to allow in settings
                case .denied:
                    LocationRequestView(title: "The app does not have location permissions", symbolBackground: "xmark", symbol: "xmark.circle", buttonTitle: "Open settings", buttonSymbol: "gearshape.fill", action: {UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)})
                // Location permit is granted and working correctly
                case .authorizedAlways, .authorizedWhenInUse:
                    ContentView()
                // Unexpected status
                default:
                    LocationRequestView(title: "Unexpected status. Please contact support", symbolBackground: "xmark", symbol: "xmark.circle", buttonTitle: "Contact support", buttonSymbol: "envelope.fill", action: {openURL(URL(string: "https://novoselov.dev")!)})
                }
            }
            .environment(locationModel)
            .preferredColorScheme(.dark)
        }
    }
}
