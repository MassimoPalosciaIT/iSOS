import SwiftUI

struct SelectionView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        let titleFontSize: CGFloat = 28.0
        let titleFont = UIFont.boldSystemFont(ofSize: titleFontSize)
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: titleFont
        ]
    }

    var body: some View {
        NavigationStack{
            VStack {
                ZStack{
                    TopGradient(gradientColor1: Color.redGradient1, gradientColor2: Color.redGradient2)
                    VStack(spacing: 10) {
                        
                        EmergencySelectionButton(selectedEmergency:
                            Emergency(
                                title: "Medical help",
                                iconName: "cross.fill",
                                gradientColor1: Color.redGradient1,
                                gradientColor2: Color.redGradient2,
                                emergencyType: EmergencyType.medicalHelp,
                                menus: [
                                    EmergencyMenu(title: "First Aid", iconName: "cross.case.fill", action: test_tap),
                                    EmergencyMenu(title: "Hospitals", iconName: "building.2.fill",  action: {
                                        open_link(searchQuery: "Hospitals", locationViewModel: locationViewModel)
                                    }),
                                    EmergencyMenu(title: "Conversation", iconName: "text.bubble.fill", action: test_tap),
                                ]
                            )
                        )
                        
                        EmergencySelectionButton(selectedEmergency:
                            Emergency(
                                title: "Fire department",
                                iconName: "flame.fill",
                                gradientColor1: Color.orangeGradient1,
                                gradientColor2: Color.orangeGradient2,
                                emergencyType: EmergencyType.fireDepartment,
                                menus: [
                                    EmergencyMenu(title: "First Aid", iconName: "cross.case.fill", action: test_tap),
                                    EmergencyMenu(title: "Conversation", iconName: "text.bubble.fill", action: test_tap),
                                ]
                            )
                        )
                        
                        EmergencySelectionButton(selectedEmergency:
                            Emergency(
                                title: "Police",
                                iconName: "shield.righthalf.filled",
                                gradientColor1: Color.blueGradient1,
                                gradientColor2: Color.blueGradient2,
                                emergencyType: EmergencyType.police,
                                menus: [
                                    EmergencyMenu(title: "Stations", iconName: "house.lodge.fill",  action: {
                                        open_link(searchQuery: "Police stations", locationViewModel: locationViewModel)
                                    }),
                                    EmergencyMenu(title: "Conversation", iconName: "text.bubble.fill", action: test_tap),
                                ]
                            )
                        )
                        
                        Spacer()
                        
                        LocationButton()
                    }
                    .padding(.horizontal)
                    .padding(.top, 10.0)
                    
                }
                .frame(maxHeight: .infinity)
                .background(Color.iSOSBackground.ignoresSafeArea())
            }
            .navigationTitle("Need help?")
        }
    }
}

#Preview {
    SelectionView().environmentObject(LocationViewModel())
}
