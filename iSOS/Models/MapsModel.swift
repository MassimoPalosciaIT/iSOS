import SwiftUI

func open_link(searchQuery: String, locationViewModel: LocationViewModel) {
    
    let latitude = locationViewModel.getLatitude()
    let longitude = locationViewModel.getLongitude()
    
    guard let url = URL(string: "http://maps.apple.com/?q=\(searchQuery)&near=\(latitude),\(longitude)&z=10&t=m") else { return }
    UIApplication.shared.open(url)
}

func testTap(){
    print("Test tap")
}
