import SwiftUI
import UniformTypeIdentifiers
import CoreGraphics

struct EmergencyMenuButton: View {
    var title: String
    var iconName: String
    var gradientColor1: Color
    var gradientColor2: Color
    let side_padding: CGFloat = 10
    var action: () -> Void // Added this action closure

    var body: some View {
        ZStack {
            AppStandartButton(gradientColor1: gradientColor1, gradientColor2: gradientColor2, iconName: iconName)
            
            VStack {
                HStack {
                    Group {
                        Image(systemName: iconName)
                            .padding(.leading, side_padding)
                        Text(title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .font(.system(size: 23))
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                }
                .padding(.top, side_padding)
                Spacer()
            }
            .frame(height: 115)
        }
        .onTapGesture {  // Added this tap gesture
            action()
        }
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
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        
                    }
                }.frame(height: 115)
            }
        }
    }
}

struct LocationButton: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    let title: String = "You are here:"
    let iconName: String = "location.fill"
    let backroundColor: Color = Color.iSOSGray

    var formatedCoordinates: String {
        return locationViewModel.getFormattedCoordinates()
    }
    
    var body: some View {
        ZStack{
            AppStandartButton(gradientColor1: backroundColor, gradientColor2: backroundColor, iconName: iconName)
            
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
                Text(formatedCoordinates)
                    .font(.system(size: 21))
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20.0)
            }.frame(maxHeight: 125)
            
        }.onTapGesture() {
            softHaptic()
            UIPasteboard.general.setValue(formatedCoordinates,
                                          forPasteboardType: UTType.plainText.identifier)
        }
    }
}


struct AppStandartButton: View {
    var gradientColor1: Color
    var gradientColor2: Color
    var iconName: String
    var frameHeight: Double = 115
    var iconSize: Int = 128
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
                        .padding(.trailing, -25)
                }.mask(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(height: frameHeight)
                )
            )
    }
}

struct AppPopupButton: View {
    var backgrpundColor: Color
    var iconName: String
    
    var body: some View {
        AppStandartButton(
            gradientColor1: backgrpundColor,
            gradientColor2: backgrpundColor,
            iconName: iconName,
            frameHeight: 340,
            iconSize: 256,
            iconOpacity: 0.05
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
        ZStack{
            Circle()
                .fill(LinearGradient(colors: [gradientColor1, gradientColor2], startPoint: .top, endPoint: .bottom))
                .frame(height: 168)
                .shadow(color: gradientColor1.opacity(0.8), radius: 50)
            
            Image(systemName: iconName)
                .foregroundColor(.white)
                .font(.system(size: 64))
        }
        .onTapGesture {
            callModel.startCall(to: callNumber)
            mediumHaptic()
        }
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

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack {
            Button(action: {presentationMode.wrappedValue.dismiss()})
            {
                HStack(spacing: 3) {
                    Group{
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.white)
                }.padding(.leading, 5)
            }
        }
    }
}



#Preview {
    LocationButton().environmentObject(LocationViewModel())
        
    .padding(.horizontal, 25.0)
}
