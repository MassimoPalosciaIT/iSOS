import SwiftUI
import UniformTypeIdentifiers

struct MainView: View {
    var coordinates: String = "40°50'12.05\"N 14°18'23.70\"E"
    
    var body: some View {
        
        NavigationStack{
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
                        
                        
                        
                        NavigationLink(destination: MedicalEmergencyView()){
                            HelpButton(title: "Medical help", iconName: "cross.fill", gradientColor1: Color.redGradient1,gradientColor2: Color.redGradient2)
                        }
                        NavigationLink(destination: FireDepartmentView()){
                            HelpButton(title: "Fire department", iconName: "flame.fill", gradientColor1: Color.orangeGradient1,gradientColor2: Color.orangeGradient2)
                        }
                        NavigationLink(destination: PoliceEmergencyView()){
                            HelpButton(title: "Police", iconName: "shield.righthalf.filled", gradientColor1: Color.blueGradient1,gradientColor2: Color.blueGradient2)
                        }
                        
                        
                        Spacer()
                        
                        LocationButton(title: "You are here:", iconName: "location.fill", gradientColor1: Color.iSOSGray, gradientColor2: Color.iSOSGray, coordinates: coordinates)
                        
                    }
                    .padding(.horizontal, 25)
                    //.padding(.top, 30)
                    
                }.frame(maxHeight: .infinity)
                    .background(Color.iSOSBackground.ignoresSafeArea())
                
            }.navigationTitle("Need Help?")
        }
        
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

struct LocationButton: View {
    var title: String
    var iconName: String
    var gradientColor1: Color
    var gradientColor2: Color
    var coordinates: String
    
    var body: some View {
        ZStack{
            AppButton(gradientColor1:gradientColor1, gradientColor2: gradientColor2,iconName: iconName)
            
            VStack{
                HStack {
                    Group {
                        Image(systemName: iconName)
                            .padding(.leading, 20)
                        Text(title)
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
}

struct HelpEmergencyButton: View {
    var title: String
    var iconName: String
    var gradientColor1: Color
    var gradientColor2: Color
    
    var body: some View {
        ZStack{
            AppButton(gradientColor1: gradientColor1, gradientColor2: gradientColor2, iconName: iconName)
            VStack{
                HStack {
                    Group {
                        Image(systemName: iconName)
                            .padding(.leading, 5)
                            .padding(.top, 20)
                        Text(title)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                        
                        Spacer()
                        
                    }
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                    .fixedSize()
                }
                Spacer()
            }.frame(height: 115)
        }
    }
}

struct BigHelpEmergencyButton: View {
    var title: String
    var iconName: String
    var gradientColor1: Color
    var gradientColor2: Color
    
    var body: some View {
        ZStack(alignment: .topLeading){
            AppButton(gradientColor1: gradientColor1, gradientColor2: gradientColor2, iconName: iconName)
            VStack(){
                HStack {
                    Group {
                        Image(systemName: iconName)
                            .padding(.leading, 20)
                            .padding(.top, 20)
                        Text(title)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                        
                        Spacer()
                        
                    }
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                    .fixedSize()
                }
                Spacer()
            }.frame(height: 115)
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


struct AppButtonCircular: View {
    var gradientColor1: Color
    var gradientColor2: Color
    var iconName: String
    
    let cornerRadius: Double = 20
    let frameHeight: Double = 115
    
    var body: some View {
        
        ZStack{
                
            Circle()
                .fill(LinearGradient(colors: [gradientColor1, gradientColor2], startPoint: .leading, endPoint: .trailing))
                .frame(height: 168)
                .shadow(color: gradientColor1.opacity(0.8), radius: 50)
            
            HStack() {
                Image(systemName: iconName)
                    .foregroundColor(.white)
                    .font(.system(size: 64))
            }
            
            
        }
                
            
        
    }
}



struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
