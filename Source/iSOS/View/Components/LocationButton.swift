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
    
    private var formatedCoordinates: String {
        return locationViewModel.getFormattedCoordinates()
    }
    
    var body: some View {
        
        Button(action: {
            
            softHaptic()
            UIPasteboard.general.setValue(formatedCoordinates, forPasteboardType: UTType.plainText.identifier)
            
            withAnimation() {
                textOpacity = 1.0
            } completion: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation() {
                        textOpacity = 0.0
                    }
                }
            }
            
        })
        {
            AppStandartButton(gradientColor1: backroundColor, gradientColor2: backroundColor, iconName: iconName, iconOpacity: 0.05)
                .overlay{
                    
                    HStack{
                        VStack(alignment: .leading){
                            Group{
                                Label(title, systemImage: iconName)
                                
                                Spacer()
                                
                                Text(formatedCoordinates)
                            }
                            .font(.title2)
                            .fontWeight(.medium)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    
                }
                .overlay{
                    VStack{
                        AppPopupCopy()
                            .opacity(textOpacity)
                        
                        Spacer()
                    }
                    .frame(height: 230)
                    // MARK: 
                }
        }
        .buttonStyle(PlainButtonStyle())
        
    }
}
