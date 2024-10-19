//
//
//
//
//
//

import SwiftUI

// This view might display according information about each Emergency based on its type
// You can pass custom branding (colors) as well as custom menu buttons and actions
struct EmergencyView: View {
    
    @Environment(LocationModel.self) var locationModel: LocationModel
    
    // Active sheet type is passed from the main contentView
    @Binding var activeSheet: ActiveSheet?
    
    // Define selected emergency
    let selectedEmergency: Emergency
    
    // Get current country based on the location
    private var currentCountry: String {
        return locationModel.getCountry()
    }
    
    var body: some View {
        
        VStack{
            let amountOfMenus = selectedEmergency.menus.count
            
            HStack{
                ForEach(0..<(amountOfMenus  + 1) / 2, id: \.self) { i in
                    let singleMenu = selectedEmergency.menus[i]
                    
                    // MARK:
                    
                    // The Phrases feature is currently only available and working in Italy due to the lack of localization. This view will not appear in other countries.
                    let listOfSupportedPhrasesCountries: [String] = ["Italy"]
                    
                    if !(singleMenu.title == "Emergency Phrases" && !listOfSupportedPhrasesCountries.contains(currentCountry)){
                        
                        EmergencyMenuButton(title: singleMenu.title, iconName: singleMenu.iconName, colorCombination: selectedEmergency.colorCombination){
                            singleMenu.action()
                        }
                        
                    }
                }
            }
            
            HStack{
                ForEach((amountOfMenus  + 1) / 2..<amountOfMenus, id: \.self) { i in
                    let singleMenu = selectedEmergency.menus[i]
                    
                    // MARK:
                    
                    // The Emergency Phrases feature is currently only available and working in Italy due to the lack of localization. This view will not appear in other countries.
                    let listOfSupportedPhrasesCountries: [String] = ["Italy"]
                    
                    if !(singleMenu.title == "Emergency Phrases" && !listOfSupportedPhrasesCountries.contains(currentCountry)){
                        
                        EmergencyMenuButton(title: singleMenu.title, iconName: singleMenu.iconName, colorCombination: selectedEmergency.colorCombination){
                            singleMenu.action()
                        }
                        
                    }
                    
                }
            }
            
            
            Spacer()
            
            AppButtonCall(colorCombination: selectedEmergency.colorCombination, emergencyType: selectedEmergency.emergencyType)
            
            Spacer()
            
            LocationButton()
        }
        .padding()
        .background{
            TopGradient(colorCombination: selectedEmergency.colorCombination)
        }
        .background(.mainBackground)
        .navigationBarTitle(selectedEmergency.title, displayMode: .inline)
        
        // Present sheet view based on ActiveSheet
        .sheet(item: $activeSheet) { item in
            
            Group{
                switch item {
                case .phrases:
                    PhrasesView(emergencyType: selectedEmergency.emergencyType)
                        .presentationDragIndicator(.visible)
                        .padding(.top)
                case .firstAid:
                    FirstAidView()
                        .presentationDragIndicator(.visible)
                        .padding(.top)
                case .maps:
                    MapView(
                        colorCombination: selectedEmergency.colorCombination,
                        searchQuery: selectedEmergency.mapSearchQuery,
                        activeSheet: $activeSheet
                    )
                }
            }
            .presentationDetents([.large])
            .environment(locationModel)
            
        }
        
    }
}

// Control currently selected sheet
enum ActiveSheet: Identifiable {
    case phrases
    case firstAid
    case maps
    
    var id: Int {
        hashValue
    }
}

#Preview {
    @Previewable @State var activeSheet: ActiveSheet?
    
    let emergency: Emergency =
    
    Emergency(
        title: "Medical help",
        iconName: "cross.fill",
        colorCombination: ColorCombination(main: .redGradient1, secondary: .redGradient2),
        emergencyType: EmergencyType.medicalHelp,
        menus: [
            EmergencyMenu(title: "First Aid", iconName: "cross.case.fill", action:  {}),
            EmergencyMenu(title: "Hospitals", iconName: "building.2.fill", action: {}),
            EmergencyMenu(title: "Emergency Phrases", iconName: "text.bubble.fill", action: {}),
        ],
        mapSearchQuery: "Hospitals"
    )
    
    return EmergencyView(
        activeSheet: $activeSheet,
        selectedEmergency: emergency
    )
    
    .environment(LocationModel())
}
