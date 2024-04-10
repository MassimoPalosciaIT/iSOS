//
//  TextBlob.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

struct TextBlob: View {
    var textContent: String = "2. Call an ambulance as soon as possible."
    var fillColor: Color = .blobGray
    var textColor: Color = .white
    
    var body: some View{
        ZStack{
            Text(textContent.replacingOccurrences(of: "\\n", with: "\n"))
                .frame(maxWidth: .infinity)
                .padding()
                .background(fillColor)
                .cornerRadius(20)
                .foregroundStyle(textColor.opacity(0))
                .multilineTextAlignment(.leading) // Align text to the leading edge
                .lineLimit(nil)
            HStack{
                Text(textContent.replacingOccurrences(of: "\\n", with: "\n"))
                    .fontWeight(.semibold)
                    .padding(.leading)
                    .foregroundStyle(textColor)
                    .multilineTextAlignment(.leading) // Align text to the leading edge
                    .lineLimit(nil)
                
                Spacer()
            }
        }
    }
}
