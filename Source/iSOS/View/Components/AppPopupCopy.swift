//
//  AppPopupCopy.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

struct AppPopupCopy: View {
    
    let title: String = "Address copied to the clipboard"
    let iconName = "doc.on.doc.fill"
    
    var body: some View {
        
        Label(title, systemImage: iconName)
            .font(.headline)
            .fontWeight(.medium)
            .padding(.all, 10)
            .frame(maxWidth: .infinity)
            .background(.mainGray)
            .clipShape(.rect(cornerRadius: 90))
        
    }
}

#Preview {
    AppPopupCopy()
}
