import SwiftUI

struct EmergencyView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    let selectedEmergecny: Emergency
    
    var currentCountry: String {
        return locationViewModel.getCountry()
    }
    
    var computedCountryEmergencyNumber: String {
        return getEmergencyNumber(for: currentCountry, emergencyType: selectedEmergecny.emergencyType)
    }
    
    var body: some View {
        VStack {
            ZStack{
                TopGradient(gradientColor1: selectedEmergecny.gradientColor1, gradientColor2: selectedEmergecny.gradientColor2)
                
                VStack{
                    VStack(spacing: 10){
                        let amountOfMenus = selectedEmergecny.menus.count
                        
                        HStack(spacing: 10){
                            ForEach(0..<(amountOfMenus  + 1) / 2, id: \.self) { i in
                                let singleMenu = selectedEmergecny.menus[i]
                                EmergencyMenuButton(title: singleMenu.title, iconName: singleMenu.iconName, gradientColor1: selectedEmergecny.gradientColor1, gradientColor2: selectedEmergecny.gradientColor2){
                                    singleMenu.action()
                                }
                            }
                        }
                        
                        HStack(spacing: 10){
                            ForEach((amountOfMenus  + 1) / 2..<amountOfMenus*1, id: \.self) { i in
                                let singleMenu = selectedEmergecny.menus[i]
                                EmergencyMenuButton(title: singleMenu.title, iconName: singleMenu.iconName, gradientColor1: selectedEmergecny.gradientColor1, gradientColor2: selectedEmergecny.gradientColor2){
                                    singleMenu.action()
                                }
                            }
                        }
                    }
                    
                    Spacer()

                    AppButtonCall(gradientColor1: selectedEmergecny.gradientColor1, gradientColor2: selectedEmergecny.gradientColor2, callNumber:computedCountryEmergencyNumber)
                    
                    Spacer()
                    
                    LocationButton()
                }
                .padding([.top, .leading, .trailing], 20)
                
            }
            .frame(maxHeight: .infinity)
            .background(Color.iSOSBackground.ignoresSafeArea())
            .navigationTitle(selectedEmergecny.title)
        }
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                BackButton()
        )
        
    }
}

#Preview {
    let emergency: Emergency =
    
    Emergency(
        title: "Medical help",
        iconName: "cross.fill",
        gradientColor1: Color.redGradient1,
        gradientColor2: Color.redGradient2,
        emergencyType: EmergencyType.medicalHelp,
        menus: [
            EmergencyMenu(title: "First Aid", iconName: "cross.case.fill", action: test_tap),
            EmergencyMenu(title: "Hospitals", iconName: "building.2.fill", action: test_tap),
            EmergencyMenu(title: "Conversation", iconName: "text.bubble.fill", action: test_tap),
        ]
    )
    
    return EmergencyView(selectedEmergecny: emergency).environmentObject(LocationViewModel())
}
