//
//
//
//
//
//

import SwiftUI

// FirstAidDetailedView is visible after selecting First Aid card from the FirstAidView
struct FirstAidDetailedView: View {
    
    var FirstAidName: String
    var tips: [String]
    
    init(FirstAidName: String) {
        self.FirstAidName = FirstAidName
        // Parse tips from .csv file based on the name of the first aid
        self.tips = getFirstAidRows(for: FirstAidName)
    }
    
    var body: some View {
        
        ScrollView(showsIndicators: false){
            ForEach(tips, id: \.self) { tip in
                TextBlob(textContent: tip, fillColor: .mainGray)
            }
        }
        .padding()
        .navigationTitle(FirstAidName)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    FirstAidDetailedView(FirstAidName: "Bleeding")
}
