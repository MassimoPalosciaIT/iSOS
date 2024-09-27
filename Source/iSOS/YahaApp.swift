//
//
//
//
//
//

import SwiftUI

// Yaha stands for:
//
// Yet
// Another
// Help
// App
//
// Yaha

@main
struct YahaApp: App {
    
    // Load Location Model
    @State var locationModel = LocationModel()
    
    // Load App Settings
    @State var appSettings = AppSettings()
    
    // Get onboarding complete value from the user defaults
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    var body: some Scene {
        
        WindowGroup {
            Group{
                // Present Onboarding the first time user enters the app
                if isOnboarding {
                    TutorialView()
                } else {
                    ContentView()
                }
            }
            
            .sheet(isPresented: $appSettings.isDebugSheetPresented){
                DebugView()
            }
            
            .transition(.blurReplace)
            .animation(.easeInOut, value: isOnboarding)
            .environment(locationModel)
            .environment(appSettings)
            .preferredColorScheme(.dark)
        }
    }
}
