import SwiftUI

struct FirstAidView: View {
    var body: some View {
        VStack (spacing: 10){
            HStack{
                Text("First aid")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                Spacer()
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
        .frame(maxHeight: .infinity)
        .background(Color.iSOSGray)
    }
}


#Preview {
    FirstAidView()
}
