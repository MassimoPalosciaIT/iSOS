import SwiftUI

struct EmergencyView: View {    
    let selectedEmergecny: Emergency
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
                                EmergencyMenuButton(title: singleMenu.title, iconName: singleMenu.iconName, gradientColor1: selectedEmergecny.gradientColor1, gradientColor2: selectedEmergecny.gradientColor2)
                            }
                        }
                        
                        HStack(spacing: 10){
                            ForEach((amountOfMenus  + 1) / 2..<amountOfMenus*1, id: \.self) { i in
                                let singleMenu = selectedEmergecny.menus[i]
                                EmergencyMenuButton(title: singleMenu.title, iconName: singleMenu.iconName, gradientColor1: selectedEmergecny.gradientColor1, gradientColor2: selectedEmergecny.gradientColor2)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    AppButtonCall(gradientColor1: selectedEmergecny.gradientColor1, gradientColor2: selectedEmergecny.gradientColor2, callNumber:"123456789")
                    
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
    let emergency = Emergency(
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
    return EmergencyView(selectedEmergecny: emergency)
}
