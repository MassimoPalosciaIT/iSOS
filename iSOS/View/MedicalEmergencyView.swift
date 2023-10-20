//
//  MedicalEmergencyView.swift
//  iSOS
//
//  Created by Massimo Paloscia on 20/10/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct MedicalEmergencyView: View {
    
    var coordinates: String = "40°50'12.05\"N 14°18'23.70\"E"
    
    var callModel: CallModel = CallModel()
    
    init() {
        let appearance = UINavigationBarAppearance();              appearance.titleTextAttributes = [             
            .font: UIFont.systemFont(ofSize: 24, weight: .bold),
            .foregroundColor: UIColor.white];
        UINavigationBar.appearance().standardAppearance = appearance;
      }
    
    var body: some View {
        
        
        
        VStack(spacing: 10){
            
            ZStack{
                
                VStack {
                    LinearGradient(colors: [.redGradient1, .redGradient2.opacity(0)], startPoint: .top, endPoint: .bottom)
                        .frame(height: 270)
                        .ignoresSafeArea()
                        .opacity(0.7)
                    Spacer()
                }
                
                
                
                VStack(spacing: 10){
                    
                    
                    
                    HStack(spacing: 10){
                        HelpEmergencyButton(title: "First Aid", iconName: "cross.case.fill", gradientColor1: .redGradient1, gradientColor2: .redGradient2)
                        HelpEmergencyButton(title: "Hospitals", iconName: "building.2.fill", gradientColor1: .redGradient1, gradientColor2: .redGradient2)
                    }
                    
                    BigHelpEmergencyButton(title: "Conversation", iconName: "text.bubble.fill", gradientColor1: .redGradient1, gradientColor2: .redGradient2)
                    
                    
                    Spacer()
                    
                    AppButtonCircular(gradientColor1: .redGradient1, gradientColor2: .redGradient2, iconName: "phone.fill").onTapGesture {
                        callModel.startCall(to: "1234")
                    }
                    
                    Spacer()
                    
                    LocationButton(title: "You are here:", iconName: "location.fill", gradientColor1: Color.iSOSGray, gradientColor2: Color.iSOSGray, coordinates: coordinates)
                }
                .padding(.horizontal, 25)
                .padding(.top, 30)
                
                
            }
        }.background(Color.iSOSBackground.ignoresSafeArea())
            .navigationTitle("Medical Help")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MedicalEmergencyView()
}
