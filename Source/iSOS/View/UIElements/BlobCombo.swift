//
//  BlobCombo.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

struct BlobCombo: View {
    var messageQuestion: String
    var messageReply: String
    
    var body: some View {
        VStack(spacing: 10){
            HStack{
                HStack{
                    Text(messageQuestion)
                        .padding()
                        .background(Color(.iSOSGray))
                        .clipShape(BubbleShape(myMessage: false))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .frame(width: 300)
                
                Spacer()
            }
            
            HStack{
                Spacer()
                
                HStack{
                    Spacer()
                    Text(messageReply)
                        .padding()
                        .background(Color(.blobGray))
                        .clipShape(BubbleShape(myMessage: true))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .frame(width: 300)
            }
        }
    }
}
