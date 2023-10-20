import SwiftUI

struct ErrorView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    var errorText:String
    
    var body: some View {
        VStack {
            ZStack{
                VStack {
                    LinearGradient(colors: [.redGradient1, .redGradient2.opacity(0)], startPoint: .top, endPoint: .bottom)
                        .frame(height: 270)
                        .ignoresSafeArea()
                        .opacity(0.7)
                    Spacer()
                }
                
                ZStack{
                    AppButton_popup(gradientColor1: Color.iSOSGray, gradientColor2: Color.iSOSGray, iconName: "location.fill")
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
}

#Preview {
    ErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
}
