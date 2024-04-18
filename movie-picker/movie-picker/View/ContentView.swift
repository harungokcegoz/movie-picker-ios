import SwiftUI

struct ContentView: View {
    @State private var tabSelected: Tab = .house
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            Color.bgBlack
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            
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
            Spacer()
            }
            
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $tabSelected)
                    .zIndex(1)
                    .padding(.bottom, 30)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
