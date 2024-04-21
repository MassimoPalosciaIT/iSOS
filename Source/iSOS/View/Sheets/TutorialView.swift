//
//
//
//
//
//

import SwiftUI

// Tutorial View only appears the first time user enters the app and completes onboarding
struct TutorialView: View {
    
    // Extract isOnboarding value from the system defaults
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    // Animate tutorial sheet with gradual fade animation
    @State var animationPhase: Int = 0
    
    var body: some View {
        
        VStack{
            // Wrap app icon into the GeometryReader to determine the perfect corner radius
            GeometryReader{ proxy in
                Image(uiImage: Bundle.main.icon ?? UIImage())
                    .resizable()
                    .clipShape(.rect(cornerRadius: proxy.size.width * 2/9))
            }
            .frame(width: 80, height: 80)
            .opacity(animationPhase >= 1 ? 1 : 0)
            
            // Main title
            Text("Welcome to Yaha")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .opacity(animationPhase >= 1 ? 1 : 0)
            
            // List of tutorial elements
            VStack(spacing: 20){
                TutorialElement(iconName: "phone.circle", title: "Emergency number locator", description: "The app determines your country's emergency number.")
                    .opacity(animationPhase >= 2 ? 1 : 0)
                
                TutorialElement(iconName: "doc.on.doc", title: "Copy address", description: "Click on the address to copy it to the clipboard.")
                    .opacity(animationPhase >= 3 ? 1 : 0)
                
                TutorialElement(iconName: "square.and.arrow.down", title: "Download offline maps", description: "Make sure to download offline maps before your journey.")
                    .opacity(animationPhase >= 4 ? 1 : 0)
            }
            .padding(.all)
            
            Spacer()
            
            // Button that closes onboarding sheet and marks onboarding as complete
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
        // Prevent sheet from dismissing until tutorial is complete
        .interactiveDismissDisabled()
        
        // Start fade phase animation on appear
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

// Extension to extract app icon from assets
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
