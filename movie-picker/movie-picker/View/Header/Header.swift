import SwiftUI

struct Header: View {
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 200, height: 50)
                .padding(.top, 10)
            Divider()
                .frame(height: 1)
                .background(.gray.opacity(0.3))
        }
    }
}

#Preview {
    Header()
}
