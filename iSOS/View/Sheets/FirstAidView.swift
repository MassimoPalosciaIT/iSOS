import SwiftUI

struct FirstAidView: View {
    @State private var search_aid = ""
    let aidModel:FirstAidCardsModel = FirstAidCardsModel()
    
    var body: some View {
        VStack{
            VStack{
                NavigationStack{
                    ScrollView(showsIndicators: false){
                        ForEach(searchResults) { button in
                            NavigationLink(destination: FirstAidDetailedView(FirstAidName: button.title)){
                                FirstAidSelectionButton(iconName: button.iconName, title: button.title)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .background(Color.iSOSGray)
                    .navigationTitle("First aid")
                }
                .searchable(text: $search_aid, placement: .navigationBarDrawer(displayMode: .always))
            }
        }
        .frame(maxHeight: .infinity)
        .background(Color.iSOSGray)
    }
    var searchResults: [FirstAidModel] {
        if search_aid.isEmpty {
            return aidModel.aid
        } else {
            return aidModel.aid.filter { $0.title.lowercased().contains(search_aid.lowercased()) }
        }
    }
}


#Preview {
    FirstAidView()
}
