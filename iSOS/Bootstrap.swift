import SwiftUI

struct Bootstrap: View {
    @StateObject var locationViewModel = LocationViewModel()
    
    var body: some View {
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
                SelectionView()
            default:
                Text("Unexpected status. Contact support")
            }
        }
        .environmentObject(locationViewModel)
    }
}

#Preview {
    Bootstrap()
}
