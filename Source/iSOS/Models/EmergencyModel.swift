//
//
//
//
//
//

import SwiftUI

// Model for Emergency (in app present as Medical help, Police, Fire department)
struct Emergency: Identifiable {
    var id = UUID()
    
    // Each Emergency should have title
    var title: String
    
    // SF Symbol name for main menu card
    var iconName: String
    
    // Gradient colors for branding of detail view and menu card
    var gradientColor1: Color
    var gradientColor2: Color
    
    // Specified emergency Type (police, medicalHelp, fireDepartment)
    var emergencyType: EmergencyType
    
    // Menus of type EmergencyMenu for Detail View
    var menus: [EmergencyMenu]
    
    // Query to search for authority location using the MapsKit. Example: "Hospitals"
    var mapSearchQuery: String
}
