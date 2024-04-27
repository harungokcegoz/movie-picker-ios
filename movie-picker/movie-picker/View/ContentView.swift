import SwiftUI

struct ContentView: View {
    @State private var tabSelected: Tab = .house
    @ObservedObject var vm: MovieViewModel
    
    init() {
        UITabBar.appearance().isHidden = true
        vm = MovieViewModel()
    }
    
    var body: some View {
        ZStack {
            Color(.bgDarkerBlack)
                .ignoresSafeArea()
            SideMenu(vm: self.vm)
                .opacity(vm.isSideMenuOpen ? 1 : 0)
            ZStack{
                Color(.bgBlack)
                pageView()
            }
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .rotation3DEffect(
                .degrees(30),
                axis: (x: 0.0, y: vm.isSideMenuOpen ? -1 : 0, z: 0.0)
            )
            .offset(x: vm.isSideMenuOpen ? 280 : 0)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

extension ContentView {
    @ViewBuilder
    func pageView() -> some View {
        VStack {
            Header(vm: self.vm)
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
}


#Preview {
    ContentView()
}
