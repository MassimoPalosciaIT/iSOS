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
                        .foregroundColor(.white)
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
    let side_padding: CGFloat = 20
    
    var body: some View {
        NavigationLink(destination: EmergencyView(selectedEmergecny: selectedEmergency)) {
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
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        
                    }
                }.frame(height: 120)
            }
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
                        .foregroundColor(.white)
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
                        .foregroundColor(.white)
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
                    .foregroundColor(.white)
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
                .foregroundColor(.white)
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
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                    }.padding(.top, 20.0)
                    
                    Spacer()
                    
                    HStack{
                        Text(formatedCoordinates)
                            .font(.system(size: 21))
                            .foregroundColor(.white)
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

enum BlobType {
    case question
    case blobReply
}

struct TextBlob: View {
    var blobType: BlobType
    var blobColor: Color
    var textColor: Color
    var messageText: String
    
    init(blobType: BlobType, messageText: String) {
        self.blobType = blobType
        self.messageText = messageText
        
        switch blobType {
            case .question:
                self.blobColor = Color.blobWhite
                self.textColor = Color.black
            case .blobReply:
                self.blobColor = Color.blobBlue
                self.textColor = Color.blobWhite
        }
    }
    
    var body: some View {
        ZStack {
            ReplyBlobShape()
                .fill(blobColor)
            
            HStack {
                Text(messageText)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .padding([.top, .bottom, .trailing])
                    .padding(.leading, 25)
                    .foregroundStyle(textColor)
                
                Spacer()
            }
        }
        .frame(width: 280, height: 90)
    }
}

struct BlobCombo: View {
    var messageQuestion: String
    var messageReply: String
    
    var body: some View {
        VStack(spacing: 10){
            HStack{
                TextBlob(blobType: BlobType.question, messageText: messageQuestion)
                Spacer()
            }
            
            HStack{
                Spacer()
                TextBlob(blobType: BlobType.blobReply, messageText: messageReply)
            }
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.redGradient1)
            .foregroundColor(.white)
            .cornerRadius(20)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            
    }
}

#Preview {
        LocationButton()

        .environmentObject(LocationViewModel())
        .padding(.horizontal)
}
