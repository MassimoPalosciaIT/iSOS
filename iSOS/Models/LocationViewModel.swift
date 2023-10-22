import CoreLocation


class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastSeenLocation: CLLocation?
    @Published var currentPlacemark: CLPlacemark?
    
    private let locationManager: CLLocationManager
    
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastSeenLocation = locations.first
        fetchCountryAndCity(for: locations.first)
    }
    
    func fetchCountryAndCity(for location: CLLocation?) {
        guard let location = location else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            self.currentPlacemark = placemarks?.first
        }
    }
    
    func getLatitude() -> String {
        return String(self.coordinate?.latitude ?? 0)
    }
    
    func getLongitude() -> String {
        return String(self.coordinate?.longitude ?? 0)
    }
    
    func getCountry() -> String {
        return self.currentPlacemark?.country ?? "No country"
    }
    
    func getFormattedCoordinates() -> String {
        guard let coordinate = self.coordinate else {
            return "00°00'00.00\"N 00°00'00.00\"E"
        }
        
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        
        func format(coordinate: Double, positive: String, negative: String) -> String {
            let isPositive = coordinate >= 0
            let absoluteValue = abs(coordinate)
            
            let degrees = Int(absoluteValue)
            let minutesDouble = (absoluteValue - Double(degrees)) * 60.0
            let minutes = Int(minutesDouble)
            let seconds = (minutesDouble - Double(minutes)) * 60.0
            
            let direction = isPositive ? positive : negative
            
            return String(format: "%02d°%02d'%05.2f\"%@", degrees, minutes, seconds, direction)
        }
        
        let latitudeString = format(coordinate: latitude, positive: "N", negative: "S")
        let longitudeString = format(coordinate: longitude, positive: "E", negative: "W")
        
        return "\(latitudeString) \(longitudeString)"
    }

    
    var coordinate: CLLocationCoordinate2D? {
        self.lastSeenLocation?.coordinate
    }
}
