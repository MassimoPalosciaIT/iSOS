//
//  LocationButton.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct LocationButton: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    @State private var textOpacity: Double = 0.0
    
    let title: String = "You are here:"
    let iconName: String = "location.fill"
    let backroundColor: Color = .mainGray
    
    var formatedCoordinates: String {
        return locationViewModel.getFormattedCoordinates()
    }
    
    var body: some View {
        Button(action: {
            softHaptic()
            UIPasteboard.general.setValue(formatedCoordinates,
                                          forPasteboardType: UTType.plainText.identifier)
            
            withAnimation(.easeIn(duration: 0.4)) {
                textOpacity = 1.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                withAnimation(.easeOut(duration: 0.4)) {
                    textOpacity = 0.0
                }
            }
            
        }) {
            
            ZStack{
                AppStandartButton(gradientColor1: backroundColor, gradientColor2: backroundColor, iconName: iconName, iconOpacity: 0.05)
                
                VStack{
                    HStack {
                        Group {
                            Image(systemName: iconName)
                                .padding(.leading, 20)
                            Text(title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .font(.system(size: 24))
                        .fontWeight(.medium)
                    }.padding(.top, 20.0)
                    
                    Spacer()
                    
                    HStack{
                        Text(formatedCoordinates)
                            .font(.system(size: 21))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .padding([.leading, .bottom], 20.0)
                        Spacer()
                    }
                }.frame(maxHeight: 125)
            }.overlay(
                VStack(){
                    AppPopupCopy()
                        .opacity(textOpacity)
                    
                    Spacer()
                }.frame(height: 230)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
