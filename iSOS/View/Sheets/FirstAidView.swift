//
//  FirstAidSheetView.swift
//  iSOS
//
//  Created by Massimo Paloscia on 27/10/23.
//

import SwiftUI

struct FirstAidView: View {
    var body: some View {
        VStack{
        
            ScrollView{
                Spacer()
                FirstAidSelectionButton(iconName: "drop.fill", title: "Bleeding", gradientColor1: .redGradient1, gradientColor2: .redGradient2)
                FirstAidSelectionButton(iconName: "bolt.heart", title: "Heart Attack", gradientColor1: .redGradient1, gradientColor2: .redGradient2)
                FirstAidSelectionButton(iconName: "brain.head.profile", title: "Stroke", gradientColor1: .redGradient1, gradientColor2: .redGradient2)
                FirstAidSelectionButton(iconName: "bandage", title: "Fracture", gradientColor1: .redGradient1, gradientColor2: .redGradient2)
                FirstAidSelectionButton(iconName: "rays", title: "Asthma Attack", gradientColor1: .redGradient1, gradientColor2: .redGradient2)
                FirstAidSelectionButton(iconName: "flame", title: "Diabetic Emegerncy", gradientColor1: .redGradient1, gradientColor2: .redGradient2)
                FirstAidSelectionButton(iconName: "flame", title: "Epileptic seizure", gradientColor1: .redGradient1, gradientColor2: .redGradient2)
                FirstAidSelectionButton(iconName: "flame", title: "Allergic reaction", gradientColor1: .redGradient1, gradientColor2: .redGradient2)
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.iSOSBackground.ignoresSafeArea())
    }
}

#Preview {
    FirstAidView()
}
