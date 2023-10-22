import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Link("Hospitals nearby", destination: URL(string: maps_link(searchQuery:"Hospitals", latitude: 50.894967, longitude: 4.341626))!)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
        }
        .padding()
    }
}

func maps_link(searchQuery: String, latitude:Double, longitude:Double) -> String {
    return "http://maps.apple.com/?q=\(searchQuery)&near=\(latitude),\(longitude)&z=10&t=m"
}


#Preview {
    ContentView()
}
