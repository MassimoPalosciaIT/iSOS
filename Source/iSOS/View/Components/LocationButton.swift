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
    
    @State private var address: String?
    
    private var formatedCoordinates: String {
        return locationViewModel.getFormattedCoordinates()
    }
    
    var body: some View {
        
        Button(action: {
            
            softHaptic()
            
            var copyValue: String = formatedCoordinates
            
            if let address{
                copyValue += "\n\n\(address)"
            }
            
            UIPasteboard.general.setValue(copyValue, forPasteboardType: UTType.plainText.identifier)
            
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
                                
                                Group{
                                    if let address{
                                        Text(address)
                                    } else{
                                        Text(formatedCoordinates)
                                    }
                                }
                                .fontWeight(.regular)
                                .font(.title3)
                            }
                            .font(.title2)
                            .fontWeight(.medium)
                        }
                        .onAppear(){
                            updateAddress()
                        }
                        
                        Spacer()
                    }
                    .padding()
                    
                }
                .overlay{
                    VStack(spacing: 30){
                        AppPopupCopy()
                            .opacity(textOpacity)
                        
                        AppStandartButton(gradientColor1: .clear, gradientColor2: .clear, iconName: "xmark")
                            .padding()
                            .opacity(0)
                            .allowsHitTesting(false)
                    }
                }
        }
        .buttonStyle(PlainButtonStyle())
        
    }
    
    func updateAddress(){
        locationViewModel.getAddress { address in
            if let address = address {
                self.address = address
            } else{
                self.address = nil
            }
        }
    }
}
