//
//
//
//
//
//

import SwiftUI

struct TutorialView: View {
    
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    @State var animationPhase: Int = 0
    
    var body: some View {
        
        VStack{
            GeometryReader{ proxy in
                Image(uiImage: Bundle.main.icon ?? UIImage())
                    .resizable()
                    .clipShape(.rect(cornerRadius: proxy.size.width * 2/9))
            }
            .frame(width: 80, height: 80)
            .opacity(animationPhase >= 1 ? 1 : 0)
            
            Text("Welcome to Yaha")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .opacity(animationPhase >= 1 ? 1 : 0)
            
            VStack(spacing: 20){
                TutorialElement(iconName: "phone.circle", title: "Emergency number locator", description: "The app determines your country's emergency number.")
                    .opacity(animationPhase >= 2 ? 1 : 0)
                
                TutorialElement(iconName: "doc.on.doc", title: "Copy coordinates", description: "Click on the coordinates to copy them to the clipboard.")
                    .opacity(animationPhase >= 3 ? 1 : 0)
                
                TutorialElement(iconName: "square.and.arrow.down", title: "Download offline maps", description: "Make sure to download offline maps before your journey.")
                    .opacity(animationPhase >= 4 ? 1 : 0)
            }
            .padding(.all)
            
            Spacer()
            
            Button( action: {isOnboarding = false} ) {
                Text("Continue")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .controlSize(.large)
            .tint(.redGradient1)
            .opacity(animationPhase >= 5 ? 1 : 0)
        }
        .padding()
        .padding(.top)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { timer in
                if animationPhase < 5 {
                    withAnimation {
                        animationPhase += 1
                    }
                } else {
                    timer.invalidate()
                }
            }
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
