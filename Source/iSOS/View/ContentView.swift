//
//
//
//
//
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var locationModel: LocationModel
    
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
                                                title: "Ambulance",
                                                iconName: "cross.fill",
                                                gradientColor1: .redGradient1,
                                                gradientColor2: .redGradient2,
                                                emergencyType: EmergencyType.medicalHelp,
                                                menus: [
                                                    EmergencyMenu(title: "First Aid", iconName: "cross.case.fill", action: {
                                                        self.activeSheet = .firstAid
                                                    }),
                                                    EmergencyMenu(title: "Hospitals", iconName: "building.2.fill",  action: {
                                                        self.activeSheet = .maps
                                                    }),
                                                    EmergencyMenu(title: "Conversation", iconName: "text.bubble.fill", action: {
                                                        self.activeSheet = .conversation
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
                                                    EmergencyMenu(title: "First Aid", iconName: "cross.case.fill", action: {
                                                        self.activeSheet = .firstAid
                                                    }),
                                                    EmergencyMenu(title: "Conversation", iconName: "text.bubble.fill", action: {
                                                        self.activeSheet = .conversation
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
                                                    EmergencyMenu(title: "Conversation", iconName: "text.bubble.fill", action: {
                                                        self.activeSheet = .conversation
                                                    }),
                                                ],
                                                mapSearchQuery: "Police Stations"
                                            ), activeSheet: $activeSheet
                )
                
                Spacer()
                
                // Location button
                LocationButton()
            }
            .padding(.horizontal)
            .padding(.top)
            .background{
                TopGradient(gradientColor1: .redGradient1, gradientColor2: .redGradient2)
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
        .environmentObject(LocationModel())
}
