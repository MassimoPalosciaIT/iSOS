//
//  NoLocationView.swift
//  Yaha
//
//  Created by Matt Novoselov on 27/08/24.
//

import SwiftUI

struct NoLocationView: View {
    
    @Environment(LocationModel.self) var locationModel: LocationModel
    
    // Hold active opened sheet for emergency detail view
    @State private var isSheetVisible: Bool = false
    
    var body: some View {
        
        VStack{
            // Button to request location permission
            VStack {
                Text("The app does not have location permissions")
                    .font(.title2)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                
                Button( action: {UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)} ) {
                    Label("Open settings", systemImage: "gearshape.fill")
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(.redGradient2)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background{
                HStack {
                    Spacer()
                    Image(systemName: "xmark.circle")
                        .opacity(0.03)
                        .font(.system(size: 130))
                        .padding(.trailing, -35)
                }
            }
            .background(.mainGray)
            .cornerRadius(20)
            
            Spacer()
            
            // FirstAid Button
            EmergencyMenuButton(title: "First Aid", iconName: "cross.case.fill", gradientColor1: .redGradient1, gradientColor2: .redGradient2){
                isSheetVisible.toggle()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background{
            TopGradient(gradientColor1: .redGradient1, gradientColor2: .redGradient2)
        }
        .background(.mainBackground)
        
        // Present sheet view for First Aid
        .sheet(isPresented: $isSheetVisible) {
            FirstAidView()
                .presentationDragIndicator(.visible)
                .padding(.top)
                .presentationDetents([.large])
                .environment(locationModel)
        }
        
    }
}

#Preview {
    ContentView()
        .environment(LocationModel())
}
