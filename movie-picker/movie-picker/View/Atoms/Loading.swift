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
            .overlay {
                Circle()
                    .stroke(Color("imdb-yellow"), lineWidth: 5)
                    .scaleEffect(animationAmount)
                    .opacity(Double(2 - animationAmount))
                    .animation(
                        .easeInOut(duration: 1)
                            .repeatForever(autoreverses: false), value: animationAmount
                    )
            }
    }
    
    private var loadingText: some View {
        Text("Loading")
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundColor(Color("imdb-yellow"))
            .padding()
    }
}

#Preview {
    Loading()
}
