//
//  FireDepartmentView.swift
//  iSOS
//
//  Created by Massimo Paloscia on 20/10/23.
//

import SwiftUI

struct FireDepartmentView: View {
    var coordinates: String = "40°50'12.05\"N 14°18'23.70\"E"
    
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
                    LinearGradient(colors: [.orangeGradient1, .orangeGradient2.opacity(0)], startPoint: .top, endPoint: .bottom)
                        .frame(height: 270)
                        .ignoresSafeArea()
                        .opacity(0.7)
                    Spacer()
                }
                
                
                
                VStack(spacing: 10){
                    
                    
                    
                    BigHelpEmergencyButton(title: "First Aid", iconName: "house.lodge.fill", gradientColor1: .orangeGradient1, gradientColor2: .orangeGradient2)
                    BigHelpEmergencyButton(title: "Conversation", iconName: "text.bubble.fill", gradientColor1: .orangeGradient1, gradientColor2: .orangeGradient2)
                    
                    
                    Spacer()
                    
                    AppButtonCircular(gradientColor1: .orangeGradient1, gradientColor2: .orangeGradient2, iconName: "phone.fill")
                    
                    Spacer()
                    
                    LocationButton(title: "You are here:", iconName: "location.fill", gradientColor1: Color.iSOSGray, gradientColor2: Color.iSOSGray, coordinates: coordinates)
                }
                .padding(.horizontal, 25)
                .padding(.top, 30)
                
                
            }
        }.background(Color.iSOSBackground.ignoresSafeArea())
            .navigationTitle("Fire Department")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FireDepartmentView()
}
