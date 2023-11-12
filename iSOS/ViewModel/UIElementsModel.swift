import SwiftUI
import UniformTypeIdentifiers
import CoreGraphics

struct EmergencyMenuButton: View {
    var title: String
    var iconName: String
    var gradientColor1: Color
    var gradientColor2: Color
    let side_padding: CGFloat = 10
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                AppStandartButton(gradientColor1: gradientColor1, gradientColor2: gradientColor2, iconName: iconName,iconOpacity: 0.12)
                
                VStack {
                    HStack {
                        Group {
                            Image(systemName: iconName)
                                .padding(.leading, side_padding)
                            Text(title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .font(.system(size: 24))
                        .fontWeight(.medium)
                    }
                    .padding(.top, side_padding)
                    Spacer()
                }
                .frame(height: 120)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct EmergencySelectionButton: View {
    var selectedEmergency: Emergency
    @Binding var activeSheet: ActiveSheet? // Add this line
    let side_padding: CGFloat = 20
    
    var body: some View {
        NavigationLink(destination: EmergencyView(activeSheet: $activeSheet, selectedEmergecny: selectedEmergency)) {
            ZStack{
                AppStandartButton(gradientColor1: selectedEmergency.gradientColor1, gradientColor2: selectedEmergency.gradientColor2, iconName: selectedEmergency.iconName)
                
                VStack
                {
                    HStack {
                        Group {
                            Image(systemName: selectedEmergency.iconName)
                                .padding(.leading, side_padding)
                            Text(selectedEmergency.title)
                                .fontWeight(.bold)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .padding(.trailing, side_padding)
                        }
                        .font(.system(size: 26))
                        .fontWeight(.medium)
                        
                    }
                }.frame(height: 120)
            }
        }
    }
}

struct FirstAidSelectionButton: View {
    let side_padding: CGFloat = 20
    var iconName: String
    var title: String
    
    var body: some View {
        ZStack{
            AppStandartButton(gradientColor1: Color.iSOSGray, gradientColor2: Color.iSOSGray, iconName: "xmark", frameHeight: 80, iconOpacity: 0)
            
            VStack
            {
                HStack {
                    Group {
                        Image(systemName:iconName)
                            .padding(.leading, side_padding)
                        Text(title)
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .padding(.trailing, side_padding)
                    }
                    .font(.system(size: 26))
                    .fontWeight(.medium)
                    
                }
            }.frame(height: 80)
        }
    }
}

struct AppStandartButton: View {
    var gradientColor1: Color
    var gradientColor2: Color
    var iconName: String
    var frameHeight: Double = 120
    var iconSize: Int = 130
    var iconOpacity: Double = 0.15
    let cornerRadius: Double = 20
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(LinearGradient(colors: [gradientColor1, gradientColor2], startPoint: .leading, endPoint: .trailing))
            .frame(height: frameHeight)
            .overlay(
                HStack() {
                    Spacer()
                    Image(systemName: iconName)
                        .opacity(iconOpacity)
                        .font(.system(size: CGFloat(iconSize)))
                        .padding(.trailing, -35)
                }.mask(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(height: frameHeight)
                )
            )
    }
}

struct AppPopupButton: View {
    var backgrpundColor: Color = Color.iSOSGray
    let cornerRadius: Double = 20
    var iconName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(backgrpundColor)
            .aspectRatio(1.0, contentMode: .fit)
            .overlay(
                HStack() {
                    Spacer()
                    Image(systemName: iconName)
                        .fontWeight(.black)
                        .opacity(0.02)
                        .font(.system(size: CGFloat(300)))
                        .padding(.trailing, -100)
                }.mask(
                    RoundedRectangle(cornerRadius: cornerRadius)
                )
            )
    }
}

struct AppButtonCall: View {
    var callModel: CallModel = CallModel()
    var gradientColor1: Color
    var gradientColor2: Color
    var callNumber: String
    let iconName: String = "phone.fill"
    
    var body: some View {
        Button(action: {
            callModel.startCall(to: callNumber)
            mediumHaptic()
        }) {
            ZStack{
                Circle()
                    .fill(LinearGradient(colors: [gradientColor1, gradientColor2], startPoint: .top, endPoint: .bottom))
                    .frame(height: 165)
                    .shadow(color: gradientColor1.opacity(0.8), radius: 50)
                
                Image(systemName: iconName)
                    .font(.system(size: 64))
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct TopGradient: View {
    var gradientColor1: Color = Color.pink
    var gradientColor2: Color = Color.pink
    
    var body: some View {
        VStack {
            LinearGradient(colors: [gradientColor1, gradientColor2.opacity(0)], startPoint: .top, endPoint: .bottom)
                .frame(height: 270)
                .ignoresSafeArea()
                .opacity(0.7)
            Spacer()
        }
    }
}

struct AppPopupCopy: View {
    let title: String = "Coordinates copied to the clipboard"
    let iconName = "doc.on.doc.fill"
    let side_padding: CGFloat = 10
    
    var body: some View {
        ZStack{
            AppStandartButton(
                gradientColor1: Color.iSOSGray,
                gradientColor2: Color.iSOSGray,
                iconName: iconName,
                frameHeight: 45,
                iconOpacity: 0
            )
            
            HStack {
                Group {
                    Image(systemName: iconName)
                    Text(title)
                }
                .font(.system(size: 18))
                .fontWeight(.medium)
            }
        }
    }
}

struct LocationButton: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    @State private var textOpacity: Double = 0.0
    
    let title: String = "You are here:"
    let iconName: String = "location.fill"
    let backroundColor: Color = Color.iSOSGray
    
    var formatedCoordinates: String {
        return locationViewModel.getFormattedCoordinates()
    }
    
    var body: some View {
        Button(action: {
            softHaptic()
            UIPasteboard.general.setValue(formatedCoordinates,
                                          forPasteboardType: UTType.plainText.identifier)
            
            withAnimation(.easeIn(duration: 0.4)) {
                textOpacity = 1.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                withAnimation(.easeOut(duration: 0.4)) {
                    textOpacity = 0.0
                }
            }
            
        }) {
            
            ZStack{
                AppStandartButton(gradientColor1: backroundColor, gradientColor2: backroundColor, iconName: iconName, iconOpacity: 0.05)
                
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
                        .fontWeight(.medium)
                    }.padding(.top, 20.0)
                    
                    Spacer()
                    
                    HStack{
                        Text(formatedCoordinates)
                            .font(.system(size: 21))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .padding([.leading, .bottom], 20.0)
                        Spacer()
                    }
                }.frame(maxHeight: 125)
            }.overlay(
                VStack(){
                    AppPopupCopy()
                        .opacity(textOpacity)
                    
                    Spacer()
                }.frame(height: 230)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct BlobCombo: View {
    var messageQuestion: String
    var messageReply: String
    
    var body: some View {
        VStack(spacing: 10){
            HStack{
                HStack{
                    Text(messageQuestion)
                        .padding()
                        .background(Color(UIColor.iSOSGray))
                        .clipShape(BubbleShape(myMessage: false))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .frame(width: 300)
                
                Spacer()
            }
            
            HStack{
                Spacer()
                
                HStack{
                    Spacer()
                    Text(messageReply)
                        .padding()
                        .background(Color(UIColor.blobGray))
                        .clipShape(BubbleShape(myMessage: true))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .frame(width: 300)
            }
        }
    }
}

struct TutorialButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.redGradient1)
            .cornerRadius(15)
    }
}

struct TutorialElement: View {
    var iconName: String
    var title: String
    var description: String
    
    var body: some View {
        HStack(){
            
            Image(systemName: iconName)
                .font(.system(size: 40))
                .fontWeight(.medium)
                .foregroundColor(Color.redGradient1)
                .padding(.trailing, 20)
                .frame(width: 40,height: 40)
            
            
            HStack{
                VStack(alignment: .leading){
                    Text(title)
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    
                    Text(description)
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                }
            }
            Spacer()
        }.padding(.horizontal, 10)
    }
}

struct TextBlob: View {
    var textContent: String = "2. Call an ambulance as soon as possible."
    var fillColor: Color = Color.blobGray
    var textColor: Color = Color.white
    
    var body: some View{
        ZStack{
            Text(textContent.replacingOccurrences(of: "\\n", with: "\n"))
                .frame(maxWidth: .infinity)
                .padding()
                .background(fillColor)
                .cornerRadius(20)
                .foregroundColor(textColor.opacity(0))
                .multilineTextAlignment(.leading) // Align text to the leading edge
                .lineLimit(nil)
            HStack{
                Text(textContent.replacingOccurrences(of: "\\n", with: "\n"))
                    .fontWeight(.semibold)
                    .padding(.leading)
                    .foregroundColor(textColor)
                    .multilineTextAlignment(.leading) // Align text to the leading edge
                    .lineLimit(nil)
                
                Spacer()
            }
        }
    }
}

#Preview {
    BlobCombo(messageQuestion: "The app does not have", messageReply: "The app does not have location permissions. The app does not have location permissions")
        .environmentObject(LocationViewModel())
        .padding(.horizontal)
}
