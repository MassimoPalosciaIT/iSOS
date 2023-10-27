import SwiftUI

struct FirstAidView: View {
    var firstAidButtons: [FirstAidModel] = [
        FirstAidModel(title: "Bleeding", iconName: "drop.fill"),
        FirstAidModel(title: "Heart attack", iconName: "bolt.heart"),
        FirstAidModel(title: "Burn", iconName: "flame"),
        FirstAidModel(title: "Asthma attack", iconName: "rays"),
        FirstAidModel(title: "Fracture", iconName: "bandage"),
        FirstAidModel(title: "Diabetic emergency", iconName: "microbe.fill"),
        FirstAidModel(title: "Epileptic seizure", iconName: "lightspectrum.horizontal"),
        FirstAidModel(title: "Stroke", iconName: "brain.head.profile"),
        FirstAidModel(title: "Allergic reaction", iconName: "wind"),
    ]
    
    var body: some View {
        VStack (spacing: 10){
            HStack{
                Text("First aid")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                Spacer()
            }
            NavigationStack{
                ScrollView{
                    ForEach(firstAidButtons) { button in
                        NavigationLink(destination: FirstAidDetailedView(FirstAidName: button.title)){
                            FirstAidSelectionButton(iconName: button.iconName, title: button.title)
                        }
                    }
                }.background(Color.iSOSGray)
            }
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
