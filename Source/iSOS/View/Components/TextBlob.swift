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
    
    var body: some View{
        
        HStack{
            Text(textContent.replacingOccurrences(of: "\\n", with: "\n"))
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading) // Align text to the leading edge
                .lineLimit(nil)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(fillColor)
        .cornerRadius(20)

    }
}

#Preview {
    TextBlob(textContent: "Est enim sit veniam occaecat adipiscing occaecat commodo eu irure consequat irure incididunt magna voluptate sit excepteur sit cupidatat enim. Eiusmod sit officia excepteur sint duis excepteur proident in ad. Elit qui irure enim qui do incididunt magna est commodo cupidatat anim.", fillColor: .red)
}
