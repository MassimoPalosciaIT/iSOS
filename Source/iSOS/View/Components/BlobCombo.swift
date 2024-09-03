//
//  BlobCombo.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

// BlobCombo is used for Phrases view screen
struct BlobCombo: View {
    
    var messageQuestion: String
    var messageReply: String
    
    var body: some View {
        
        VStack{
            // English message (left tail)
            HStack{
                HStack{
                    Text(messageQuestion)
                        .padding()
                        .background(Color(.mainGray))
                        .clipShape(BubbleShape(myMessage: false))
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                
                Spacer()
            }
            .accessibilityLabel("English. \(messageQuestion)")
            
            // Translated language message (right tail)
            HStack{
                Spacer()
                
                HStack{
                    Spacer()
                    Text(messageReply)
                        .padding()
                        .background(Color(.blobGray))
                        .clipShape(BubbleShape(myMessage: true))
                        .fontWeight(.semibold)
                }
            }
            .accessibilityLabel("Italian. \(messageQuestion)")
        }
        
    }
}

#Preview {
    BlobCombo(messageQuestion: "Est enim sit veniam occaecat adipiscing occaecat commodo eu irure consequat irure incididunt magna voluptate sit excepteur sit cupidatat enim. Eiusmod sit officia excepteur sint duis excepteur proident in ad. Elit qui irure enim qui do incididunt magna est commodo cupidatat anim.", messageReply: "Est enim sit veniam occaecat adipiscing occaecat commodo eu irure consequat irure incididunt magna voluptate sit excepteur sit cupidatat enim. Eiusmod sit officia excepteur sint duis excepteur proident in ad. Elit qui irure enim qui do incididunt magna est commodo cupidatat anim.")
}
