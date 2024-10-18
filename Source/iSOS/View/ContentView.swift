//
//
//
//
//
//

import SwiftUI

struct ContentView: View {
    
    @Environment(LocationModel.self) var locationModel: LocationModel
    
    // Get onboarding complete value from the user defaults
    @AppStorage("isOnboarding") var showingTutorialSheet: Bool = true
    
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
                                                colorCombination: .init(main: .redGradient1, secondary: .redGradient2),
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
                                                colorCombination: .init(main: .orangeGradient1, secondary: .orangeGradient2),
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
                                                colorCombination: .init(main: .blueGradient1, secondary: .blueGradient2),
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
                TopGradient(colorCombination: .init(main: .redGradient1, secondary: .redGradient2))
            }
            .background(.mainBackground)
            .navigationTitle("Need help?")
            
        }
        
        // Sheet with tutorial / onboarding
        // Only present the first time user opens app
        .sheet(isPresented: $showingTutorialSheet) {
            TutorialView()
        }
        
    }
}

#Preview {
    ContentView()
        .environment(LocationModel())
}
