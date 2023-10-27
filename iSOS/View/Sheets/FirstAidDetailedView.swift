import SwiftUI

struct FirstAidDetailedView: View {
    var FirstAidName: String
    var tips: [String]

    init(FirstAidName: String) {
        self.FirstAidName = FirstAidName
        self.tips = getFirstAidRows(for: FirstAidName)
    }
    
    var body: some View {
        HStack{
            VStack (){
                ScrollView(showsIndicators: false){
                    ForEach(tips, id: \.self) { tip in
                        TextBlob(textContent: tip, fillColor: Color.appButtonGray)
                    }
                }
            }
            .padding(.top)
            .navigationTitle(FirstAidName)
            .navigationBarTitleDisplayMode(.inline)
        }
        .frame(maxWidth: .infinity)
        .background(Color.iSOSGray.ignoresSafeArea())
        
    }
}

#Preview {
    FirstAidDetailedView(FirstAidName: "Bleeding")
}
