//
//
//
//
//
//

import SwiftUI

struct EmergencySelectionView: View {
    
    @Environment(LocationModel.self) var locationModel: LocationModel
    
    // Hold active opened sheet for emergency detail view
    @State private var activeSheet: ActiveSheet?
    
    var body: some View {
        
        NavigationStack{
            VStack{
                // MARK:
                // Define structure for Medical Help Button
                EmergencySelectionButton(selectedEmergency:
                                            Emergency(
                                                title: "Medical Help",
                                                iconName: "cross.fill",
                                                gradientColor1: .redGradient1,
                                                gradientColor2: .redGradient2,
                                                emergencyType: EmergencyType.medicalHelp,
                                                menus: [
                                                    EmergencyMenu(title: "Hospitals", iconName: "building.2.fill",  action: {
                                                        self.activeSheet = .maps
                                                    }),
                                                    EmergencyMenu(title: "Emergency Phrases", iconName: "text.bubble.fill", action: {
                                                        self.activeSheet = .phrases
                                                    }),
                                                ],
                                                mapSearchQuery: "Hospitals"
                                            ), activeSheet: $activeSheet
                )
                
                // Define structure for Fire department Help Button
                EmergencySelectionButton(selectedEmergency:
                                            Emergency(
                                                title: "Fire department",
                                                iconName: "flame.fill",
                                                gradientColor1: .orangeGradient1,
                                                gradientColor2: .orangeGradient2,
                                                emergencyType: EmergencyType.fireDepartment,
                                                menus: [
                                                    EmergencyMenu(title: "Emergency Phrases", iconName: "text.bubble.fill", action: {
                                                        self.activeSheet = .phrases
                                                    }),
                                                ],
                                                mapSearchQuery: "Fire department"
                                            ), activeSheet: $activeSheet
                )
                
                // Define structure for Police Help Button
                EmergencySelectionButton(selectedEmergency:
                                            Emergency(
                                                title: "Police",
                                                iconName: "shield.righthalf.filled",
                                                gradientColor1: .blueGradient1,
                                                gradientColor2: .blueGradient2,
                                                emergencyType: EmergencyType.police,
                                                menus: [
                                                    EmergencyMenu(title: "Stations", iconName: "house.lodge.fill",  action: {
                                                        self.activeSheet = .maps
                                                    }),
                                                    EmergencyMenu(title: "Emergency Phrases", iconName: "text.bubble.fill", action: {
                                                        self.activeSheet = .phrases
                                                    }),
                                                ],
                                                mapSearchQuery: "Police Stations"
                                            ), activeSheet: $activeSheet
                )
                
                Spacer()
                
                // Location button
                LocationButton()
            }
            .padding()
            .background{
                TopGradient(gradientColor1: .redGradient1, gradientColor2: .redGradient2)
            }
            .background(.mainBackground)
            .navigationTitle("Need help?")
            
        }
        
    }
}

#Preview {
    EmergencySelectionView()
        .environment(LocationModel())
}
