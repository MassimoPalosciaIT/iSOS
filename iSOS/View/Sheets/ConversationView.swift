import SwiftUI

struct ConversationView: View {
    var conversations: [Conversation] = [
        Conversation(questionText: "Hello, I need an ambulance.", answerText: "Salve, mi serve un'ambulanza."),
        Conversation(questionText: "Text 2", answerText: "Texto 2"),
        Conversation(questionText: "Text 2", answerText: "Texto 2"),
        Conversation(questionText: "Text 2", answerText: "Texto 2"),
        Conversation(questionText: "Text 2", answerText: "Texto 2"),
    ]
    
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
            
            ScrollView{
                VStack(spacing:20){
                    
                    ForEach(conversations) { selectedConversation in
                        BlobCombo(messageQuestion: selectedConversation.questionText, messageReply: selectedConversation.answerText)
                        }
                }
                
            }
        }
        .padding(.horizontal)
        .padding(.top)
        .frame(maxHeight: .infinity)
        .background(Color.iSOSGray)
    }
}


#Preview {
    ConversationView()
}
