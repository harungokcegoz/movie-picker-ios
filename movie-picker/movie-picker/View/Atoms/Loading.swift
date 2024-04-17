import SwiftUI

struct Loading: View {
    
    @State private var animationAmount = 1.0
    @State private var isAnimating = true
    
    var body: some View {
        VStack {
            ZStack {
                mainCircle
                loadingText
            }
        }
        .padding()
        .shadow(radius: 10)
        .onAppear {
            animationAmount = 2
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.35) {
                withAnimation(.easeOut(duration: 1)) {
                    isAnimating = false
                }
            }
        }
    }
    
    private var mainCircle: some View {
        Circle()
            .frame(width: 150)
            .foregroundColor(.imdbYellow)
            .overlay {
                Circle()
                    .stroke(
                        RadialGradient(
                            gradient: Gradient(stops: [
                                .init(color: .clear, location: 0.0),
                                .init(color: .imdbYellow.opacity(0.4), location: 0.8)
                            ]),
                            center: .center,
                            startRadius: 0,
                            endRadius: 300
                        ),
                        lineWidth: 100
                    )
                    .scaleEffect(animationAmount)
                    .opacity(Double(2 - animationAmount))
                    .animation(
                        .easeInOut(duration: animationAmount)
                        .repeatForever(autoreverses: true), value: animationAmount
                    )
                Circle()
                    .stroke(Color.iconOrange.opacity(0.7), lineWidth: 2)
                    .shadow(radius: 10)
            }
            .opacity(isAnimating ? 1 : 0)
    }
    
    private var loadingText: some View {
        Image(systemName: "shuffle")
            .foregroundColor(.black)
            .rotation3DEffect(
                .degrees(animationAmount * 360),
                axis: (x: 0, y: 1, z: 0),
                anchor: .center,
                perspective: 1.0
            )
            .scaleEffect(
                abs(animationAmount),
                anchor: .center
            )
            .opacity(isAnimating ? 1 : 0)
            .animation(
                .easeInOut(duration: animationAmount)
                .repeatForever(autoreverses: true), value: animationAmount
            )
    }
}


#Preview {
    Loading()
}
