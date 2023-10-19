import SwiftUI
import UniformTypeIdentifiers

struct MainView: View {
    var coordinates: String = "40°50'12.05\"N 14°18'23.70\"E"

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
                
                VStack(spacing: 10) {
                    
                    HStack {
                        Text("Need help?")
                            .font(.system(size: 36))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    
                    HelpButton(title: "Medical help", iconName: "cross.fill", gradientColor1: Color.redGradient1,gradientColor2: Color.redGradient2)
                    
                    HelpButton(title: "Fire department", iconName: "flame.fill", gradientColor1: Color.orangeGradient1,gradientColor2: Color.orangeGradient2)
                    HelpButton(title: "Police", iconName: "shield.righthalf.filled", gradientColor1: Color.blueGradient1,gradientColor2: Color.blueGradient2)
                    
                    
                    Spacer()
                    
                    ZStack{
                        AppButton(gradientColor1: Color.iSOSGray, gradientColor2: Color.iSOSGray,iconName: "location.fill")
                        
                        VStack{
                            HStack {
                                Group {
                                    Image(systemName: "location.fill")
                                        .padding(.leading, 20)
                                    Text("You are here:")
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                            }.padding(.top, 20.0)
                            
                            Spacer()
                            
                            Text(coordinates)
                                .font(.system(size: 21))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 20.0)
                        }.frame(maxHeight: 125)
                        
                    }.onTapGesture() {
                        UIPasteboard.general.setValue(coordinates,
                                                      forPasteboardType: UTType.plainText.identifier)
                    }
                    
                }
                .padding(.horizontal, 25)
                .padding(.top, 50)
                
            }.frame(maxHeight: .infinity)
        }
        .background(Color.iSOSBackground.ignoresSafeArea())
    }
}



struct HelpButton: View {
    var title: String
    var iconName: String
    var gradientColor1: Color
    var gradientColor2: Color
    
    var body: some View {
        ZStack{
            AppButton(gradientColor1: gradientColor1, gradientColor2: gradientColor2, iconName: iconName)
            
            HStack {
                Group {
                    Image(systemName: iconName)
                        .padding(.leading, 20)
                    Text(title)
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .padding(.trailing, 20)
                }
                .font(.system(size: 24))
                .foregroundColor(.white)
                .fontWeight(.medium)
            }
        }
    }
}

struct AppButton: View {
    var gradientColor1: Color
    var gradientColor2: Color
    var iconName: String
    
    let cornerRadius: Double = 20
    let frameHeight: Double = 115
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(LinearGradient(colors: [gradientColor1, gradientColor2], startPoint: .leading, endPoint: .trailing))
            .frame(height: frameHeight)
            .overlay(
                HStack() {
                    Spacer()
                    Image(systemName: iconName)
                        .foregroundColor(.white)
                        .opacity(0.15)
                        .font(.system(size: 128))
                        .padding(.trailing, -25)
                }.mask(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(height: frameHeight)
                )
            )
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
