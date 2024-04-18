import SwiftUI

struct ContentView: View {
    @State private var tabSelected: Tab = .house
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            VStack {
                Header()
                    .zIndex(1)
                    .padding(.top, 55)
                
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
            
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $tabSelected)
                    .zIndex(1)
                    .padding(.bottom, 30)
            }
        }
        .frame(height: UIScreen.main.bounds.height)
        .background(Color("bg-black"))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
