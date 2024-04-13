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
        
        HStack(spacing: 20){
            
            Image(systemName: "xmark")
                .font(.largeTitle)
                .foregroundStyle(.clear)
                .overlay{
                    Image(systemName: iconName)
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .foregroundStyle(.redGradient1)
                }
            
            VStack(alignment: .leading){
                Group{
                    Text(title)
                        .fontWeight(.bold)

                    Text(description)
                        .foregroundStyle(.gray)
                        .fontWeight(.medium)
                }
                .font(.callout)
            }
            
            Spacer()
            
        }
        
    }
}

#Preview {
    TutorialElement(iconName: "xmark", title: "Title", description: "Est enim sit veniam occaecat adipiscing occaecat commodo eu irure consequat irure incididunt magna voluptate sit excepteur sit cupidatat enim. Eiusmod sit officia excepteur sint duis excepteur proident in ad. Elit qui irure enim qui do incididunt magna est commodo cupidatat anim.")
}
