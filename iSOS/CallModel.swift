import Foundation
import SwiftUI

struct CallModel{
    func startCall(to number: String) {
        guard let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) else {
            print("Error: Unable to initiate call.")
            return
        }
        
        UIApplication.shared.open(url)
    }
}
