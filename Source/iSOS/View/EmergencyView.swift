//
//
//
//
//
//

import SwiftUI

struct EmergencyView: View {
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    @Binding var activeSheet: ActiveSheet?
    
    let selectedEmergecny: Emergency
    
    private var currentCountry: String {
        return locationViewModel.getCountry()
    }
    
    private var countryEmergencyNumber: String {
        return getEmergencyNumber(for: currentCountry, emergencyType: selectedEmergecny.emergencyType)
    }
    
    var body: some View {
        
        VStack{
            let amountOfMenus = selectedEmergecny.menus.count
            
            HStack{
                ForEach(0..<(amountOfMenus  + 1) / 2, id: \.self) { i in
                    let singleMenu = selectedEmergecny.menus[i]
                    EmergencyMenuButton(title: singleMenu.title, iconName: singleMenu.iconName, gradientColor1: selectedEmergecny.gradientColor1, gradientColor2: selectedEmergecny.gradientColor2){
                        singleMenu.action()
                    }
                }
            }
            
            HStack{
                ForEach((amountOfMenus  + 1) / 2..<amountOfMenus, id: \.self) { i in
                    let singleMenu = selectedEmergecny.menus[i]
                    EmergencyMenuButton(title: singleMenu.title, iconName: singleMenu.iconName, gradientColor1: selectedEmergecny.gradientColor1, gradientColor2: selectedEmergecny.gradientColor2){
                        singleMenu.action()
                    }
                }
            }
            
            
            Spacer()
            
            AppButtonCall(gradientColor1: selectedEmergecny.gradientColor1, gradientColor2: selectedEmergecny.gradientColor2, callNumber:countryEmergencyNumber)
            
            Spacer()
            
            LocationButton()
        }
        .padding(.horizontal)
        .padding(.top)
        .background{
            TopGradient(gradientColor1: selectedEmergecny.gradientColor1, gradientColor2: selectedEmergecny.gradientColor2)
        }
        .background(.mainBackground)
        .navigationBarTitle(selectedEmergecny.title, displayMode: .inline)
        .sheet(item: $activeSheet) { item in
            
            Group{
                switch item {
                case .conversation:
                    ConversationView(emergencyType: selectedEmergecny.emergencyType)
                        .presentationDragIndicator(.visible)
                        .padding(.top)
                case .firstAid:
                    FirstAidView()
                        .presentationDragIndicator(.visible)
                        .padding(.top)
                case .maps:
                    MapView(
                        gradientColor1: selectedEmergecny.gradientColor1,
                        gradientColor2: selectedEmergecny.gradientColor2,
                        searchQuery: selectedEmergecny.mapSearchQuery,
                        activeSheet: $activeSheet
                    )
                }
            }
            .presentationDetents([.large])
            .environmentObject(locationViewModel)
            
        }
        
    }
}

enum ActiveSheet: Identifiable {
    case conversation
    case firstAid
    case maps
    
    var id: Int {
        hashValue
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
            EmergencyMenu(title: "First Aid", iconName: "cross.case.fill", action:  {}),
            EmergencyMenu(title: "Hospitals", iconName: "building.2.fill", action: {}),
            EmergencyMenu(title: "Conversation", iconName: "text.bubble.fill", action: {}),
        ],
        mapSearchQuery: "Hospitals"
    )
    
    return EmergencyView(
        activeSheet: $activeSheet,
        selectedEmergecny: emergency
    )
    
    .environmentObject(LocationViewModel())
}
