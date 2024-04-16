import SwiftUI

struct Header: View {
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 50)
                .padding(.vertical, 15)
                .overlay(
                    Rectangle()
                        .frame(width: 500, height: 0.5)
                        .opacity(0.5)
                        .foregroundColor(.gray)
                        .padding(.horizontal, -20),
                    alignment: .bottom
                )
                .shadow(radius: 10)
        }
    }
}

#Preview {
    Header()
}
