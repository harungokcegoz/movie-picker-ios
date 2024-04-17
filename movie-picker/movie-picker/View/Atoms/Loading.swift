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
                        .easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true), value: animationAmount
                    )
                Circle()
                    .stroke(.iconOrange.opacity(0.7), lineWidth: 2)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
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
            .animation(
                .easeInOut(duration: 1.5)
                .repeatForever(autoreverses: true), value: animationAmount
            )
    }

}

#Preview {
    Loading()
}
