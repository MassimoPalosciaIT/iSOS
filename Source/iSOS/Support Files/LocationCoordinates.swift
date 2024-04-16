//
//
//
//
//
//

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
    }
    
    func getLatitude() -> String {
        return String(self.coordinate?.latitude ?? 0)
    }
    
    func getLongitude() -> String {
        return String(self.coordinate?.longitude ?? 0)
    }
    
    func getAddress(completion: @escaping (String?) -> Void) {
        guard let location = lastSeenLocation else {
            completion(nil)
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                completion(nil)
                return
            }
            
            // Construct the address string
            var addressString = ""
            if let thoroughfare = placemark.thoroughfare {
                addressString += thoroughfare + ", "
            } else{
                completion(nil)
                return
            }
            if let subThoroughfare = placemark.subThoroughfare {
                addressString += subThoroughfare + ", "
            } else{
                completion(nil)
                return
            }
            if let locality = placemark.locality {
                addressString += locality
            } else{
                completion(nil)
                return
            }
            
            completion(addressString)
        }
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
    
    func getCountry() -> String {
        let coordinate = CLLocationCoordinate2D(
            latitude: (self.coordinate?.latitude ?? 0),
            longitude: (self.coordinate?.longitude ?? 0)
        )
        guard let reverseGeocoding = APReverseGeocoding.default(),
              let country = reverseGeocoding.geocodeCountry(with: coordinate) else {
            return "Could not perform geocoding for the given coordinates."
        }
        
        return country.name ?? "No country"
    }
    
    var coordinate: CLLocationCoordinate2D? {
        self.lastSeenLocation?.coordinate
    }
}
