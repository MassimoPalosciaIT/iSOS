//
//
//
//
//
//

import CoreLocation
import SwiftUI


// Location Model that is responsible for determining current position of the user
@Observable
class LocationModel: NSObject, CLLocationManagerDelegate {
    
    // Status of the Location Model
   var authorizationStatus: CLAuthorizationStatus
    
    // Last seen location of the user
    var lastSeenLocation: CLLocation?
    
    // Current selected placemark
    var currentPlacemark: CLPlacemark?
    
    private let locationManager: CLLocationManager
    
    // Initiate Model
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 0.4
        locationManager.startUpdatingLocation()
    }
    
    // Function to request permission for using location services.
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Callback function triggered when the authorization status for location manager changes.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    // Callback function triggered when the location manager receives updated locations.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Update the last seen location with the first location received in the array.
        lastSeenLocation = locations.first
    }
    
    // Function to get the latitude of the last seen location as a string.
    func getLatitude() -> String {
        return String(self.coordinate?.latitude ?? 0)
    }
    
    // Function to get the longitude of the last seen location as a string.
    func getLongitude() -> String {
        return String(self.coordinate?.longitude ?? 0)
    }
    
    // Function to get current address based on the location, returns nil if unable to determine exact location up to the house number
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
            // Get thoroughfare
            if let thoroughfare = placemark.thoroughfare {
                addressString += thoroughfare + ", "
            } else{
                completion(nil)
                return
            }
            // Get sub thoroughfare
            if let subThoroughfare = placemark.subThoroughfare {
                addressString += subThoroughfare + ", "
            } else{
                completion(nil)
                return
            }
            // Get locality
            if let locality = placemark.locality {
                addressString += locality
            } else{
                completion(nil)
                return
            }
            
            completion(addressString)
        }
    }
    
    // Function to get formatted coordinates based on latitude and longitude.
    func getFormattedCoordinates() -> String {
        // Check if the coordinate is available.
        guard let coordinate = self.coordinate else {
            // Return default formatted coordinates if coordinate is nil.
            return "00°00'00.00\"N 00°00'00.00\"E"
        }
        
        // Extract latitude and longitude from the coordinate.
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        
        // Inner function to format a coordinate.
        func format(coordinate: Double, positive: String, negative: String) -> String {
            // Determine if the coordinate is positive or negative.
            let isPositive = coordinate >= 0
            let absoluteValue = abs(coordinate)
            
            // Calculate degrees, minutes, and seconds.
            let degrees = Int(absoluteValue)
            let minutesDouble = (absoluteValue - Double(degrees)) * 60.0
            let minutes = Int(minutesDouble)
            let seconds = (minutesDouble - Double(minutes)) * 60.0
            
            // Determine the direction based on positivity.
            let direction = isPositive ? positive : negative
            
            // Format and return the coordinate string.
            return String(format: "%02d°%02d'%05.2f\"%@", degrees, minutes, seconds, direction)
        }
        
        // Format latitude and longitude strings using the inner function.
        let latitudeString = format(coordinate: latitude, positive: "N", negative: "S")
        let longitudeString = format(coordinate: longitude, positive: "E", negative: "W")
        
        // Return the formatted coordinates string.
        return "\(latitudeString) \(longitudeString)"
    }
    
    // Function to get country based on current latitude and longitude
    func getCountry() -> String {
        let coordinate = CLLocationCoordinate2D(
            latitude: (self.coordinate?.latitude ?? 0),
            longitude: (self.coordinate?.longitude ?? 0)
        )
        guard let reverseGeocoding = APReverseGeocoding.default(),
              let country = reverseGeocoding.geocodeCountry(with: coordinate) else {
            return "Could not perform geocoding for the given coordinates."
        }
        
        return country.name
    }
    
    var coordinate: CLLocationCoordinate2D? {
        self.lastSeenLocation?.coordinate
    }
}
