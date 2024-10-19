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
    
    // MARK:
    // Define Phrases for police
    private var phrasesPolice: [Phrases] {
        [
            Phrases(questionText: "Hello, I need to report an emergency.", answerText: "Salve, mi serve un'ambulanza."),
            Phrases(questionText: "\(address ?? "") \((address != nil) ? "\n\n" : "")My coordinates are: \(formattedCoordinates)", answerText: "\(address ?? "") \((address != nil) ? "\n\n" : "")Le mie coordinate sono: \(formattedCoordinates)\n\n(\(translateCoordinates(coordinate: formattedCoordinates)))"),
            Phrases(questionText: "There is a [robbery/assault/accident/etc.] occurring.", answerText: "Si sta verificando una [rapina/aggressione/accidente/ecc]."),
            Phrases(questionText: "There are [number] of victims/injured people.", answerText: "Ci sono [numero] di vittime/feriti."),
            Phrases(questionText: "Please send help immediately.", answerText: "Vi prego di inviare immediatamente i soccorsi."),
            Phrases(questionText: "My name is [your name].", answerText: "Il mio nome è [il vostro nome]."),
        ]
    }
    
    // Define phrases for Fire department
    private var phrasesFireDepartment: [Phrases] {
        [
            Phrases(questionText: "Hello, I need to report a fire emergency.", answerText: "Salve, mi serve un'ambulanza."),
            Phrases(questionText: "\(address ?? "") \((address != nil) ? "\n\n" : "")My coordinates are: \(formattedCoordinates)", answerText: "\(address ?? "") \((address != nil) ? "\n\n" : "")Le mie coordinate sono: \(formattedCoordinates)\n\n(\(translateCoordinates(coordinate: formattedCoordinates)))"),
            Phrases(questionText: "The fire is [large/small/spreading rapidly/etc.].", answerText: "L'incendio è [grande/piccolo/che si espande rapidamente/ecc.]"),
            Phrases(questionText: "Please send help immediately; it's urgent.", answerText: "Vi prego di inviare immediatamente i soccorsi; è urgente."),
            Phrases(questionText: "My name is [your name].", answerText: "Il mio nome è [il vostro nome]."),
        ]
    }
    
    // Define phrases for Medical Help department
    private var phrasesMedicalHelp: [Phrases] {
        [
            Phrases(questionText: "Hello, I need medical assistance immediately.", answerText: "Salve, mi serve un'ambulanza."),
            Phrases(questionText: "\(address ?? "") \((address != nil) ? "\n\n" : "")My coordinates are: \(formattedCoordinates)", answerText: "\(address ?? "") \((address != nil) ? "\n\n" : "")Le mie coordinate sono: \(formattedCoordinates)\n\n(\(translateCoordinates(coordinate: formattedCoordinates)))"),
            Phrases(questionText: "Someone is injured/ill.", answerText: "Qualcuno è ferito/malato."),
            Phrases(questionText: "There has been an accident.", answerText: "C'è stato un incidente."),
            Phrases(questionText: "The person is [conscious/unconscious/breathing/not breathing].", answerText: "La persona è [cosciente/incosciente/respira/non respira]."),
            Phrases(questionText: "Please send help quickly; it's urgent.", answerText: "Vi prego di inviare rapidamente i soccorsi, è urgente."),
            Phrases(questionText: "My name is [your name].", answerText: "Il mio nome è [il vostro nome]."),
        ]
    }
    
    var body: some View {
        
        NavigationStack{
            ScrollView(showsIndicators: false){
                
                FlagsView(flag1: "", flag2: "")
                    .opacity(0)
                
                VStack(spacing: 20){
                    switch emergencyType {
                    case .police:
                        
                        ForEach(phrasesPolice) { phrase in
                            BlobCombo(messageQuestion: phrase.questionText, messageReply: phrase.answerText, synthesizer: synthesizer)
                        }
                        
                    case .medicalHelp:
                        
                        ForEach(phrasesMedicalHelp) { phrase in
                            BlobCombo(messageQuestion: phrase.questionText, messageReply: phrase.answerText, synthesizer: synthesizer)
                        }
                        
                    case .fireDepartment:
                        
                        ForEach(phrasesFireDepartment) { phrase in
                            BlobCombo(messageQuestion: phrase.questionText, messageReply: phrase.answerText, synthesizer: synthesizer)
                        }
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

// Flags View for on top overlay of PhrasesView
struct FlagsView: View {
    
    var flag1: String
    var flag2: String
    
    var body: some View {
        VStack{
            
            HStack{
                Group{
                    Text("🇬🇧")
                    Spacer()
                    Text("🇮🇹")
                }
                .font(.system(size: 64))
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .background(.thinMaterial)
            .clipShape(.rect(cornerRadius: 10))
            
            Spacer()
            
        }
    }
}


#Preview {
    PhrasesView(emergencyType: .police)
        .environment(LocationModel())
}
