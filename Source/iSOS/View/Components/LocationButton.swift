//
//  LocationButton.swift
//  iSOS
//
//  Created by Matt Novoselov on 15/03/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct LocationButton: View {
    
    @EnvironmentObject var locationModel: LocationModel
    
    // textOpacity is used for popup notification to indicate that coordinates were copied. Animated property
    @State private var textOpacity: Double = 0.0
    
    let title: String = "You are here:"
    let iconName: String = "location.fill"
    let backgroundColor: Color = .mainGray
    
    // Address is only displayed if Location Model is able to determine exact address
    @State private var address: String?
    
    private var formattedCoordinates: String {
        return locationModel.getFormattedCoordinates()
    }
    
    var body: some View {
        
        Button(action: {
            
            // Perform soft haptic feedback
            softHaptic()
            
            // Compose value for copying
            var copyValue: String = formattedCoordinates
            
            // Add address, if available to the copy value
            if let address{
                copyValue += "\n\n\(address)"
            }
            
            // Copy value to the clipboard
            UIPasteboard.general.setValue(copyValue, forPasteboardType: UTType.plainText.identifier)
            
            // Perform popup animation
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
            AppStandardButton(gradientColor1: backgroundColor, gradientColor2: backgroundColor, iconName: iconName, iconOpacity: 0.05)
                .overlay{
                    
                    HStack{
                        VStack(alignment: .leading){
                            Group{
                                Label(title, systemImage: iconName)
                                
                                Spacer()
                                
                                Group{
                                    // Address is only displayed if Location Model is able to determine exact address
                                    if let address{
                                        Text(address)
                                    } else{
                                        Text(formattedCoordinates)
                                    }
                                }
                                .fontWeight(.regular)
                                .font(.title3)
                            }
                            .font(.title2)
                            .fontWeight(.medium)
                        }
                        // Update address the first time button appears on the screen. This is done to prevent the overflow of apple services and to avoid cool-out time fine
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
                        
                        AppStandardButton(gradientColor1: .clear, gradientColor2: .clear, iconName: "xmark")
                            .padding()
                            .opacity(0)
                            .allowsHitTesting(false)
                    }
                }
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityHint("Tap to copy your current location")
        
    }
    
    // Update coordinates
    func updateAddress(){
        locationModel.getAddress { address in
            if let address = address {
                self.address = address
            } else{
                self.address = nil
            }
        }
    }
}
