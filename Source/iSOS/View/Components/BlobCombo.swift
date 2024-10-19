//
//  BlobCombo.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI
import UniformTypeIdentifiers

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
                        .background(.mainGray)
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
                        .background(.blobGray)
                        .clipShape(BubbleShape(myMessage: true))
                        .fontWeight(.semibold)
                }
            }
            .accessibilityLabel("Italian. \(messageQuestion)")
        }
        
        // Action buttons under message
        HStack{
            Group{
                // Copy message to clipboard
                Button(action: {copyToClipboard(messageReply)}) {
                    Label("Copy to clipboard", systemImage: "rectangle.portrait.on.rectangle.portrait")
                        .labelStyle(.iconOnly)
                }
                
                // Playback message
                Button(action: {}) {
                    Label("Playback", systemImage: "speaker.wave.3")
                        .labelStyle(.iconOnly)
                }
            }
            .foregroundStyle(.gray)
            .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        
    }
    
    // Copy value to the clipboard
    func copyToClipboard(_ copyValue: String) {
        UIPasteboard.general.setValue(copyValue, forPasteboardType: UTType.plainText.identifier)
    }
}

#Preview {
    BlobCombo(messageQuestion: "Est enim sit veniam occaecat adipiscing occaecat commodo eu irure consequat irure incididunt magna voluptate sit excepteur sit cupidatat enim. Eiusmod sit officia excepteur sint duis excepteur proident in ad. Elit qui irure enim qui do incididunt magna est commodo cupidatat anim.", messageReply: "Est enim sit veniam occaecat adipiscing occaecat commodo eu irure consequat irure incididunt magna voluptate sit excepteur sit cupidatat enim. Eiusmod sit officia excepteur sint duis excepteur proident in ad. Elit qui irure enim qui do incididunt magna est commodo cupidatat anim.")
}
