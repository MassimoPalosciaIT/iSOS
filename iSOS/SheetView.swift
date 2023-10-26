//
//  SheetView.swift
//  iSOS
//
//  Created by Massimo Paloscia on 26/10/23.
//

import SwiftUI
import Foundation
import CoreGraphics

struct SheetView: View {
    
    
    var body: some View {
        
        VStack(spacing: 64){
            HStack{
                VStack{
                    Image(uiImage: Bundle.main.icon ?? UIImage())
                        .resizable()
                        .frame(width: 80,height: 80)
                        .clipShape(Rectangle())
                        .cornerRadius(15)
                    Text("Welcome to the \n HelpApp")
                        .foregroundColor(.white)
                        .font(.system(size: 36))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        
                }
            }
            
            
            VStack(spacing: 20){
                HStack(spacing: 15){
                    Image(systemName: "phone.circle")
                        .font(.system(size: 40))
                        .foregroundColor(Color.redGradient1)
                    VStack(alignment: .leading){
                        Text("Emergency number locator")
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            
                        Text("The app determines your country's emergency number.") .foregroundColor(.gray)
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                        
                    }
                    
                    Spacer()
                }
                
                HStack(spacing: 15){
                    Image(systemName: "square.and.arrow.down")
                        .font(.system(size: 40))
                        .foregroundColor(Color.redGradient1)
                    VStack(alignment: .leading){
                        Text("Download offline maps")
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            
                        Text("Make sure to download offline maps before your journey.") .foregroundColor(.gray)
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                        
                    }
                    
                    Spacer()
                }
                HStack(spacing: 15){
                    Image(systemName: "doc.on.doc")
                        .font(.system(size: 40))
                        .foregroundColor(Color.redGradient1)
                    VStack(alignment: .leading){
                        Text("Copy coordinates")
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            
                        Text("Click on the coordinates to copy \nthem to the clipboard.") .foregroundColor(.gray)
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                        
                    }
                    
                    Spacer()
                }
                
                Button("Continue"){
                    
                }.buttonStyle(CustomButtonStyle())
            }
            .padding(.horizontal, 32)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.iSOSBackground.ignoresSafeArea())
    }
}
struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.redGradient1)
            .foregroundColor(.white)
            .cornerRadius(20)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            
    }
}

extension Bundle {
    
    var icon: UIImage? {
        
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
           let primary = icons["CFBundlePrimaryIcon"] as? [String: Any],
           let files = primary["CFBundleIconFiles"] as? [String],
           let icon = files.last
        {
            return UIImage(named: icon)
        }
        
        return nil
    }
}



#Preview {
    SheetView()
}
