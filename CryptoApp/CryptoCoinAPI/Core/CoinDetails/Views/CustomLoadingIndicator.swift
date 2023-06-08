import SwiftUI

struct CustomLoadingIndicator: View {
    
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
                    Image(systemName: "bitcoinsign.circle")
                        .foregroundColor(.orange)
                        .font(.system(size: 100, weight: .bold))
                        .rotationEffect(Angle(degrees: isAnimating ? 360 : 180))
                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                }
                .onAppear {
                    self.isAnimating = true
                }
            }
        }

struct CustomLoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        CustomLoadingIndicator()
    }
}


