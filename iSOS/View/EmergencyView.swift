import SwiftUI

enum ActiveSheet: Identifiable {
    case conversation
    case firstAid

    var id: Int {
        hashValue
    }
}

struct EmergencyView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Binding var activeSheet: ActiveSheet?
    
    let selectedEmergecny: Emergency
    
    var currentCountry: String {
        return locationViewModel.getCountry()
    }
    
    var computedCountryEmergencyNumber: String {
        return getEmergencyNumber(for: currentCountry, emergencyType: selectedEmergecny.emergencyType)
    }
    
    var computedCountryName: String {
        return locationViewModel.getCountry()
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
                            ForEach((amountOfMenus  + 1) / 2..<amountOfMenus, id: \.self) { i in
                                let singleMenu = selectedEmergecny.menus[i]
                                EmergencyMenuButton(title: singleMenu.title, iconName: singleMenu.iconName, gradientColor1: selectedEmergecny.gradientColor1, gradientColor2: selectedEmergecny.gradientColor2){
                                    singleMenu.action()
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Text(computedCountryName)
                    
                    AppButtonCall(gradientColor1: selectedEmergecny.gradientColor1, gradientColor2: selectedEmergecny.gradientColor2, callNumber:computedCountryEmergencyNumber)
                    
                    Spacer()
                    
                    LocationButton()
                }
                .padding(.horizontal)
                .padding(.top, 20.0)
                
            }
            .frame(maxHeight: .infinity)
            .background(Color.iSOSBackground.ignoresSafeArea())
            .navigationTitle(selectedEmergecny.title)
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(item: $activeSheet) { item in
            switch item {
               case .conversation:
                ConversationView(emergencyType: selectedEmergecny.emergencyType)
                        .environmentObject(locationViewModel)
                       .presentationDetents([.large])
                       .presentationDragIndicator(.visible)
                       .padding(.top)
               case .firstAid:
                    FirstAidView()
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                        .padding(.top)
            }
        }
    }
}

#Preview {
    @State var activeSheet: ActiveSheet?
    
    let emergency: Emergency =
    
    Emergency(
        title: "Medical help",
        iconName: "cross.fill",
        gradientColor1: Color.redGradient1,
        gradientColor2: Color.redGradient2,
        emergencyType: EmergencyType.medicalHelp,
        menus: [
            EmergencyMenu(title: "First Aid", iconName: "cross.case.fill", action:  testTap),
            EmergencyMenu(title: "Hospitals", iconName: "building.2.fill", action: testTap),
            EmergencyMenu(title: "Conversation", iconName: "text.bubble.fill", action: testTap),
        ]
    )
    
    return EmergencyView(
        activeSheet: $activeSheet,
        selectedEmergecny: emergency
    )
        
    .environmentObject(LocationViewModel())
}
