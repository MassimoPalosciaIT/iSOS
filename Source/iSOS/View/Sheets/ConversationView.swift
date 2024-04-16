//
//
//
//
//
//

import SwiftUI

struct ConversationView: View {
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    private var formattedCoordinates: String {
        return locationViewModel.getFormattedCoordinates()
    }
    
    var emergencyType: EmergencyType
    
    @State private var address: String?
    
    // MARK:
    private var convPolice: [Conversation] {
        [
            Conversation(questionText: "Hello, I need to report an emergency.", answerText: "Salve, mi serve un'ambulanza."),
            Conversation(questionText: "\(address ?? "") \((address != nil) ? "\n\n" : "")My coordinates are: \(formattedCoordinates)", answerText: "\(address ?? "") \((address != nil) ? "\n\n" : "")Le mie coordinate sono: \(formattedCoordinates)\n\n(\(translateCoordinates(coordinate: formattedCoordinates)))"),
            Conversation(questionText: "There is a [robbery/assault/accident/etc.] occurring.", answerText: "Si sta verificando una [rapina/aggressione/accidente/ecc]."),
            Conversation(questionText: "There are [number] of victims/injured people.", answerText: "Ci sono [numero] di vittime/feriti."),
            Conversation(questionText: "Please send help immediately.", answerText: "Vi prego di inviare immediatamente i soccorsi."),
            Conversation(questionText: "My name is [your name].", answerText: "Il mio nome è [il vostro nome]."),
        ]
    }
    
    private var convFire: [Conversation] {
        [
            Conversation(questionText: "Hello, I need to report a fire emergency.", answerText: "Salve, mi serve un'ambulanza."),
            Conversation(questionText: "\(address ?? "") \((address != nil) ? "\n\n" : "")My coordinates are: \(formattedCoordinates)", answerText: "\(address ?? "") \((address != nil) ? "\n\n" : "")Le mie coordinate sono: \(formattedCoordinates)\n\n(\(translateCoordinates(coordinate: formattedCoordinates)))"),
            Conversation(questionText: "The fire is [large/small/spreading rapidly/etc.].", answerText: "L'incendio è [grande/piccolo/che si espande rapidamente/ecc.]"),
            Conversation(questionText: "Please send help immediately; it's urgent.", answerText: "Vi prego di inviare immediatamente i soccorsi; è urgente."),
            Conversation(questionText: "My name is [your name].", answerText: "Il mio nome è [il vostro nome]."),
        ]
    }
    
    private var convMedical: [Conversation] {
        [
            Conversation(questionText: "Hello, I need medical assistance immediately.", answerText: "Salve, mi serve un'ambulanza."),
            Conversation(questionText: "\(address ?? "") \((address != nil) ? "\n\n" : "")My coordinates are: \(formattedCoordinates)", answerText: "\(address ?? "") \((address != nil) ? "\n\n" : "")Le mie coordinate sono: \(formattedCoordinates)\n\n(\(translateCoordinates(coordinate: formattedCoordinates)))"),
            Conversation(questionText: "Someone is injured/ill.", answerText: "Qualcuno è ferito/malato."),
            Conversation(questionText: "There has been an accident.", answerText: "C'è stato un incidente."),
            Conversation(questionText: "The person is [conscious/unconscious/breathing/not breathing].", answerText: "La persona è [cosciente/incosciente/respira/non respira]."),
            Conversation(questionText: "Please send help quickly; it's urgent.", answerText: "Vi prego di inviare rapidamente i soccorsi, è urgente."),
            Conversation(questionText: "My name is [your name].", answerText: "Il mio nome è [il vostro nome]."),
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
                        
                        ForEach(convPolice) { selectedConversation in
                            BlobCombo(messageQuestion: selectedConversation.questionText, messageReply: selectedConversation.answerText)
                        }
                        
                    case .medicalHelp:
                        
                        ForEach(convMedical) { selectedConversation in
                            BlobCombo(messageQuestion: selectedConversation.questionText, messageReply: selectedConversation.answerText)
                        }
                        
                    case .fireDepartment:
                        
                        ForEach(convFire) { selectedConversation in
                            BlobCombo(messageQuestion: selectedConversation.questionText, messageReply: selectedConversation.answerText)
                        }
                    }
                }
                
            }
            .overlay{
                FlagsView(flag1: "🇬🇧", flag2: "🇮🇹")
            }
            .padding(.horizontal)
        }
        .onAppear(){
            updateAddress()
        }
        
    }
    
    func updateAddress(){
        locationViewModel.getAddress { address in
            if let address = address {
                self.address = address
            } else{
                self.address = nil
            }
        }
    }
}

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
    ConversationView(emergencyType: .police).environmentObject(LocationViewModel())
}
