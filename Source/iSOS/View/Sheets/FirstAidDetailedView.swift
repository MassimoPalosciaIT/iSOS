//
//
//
//
//
//

import SwiftUI

struct FirstAidDetailedView: View {
    
    var FirstAidName: String
    var tips: [String]
    
    init(FirstAidName: String) {
        self.FirstAidName = FirstAidName
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
