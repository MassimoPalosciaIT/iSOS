//
//  SheetModel.swift
//  iSOS
//
//  Created by Massimo Paloscia on 26/10/23.
//

import SwiftUI

struct SheetModel: View {
    @Environment(\.dismiss) var dismiss

       var body: some View {
           Button("Press to dismiss") {
               dismiss()
           }
           .font(.title)
           .padding()
           .background(.black)
       }
}

#Preview {
    SheetModel()
}
