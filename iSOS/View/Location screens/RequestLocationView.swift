import SwiftUI

struct RequestLocationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
            ZStack{
                TopGradient(gradientColor1: .redGradient1, gradientColor2: .redGradient2)
                
                ZStack{
                    AppPopupButton(iconName: "location.fill")

                    VStack {
                        Text("We need your permission")
                            .fontWeight(.bold)
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                            .padding(.top, 20.0)
                        
                        Spacer()
                        
                        Image(systemName: "location.circle")
                            .foregroundColor(.white)
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
                            .foregroundColor(.white)
                            .background(.redGradient2)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }.padding(.bottom, 20.0)
                        
                    }.frame(height: 340)
                }.padding(.horizontal)
        
            }
            .background(Color.iSOSBackground.ignoresSafeArea())
    }
}

#Preview {
    RequestLocationView()
}
