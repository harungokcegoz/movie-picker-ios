import SwiftUI

struct ContentView: View {
    @State private var tabSelected: Tab = .shuffle
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("Movie Picker")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("imdb-yellow"))
                    .padding()
                    .overlay(
                        Rectangle()
                            .frame(height: 0.5)
                            .foregroundColor(Color("imdb-yellow"))
                            .padding(.horizontal, -20), // Extend the rectangle beyond the padding of the Text view
                        alignment: .bottom
                    )
            }
        
            ZStack {
                VStack {
                    switch tabSelected {
                    case .house:
                        HouseView()
                    case .shuffle:
                        ShuffleView()
                    case .star:
                        StarView()
                    case .person:
                        PersonView()
                    }
                    Spacer()
                }
            }
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $tabSelected)
            }
        }
        .background(Color("bg-black"))
    }
}

#Preview {
    ContentView()
}
