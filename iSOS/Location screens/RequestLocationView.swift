import SwiftUI

struct RequestLocationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        VStack {
            ZStack{
                VStack {
                    LinearGradient(colors: [.redGradient1, .redGradient2.opacity(0)], startPoint: .top, endPoint: .bottom)
                        .frame(height: 270)
                        .ignoresSafeArea()
                        .opacity(0.7)
                    Spacer()
                }
                
                ZStack{
                    AppButton_popup(gradientColor1: Color.iSOSGray, gradientColor2: Color.iSOSGray, iconName: "location.fill")
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
                            .padding(10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }.padding(.bottom, 20.0)
                        
                    }.frame(height: 340)
                }.padding(.horizontal, 25)
        
            }
            .background(Color.iSOSBackground.ignoresSafeArea())
        }
    }
}

struct AppButton_popup: View {
    var gradientColor1: Color
    var gradientColor2: Color
    var iconName: String
    
    let cornerRadius: Double = 20
    let frameHeight: Double = 340
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(LinearGradient(colors: [gradientColor1, gradientColor2], startPoint: .leading, endPoint: .trailing))
            .frame(height: frameHeight)
            .overlay(
                HStack() {
                    
                    Image(systemName: iconName)
                        .foregroundColor(.white)
                        .opacity(0.03)
                        .font(.system(size: 256))
                        .padding(.trailing, 200)
                    Spacer()
                }.mask(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: frameHeight, height: frameHeight)
                    
                )
            )
    }
}

#Preview {
    RequestLocationView()
}
