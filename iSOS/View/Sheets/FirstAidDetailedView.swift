import SwiftUI

struct FirstAidDetailedView: View {
    var FirstAidName: String
    var tips: [String]

    init(FirstAidName: String) {
        self.FirstAidName = FirstAidName
        self.tips = getFirstAidRows(for: FirstAidName)
    }
    
    var body: some View {
        VStack (spacing: 10){
            VStack{
                ForEach(tips, id: \.self) { tip in
                    TextBlob(textContent: tip, fillColor: Color.appButtonGray)
                }

                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.top)
        .frame(maxHeight: .infinity)
        .background(Color.iSOSGray)
        .navigationTitle(FirstAidName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FirstAidDetailedView(FirstAidName: "Bleeding")
}
