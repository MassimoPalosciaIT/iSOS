import SwiftUI

struct ContentView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    @AppStorage("isOnboarding") var showingTutorialSheet: Bool = true
    @State private var activeSheet: ActiveSheet?
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        
        let titleFontSize: CGFloat = 28.0
        let titleFont = UIFont.boldSystemFont(ofSize: titleFontSize)
        navBarAppearance.titleTextAttributes = [
            .font: titleFont
        ]
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                TopGradient(gradientColor1: .redGradient1, gradientColor2: .redGradient2)
                VStack(spacing: 10) {
                    
                    EmergencySelectionButton(selectedEmergency:
                                                Emergency(
                                                    title: "Medical help",
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
                    
                    LocationButton()
                }
                .padding(.horizontal)
                .padding(.top, 10.0)
            }
            .frame(maxHeight: .infinity)
            .background(Color.mainBackground.ignoresSafeArea())
            .navigationTitle("Need help?")
            
        }
        .sheet(isPresented: $showingTutorialSheet) {
            TutorialView()
        }
    }
}

#Preview {
    ContentView().environmentObject(LocationViewModel())
}
