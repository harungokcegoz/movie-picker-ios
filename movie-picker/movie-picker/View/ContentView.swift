import SwiftUI

struct ContentView: View {
    @State private var tabSelected: Tab = .house
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack {
            Header()
            
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
        
            CustomTabBar(selectedTab: $tabSelected)
                .padding(.top, 50)
        }
        .frame(height: UIScreen.main.bounds.height)
        .background(Color("bg-black"))
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
