//
//
//
//
//
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case conversation
    case firstAid
    case maps
    
    var id: Int {
        hashValue
    }
}

struct EmergencyView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    @Binding var activeSheet: ActiveSheet?
    
    let selectedEmergecny: Emergency
    
    var currentCountry: String {
        return locationViewModel.getCountry()
    }
    
    var computedCountryEmergencyNumber: String {
        return getEmergencyNumber(for: currentCountry, emergencyType: selectedEmergecny.emergencyType)
    }
    
    var body: some View {
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
                
                AppButtonCall(gradientColor1: selectedEmergecny.gradientColor1, gradientColor2: selectedEmergecny.gradientColor2, callNumber:computedCountryEmergencyNumber)
                
                Spacer()
                
                LocationButton()
            }
            .padding(.horizontal)
            .padding(.top, 20.0)
            
        }
        .frame(maxHeight: .infinity)
        .background(Color.mainBackground.ignoresSafeArea())
        .navigationTitle(selectedEmergecny.title)
        .navigationBarTitleDisplayMode(.inline)
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
            case .maps:
                MapView(
                    gradientColor1: selectedEmergecny.gradientColor1,
                    gradientColor2: selectedEmergecny.gradientColor2,
                    searchQuery: selectedEmergecny.mapSearchQuery,
                    activeSheet: $activeSheet
                )
                .presentationDetents([.large])
                .environmentObject(locationViewModel)
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
        gradientColor1: .redGradient1,
        gradientColor2: .redGradient2,
        emergencyType: EmergencyType.medicalHelp,
        menus: [
            EmergencyMenu(title: "First Aid", iconName: "cross.case.fill", action:  testTap),
            EmergencyMenu(title: "Hospitals", iconName: "building.2.fill", action: testTap),
            EmergencyMenu(title: "Conversation", iconName: "text.bubble.fill", action: testTap),
        ],
        mapSearchQuery: "Hospitals"
    )
    
    return EmergencyView(
        activeSheet: $activeSheet,
        selectedEmergecny: emergency
    )
    
    .environmentObject(LocationViewModel())
}
