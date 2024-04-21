//
//
//
//
//
//

import SwiftUI

struct FirstAidView: View {
    
    @State private var searchBarText = ""
    
    // Load FirstAidCardViewModel
    private let aidModel:FirstAidCardViewModel = FirstAidCardViewModel()
    
    var body: some View {
        
        NavigationStack{
            ScrollView(showsIndicators: false){
                ForEach(searchResults) { button in
                    NavigationLink(destination: FirstAidDetailedView(FirstAidName: button.title)){
                        FirstAidSelectionButton(iconName: button.iconName, title: button.title)
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("First aid")
        }
        .searchable(text: $searchBarText, placement: .navigationBarDrawer(displayMode: .always))
        
    }
    
    // Filter search results based on the name of the first aid
    var searchResults: [FirstAidModel] {
        if searchBarText.isEmpty {
            return aidModel.aid
        } else {
            return aidModel.aid.filter { $0.title.lowercased().contains(searchBarText.lowercased()) }
        }
    }
}


#Preview {
    FirstAidView()
}
