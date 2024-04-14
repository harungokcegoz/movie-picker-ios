import SwiftUI

struct ContentView: View {
    @State private var tabSelected: Tab = .shuffle
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack {
            VStack {
                Header()
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
                .padding(.top, 40)
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
