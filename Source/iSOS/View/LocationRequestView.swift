//
//
//
//
//
//

import SwiftUI

// This View is used to display errors (related to location Model) or request location
struct LocationRequestView: View {
    
    @EnvironmentObject var locationModel: LocationModel
    
    // Main title of the screen
    var title: String
    
    // Trailing SF Symbol of the background
    var symbolBackground: String
    
    // Central SF Symbol
    var symbol: String
    
    // Title for the bottom button
    var buttonTitle: String
    
    // Symbol for the bottom button
    var buttonSymbol: String
    
    // Action for the bottom button
    var action: () -> Void
    
    var body: some View {
        
        AppPopupButton(iconName: symbolBackground)
            .overlay{
                VStack {
                    
                    Text(title)
                        .fontWeight(.bold)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Image(systemName: symbol)
                        .font(.system(size: 128))
                        .fontWeight(.light)
                    
                    Spacer()
                    
                    
                    Button( action: action ) {
                        Label(buttonTitle, systemImage: buttonSymbol)
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(.redGradient2)
                    
                }
                .padding()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background{
                TopGradient(gradientColor1: .redGradient1, gradientColor2: .redGradient2)
            }
            .background(.mainBackground)
        
    }
}


#Preview {
    LocationRequestView(title: "Location use is restricted", symbolBackground: "xmark", symbol: "xmark.circle", buttonTitle: "Open settings", buttonSymbol: "gearshape.fill", action: {UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)})
}
