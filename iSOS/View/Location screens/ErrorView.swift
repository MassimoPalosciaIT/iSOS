import SwiftUI

struct ErrorView: View {
    @EnvironmentObject var locationViewModel: LocationModel
    var errorText:String
    
    var body: some View {
        ZStack{
            TopGradient(gradientColor1: Color.redGradient1, gradientColor2: Color.redGradient2)
            
            ZStack{
                AppPopupButton(
                    backgrpundColor: Color.iSOSGray,
                    iconName: "xmark"
                )
                
                VStack {
                    
                    Text("Oups, there was an error")
                        .fontWeight(.bold)
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .padding(.top, 20.0)
                    
                    Spacer()
                    
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 128))
                        .fontWeight(.light)
                    
                    Spacer()
                    
                    Text(errorText)
                        .fontWeight(.regular)
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .bottom, .trailing], 20.0)
                    
                }.frame(height: 340)
            }.padding(.horizontal, 25)
            
        }
        .background(Color.iSOSBackground.ignoresSafeArea())
    }
}

#Preview {
    ErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
}
