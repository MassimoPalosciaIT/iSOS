import SwiftUI

struct ConversationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel

    var formattedCoordinates: String {
        return locationViewModel.getFormattedCoordinates()
    }
    
    var emergencyType: EmergencyType

    var convPolice: [Conversation] {
        [
            Conversation(questionText: "Hello, I need to report an emergency.", answerText: "Salve, mi serve un'ambulanza."),
            Conversation(questionText: "My coordinates are: \(formattedCoordinates)", answerText: "Le mie coordinate sono: \(formattedCoordinates)"),
            Conversation(questionText: "There is a [robbery/assault/accident/etc.] occurring.", answerText: "Si sta verificando una [rapina/aggressione/accidente/ecc]."),
            Conversation(questionText: "There are [number] of victims/injured people.", answerText: "Ci sono [numero] di vittime/feriti."),
            Conversation(questionText: "Please send help immediately.", answerText: "Vi prego di inviare immediatamente i soccorsi."),
            Conversation(questionText: "My name is [your name].", answerText: "Il mio nome è [il vostro nome]."),
        ]
    }

    var convFire: [Conversation] {
        [
            Conversation(questionText: "Hello, I need to report a fire emergency.", answerText: "Salve, mi serve un'ambulanza."),
            Conversation(questionText: "My coordinates are: \(formattedCoordinates)", answerText: "Le mie coordinate sono: \(formattedCoordinates)"),
            Conversation(questionText: "The fire is [large/small/spreading rapidly/etc.].", answerText: "L'incendio è [grande/piccolo/che si espande rapidamente/ecc.]"),
            Conversation(questionText: "Please send help immediately; it's urgent.", answerText: "Vi prego di inviare immediatamente i soccorsi; è urgente."),
            Conversation(questionText: "My name is [your name].", answerText: "Il mio nome è [il vostro nome]."),
        ]
    }

    var convMedical: [Conversation] {
        [
            Conversation(questionText: "Hello, I need medical assistance immediately.", answerText: "Salve, mi serve un'ambulanza."),
            Conversation(questionText: "My coordinates are: \(formattedCoordinates)", answerText: "Le mie coordinate sono: \(formattedCoordinates)"),
            Conversation(questionText: "Someone is injured/ill.", answerText: "Qualcuno è ferito/malato."),
            Conversation(questionText: "There has been an accident.", answerText: "C'è stato un incidente."),
            Conversation(questionText: "The person is [conscious/unconscious/breathing/not breathing].", answerText: "La persona è [cosciente/incosciente/respira/non respira]."),
            Conversation(questionText: "Please send help quickly; it's urgent.", answerText: "Vi prego di inviare rapidamente i soccorsi, è urgente."),
            Conversation(questionText: "My name is [your name].", answerText: "Il mio nome è [il vostro nome]."),
        ]
    }
    
    var body: some View {
        VStack (spacing: 10){
            HStack{
                Text("Conversation")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                Spacer()
            }
            
            HStack{
                Group{
                    Text("🇬🇧")
                    Spacer()
                    Text("🇮🇹")

                }
                .font(.system(size: 64))
                .foregroundStyle(.white)
            }
            
            ScrollView(showsIndicators: false){
                VStack(spacing:20){
                    
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
        }
        .padding(.horizontal)
        .padding(.top)
        .frame(maxHeight: .infinity)
    }
}


#Preview {
    ConversationView(emergencyType: .police).environmentObject(LocationViewModel())
}
