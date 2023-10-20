//
//  CallButtonView.swift
//  iSOS
//
//  Created by Matt Novoselov on 20/10/23.
//

import SwiftUI

struct CallButtonView: View {
    var body: some View {
        Circle().onTapGesture {
            startCall(to: "1234567890")
        }
    }
    
    func startCall(to number: String) {
        guard let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) else {
            print("Error: Unable to initiate call.")
            return
        }
        
        UIApplication.shared.open(url)
    }
}

#Preview {
    CallButtonView()
}
