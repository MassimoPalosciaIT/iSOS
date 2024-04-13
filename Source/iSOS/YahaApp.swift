//
//
//
//
//
//

import SwiftUI

@main
struct YahaApp: App {
    
    @StateObject var locationViewModel = LocationViewModel()
    @Environment(\.openURL) var openURL
    
    var body: some Scene {
        WindowGroup {
            Group{
                switch locationViewModel.authorizationStatus {
                case .notDetermined:
                    LocationRequestView(title: "We need your permission to track the location", symbolBackground: "location.fill", symbol: "location.circle", buttonTitle: "Allow tracking", buttonSymbol: "location.fill", action: {locationViewModel.requestPermission()})
                case .restricted:
                    LocationRequestView(title: "Location use is restricted", symbolBackground: "xmark", symbol: "xmark.circle", buttonTitle: "Open settings", buttonSymbol: "gearshape.fill", action: {UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)})
                case .denied:
                    LocationRequestView(title: "The app does not have location permissions", symbolBackground: "xmark", symbol: "xmark.circle", buttonTitle: "Open settings", buttonSymbol: "gearshape.fill", action: {UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)})
                case .authorizedAlways, .authorizedWhenInUse:
                    ContentView()
                default:
                    LocationRequestView(title: "Unexpected status. Please contact support", symbolBackground: "xmark", symbol: "xmark.circle", buttonTitle: "Contact support", buttonSymbol: "envelope.fill", action: {openURL(URL(string: "https://novoselov.dev")!)})
                }
            }
            .environmentObject(locationViewModel)
            .preferredColorScheme(.dark)
        }
    }
}
