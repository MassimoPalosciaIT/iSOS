//
//
//
//
//
//

import SwiftUI

struct TutorialView: View {
    var body: some View {
        @AppStorage("isOnboarding") var isOnboarding: Bool?
        
        VStack{
            VStack{
                Image(uiImage: Bundle.main.icon ?? UIImage())
                    .resizable()
                    .frame(width: 80,height: 80)
                    .clipShape(Rectangle())
                    .cornerRadius(20)
                    .padding(.top, 80.0)
                Text("Welcome to the \n Yaha")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 20){
                    TutorialElement(iconName: "phone.circle", title: "Emergency number locator", description: "The app determines your country's emergency number.")
                    
                    TutorialElement(iconName: "doc.on.doc", title: "Copy coordinates", description: "Click on the coordinates to copy them to the clipboard.")
                    
                    TutorialElement(iconName: "square.and.arrow.down", title: "Download offline maps", description: "Make sure to download offline maps before your journey.")
                }
                .padding(.top)
                
                Spacer()
                
                HStack{
                    Button {
                        isOnboarding = false
                    }
                        label: {
                                Text("Continue")
                                    .frame(maxWidth: .infinity)
                                    .fontWeight(.bold)
                            }
                            .buttonStyle(TutorialButtonStyle())
                            .controlSize(.large)
                }
            }.padding(.horizontal, 30)
        }
    }
}

extension Bundle {
    var icon: UIImage? {
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
           let primary = icons["CFBundlePrimaryIcon"] as? [String: Any],
           let files = primary["CFBundleIconFiles"] as? [String],
           let icon = files.last
        {
            return UIImage(named: icon)
        }
        
        return nil
    }
}


#Preview {
    TutorialView()
}
