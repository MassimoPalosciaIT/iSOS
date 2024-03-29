import SwiftUI

struct ErrorView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    var errorText:String
    var locationError: Bool = true
    
    var body: some View {
        ZStack{
            TopGradient(gradientColor1: .redGradient1, gradientColor2: .redGradient2)
            
            ZStack{
                AppPopupButton(iconName: "xmark")
                
                VStack {
                    
                    Text(errorText)
                        .fontWeight(.bold)
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20.0)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 128))
                        .fontWeight(.light)
                    
                    Spacer()
                    
                    
                    if locationError{
                        Group(){
                            Button(action: {
                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                            }
                                   ,label: {
                                Label("Open settings", systemImage: "gearshape.fill")
                            })
                            .padding(12)
                            .foregroundColor(.white)
                            .background(.redGradient2)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }.padding(.bottom, 20.0)
                    }
                    
                }.frame(height: 340)
            }.padding(.horizontal)
            
        }
        .background(Color.iSOSBackground.ignoresSafeArea())
    }
}

#Preview {
    ErrorView(errorText: "Location use is restricted")
}
