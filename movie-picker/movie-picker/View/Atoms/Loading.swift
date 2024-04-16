import SwiftUI

struct Loading: View {
    
    @State private var animationAmount = 1.0
    
    var body: some View {
        VStack {
            ZStack {
                mainCircle
                loadingText
            }
        }
        .onAppear {
            animationAmount = 2
        }
        .padding()
        .shadow(radius: 10)
    }
    
    private var mainCircle: some View {
        Circle()
            .frame(width: 150)
            .foregroundColor(.imdbYellow)
            .overlay {
                Circle()
                    .stroke(.iconOrange, lineWidth: 10)
                    .scaleEffect(animationAmount)
                    .opacity(Double(2 - animationAmount))
                    .animation(
                        .easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: false), value: animationAmount
                    )
                Circle()
                    .stroke(.iconOrange.opacity(0.7), lineWidth: 2)
            }
    }
    
    private var loadingText: some View {
        VStack {
            Image(systemName: "shuffle")
                .foregroundColor(.black)
               
        }
        .scaleEffect(animationAmount)
        .animation(
            .easeInOut(duration: 1.5)
            .repeatForever(autoreverses: false), value: animationAmount
        )
        
    }
}

#Preview {
    Loading()
}
