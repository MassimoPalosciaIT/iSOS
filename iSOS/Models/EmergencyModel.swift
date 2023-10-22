import Foundation
import SwiftUI

struct Emergency: Identifiable {
    var id = UUID()
    var title: String
    var iconName: String
    var gradientColor1: Color
    var gradientColor2: Color
    var emergencyType: EmergencyType
    var menus: [EmergencyMenu]
}
