import SwiftUI

struct SelectionView: View {    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 28, weight: .bold),
            .foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                ZStack{
                    TopGradient(gradientColor1: Color.redGradient1, gradientColor2: Color.redGradient2)
                    VStack(spacing: 10) {
                        HStack{
                            Text("Need Help?")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                            Spacer()
                        }

                        EmergencySelectionButton(selectedEmergency:
                            Emergency(
                                title: "Medical help",
                                iconName: "cross.fill",
                                gradientColor1: Color.redGradient1,
                                gradientColor2: Color.redGradient2,
                                menus: [
                                    EmergencyMenu(title: "First Aid", iconName: "cross.case.fill"),
                                    EmergencyMenu(title: "Hospitals", iconName: "building.2.fill"),
                                    EmergencyMenu(title: "Conversation", iconName: "text.bubble.fill"),
                                ]
                            )
                        )
                        
                        EmergencySelectionButton(selectedEmergency:
                            Emergency(
                                title: "Fire department",
                                iconName: "flame.fill",
                                gradientColor1: Color.orangeGradient1,
                                gradientColor2: Color.orangeGradient2,
                                menus: [
                                    EmergencyMenu(title: "First Aid", iconName: "cross.case.fill"),
                                    EmergencyMenu(title: "Conversation", iconName: "text.bubble.fill"),
                                ]
                            )
                        )
                        
                        EmergencySelectionButton(selectedEmergency:
                            Emergency(
                                title: "Police",
                                iconName: "shield.righthalf.filled",
                                gradientColor1: Color.blueGradient1,
                                gradientColor2: Color.blueGradient2,
                                menus: [
                                    EmergencyMenu(title: "Stations", iconName: "house.lodge.fill"),
                                    EmergencyMenu(title: "Conversation", iconName: "text.bubble.fill"),
                                ]
                            )
                        )
                        
                        Spacer()
                        
                        LocationButton()
                    }.padding([.top, .leading, .trailing], 25)
                    
                }
                .frame(maxHeight: .infinity)
                .background(Color.iSOSBackground.ignoresSafeArea())
            }
        }
    }
}


struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView()
    }
}
