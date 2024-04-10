//
//
//
//
//
//

import SwiftUI

struct RequestLocationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
            ZStack{
                TopGradient(gradientColor1: .redGradient1, gradientColor2: .redGradient2)
                
                ZStack{
                    AppPopupButton(iconName: "location.fill")

                    VStack {
                        Text("We need your permission to track the location")
                            .fontWeight(.bold)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                            .padding(.top)
                        
                        Spacer()
                        
                        Image(systemName: "location.circle")
                            .foregroundStyle(.white)
                            .font(.system(size: 128))
                            .fontWeight(.light)
                        
                        Spacer()
                        
                        Group(){
                            Button(action: {
                                locationViewModel.requestPermission()
                            }
                                   ,label: {
                                Label("Allow tracking", systemImage: "location.fill")
                            })
                            .padding(12)
                            .foregroundStyle(.white)
                            .background(.redGradient2)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .padding(.bottom, 20.0)
                        
                    }.frame(height: 340)
                }.padding(.horizontal)
        
            }
            .background(Color.mainBackground.ignoresSafeArea())
    }
}

#Preview {
    RequestLocationView()
}
