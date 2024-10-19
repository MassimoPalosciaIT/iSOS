//
//
//
//
//
//

import SwiftUI
import AVFoundation

// The Phrases feature is currently only available and working in Italy due to the lack of localization. This view will not appear in other countries.
struct PhrasesView: View {
    
    @Environment(LocationModel.self) var locationModel: LocationModel
    
    // Get formatted coordinates based on the current location
    private var formattedCoordinates: String {
        return locationModel.getFormattedCoordinates()
    }
    
    // Define emergency type
    var emergencyType: EmergencyType
    
    // Get current address id the internet connection is available
    @State private var address: String?
    
    private let synthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        
        let emergencyPhrases: [Phrases] = getEmergencyPhrases(emergencyType: emergencyType, address: address, formattedCoordinates: formattedCoordinates)
        
        NavigationStack{
            ScrollView(showsIndicators: false){
                
                FlagsView(flag1: "", flag2: "")
                    .opacity(0)
                
                VStack(spacing: 20){
                    ForEach(emergencyPhrases) { phrase in
                        BlobCombo(messageQuestion: phrase.questionText, messageReply: phrase.answerText, synthesizer: synthesizer)
                    }
                }
                
            }
            
            .overlay{
                FlagsView(flag1: "🇬🇧", flag2: "🇮🇹")
                    .accessibilityHidden(true)
            }
            
            .padding(.horizontal)
        }
        .onAppear(){
            updateAddress()
        }
        
    }
    
    // Function to update address when internet connection is available
    func updateAddress(){
        locationModel.getAddress { address in
            if let address = address {
                self.address = address
            } else{
                self.address = nil
            }
        }
    }
}


#Preview {
    PhrasesView(emergencyType: .police)
        .environment(LocationModel())
}
