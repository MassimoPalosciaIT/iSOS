import Foundation
import CoreLocation

class LocationModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastSeenLocation: CLLocation?
    @Published var currentPlacemark: CLPlacemark?
    private let locationManager: CLLocationManager
    
    var coordinate: CLLocationCoordinate2D? {
        lastSeenLocation?.coordinate
    }

    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 0.4
        locationManager.startUpdatingLocation()
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
    }

    func fetchCountryAndCity(for location: CLLocation?) {
        guard let location = location else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Error geocoding location: \(error.localizedDescription)")
                return
            }
            self.currentPlacemark = placemarks?.first
        }
    }
    ///
    public func getLatitude() -> String {
        return String(coordinate?.latitude ?? 0)
    }

    func getLongitude() -> String {
        return String(coordinate?.longitude ?? 0)
    }

    func getCountry() -> String {
        return currentPlacemark?.country ?? "No country found"
    }
    ///
}
