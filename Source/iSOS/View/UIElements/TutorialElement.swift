//
//  TutorialElement.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI

struct TutorialElement: View {
    var iconName: String
    var title: String
    var description: String
    
    var body: some View {
        HStack(){
            
            Image(systemName: iconName)
                .font(.system(size: 40))
                .fontWeight(.medium)
                .foregroundStyle(.redGradient1)
                .padding(.trailing, 20)
                .frame(width: 40,height: 40)
            
            
            HStack{
                VStack(alignment: .leading){
                    Text(title)
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    
                    Text(description)
                        .foregroundStyle(.gray)
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                }
            }
            Spacer()
        }.padding(.horizontal, 10)
    }
}

struct TutorialButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.redGradient1)
            .cornerRadius(15)
    }
}
