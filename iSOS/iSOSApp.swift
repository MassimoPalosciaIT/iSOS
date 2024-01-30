import SwiftUI

@main
struct iSOSApp: App {
    @StateObject var locationViewModel = LocationViewModel()
    @State private var result: (Bool, String?) = (false, nil)
    
    var body: some Scene {
        WindowGroup {
            Group{
                if result.0 == true{
                    ErrorView(errorText: "The app is not available in your country.\n\n\(String(describing: result.1 ?? ""))", locationError: false)
                }
                else{
                    switch locationViewModel.authorizationStatus {
                    case .notDetermined:
                        AnyView(RequestLocationView())
                            .environmentObject(locationViewModel)
                    case .restricted:
                        ErrorView(errorText: "Location use is restricted")
                    case .denied:
                        ErrorView(errorText: "The app does not have location permissions")
                    case .authorizedAlways, .authorizedWhenInUse:
                        SelectionView()
                    default:
                        Text("Unexpected status. Contact support")
                    }
                }
            }
            .environmentObject(locationViewModel)
            .preferredColorScheme(.dark)
            .onAppear {
                self.result = checkHash()
            }
        }
    }
}
