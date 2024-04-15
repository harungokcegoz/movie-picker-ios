import SwiftUI

struct ContentView: View {
    @State private var tabSelected: Tab = .shuffle
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack {
            Spacer()
            
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
                }
            }
            
            Spacer()
            
            VStack {
                CustomTabBar(selectedTab: $tabSelected)
            }
        }
        .background(Color("bg-black"))
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
