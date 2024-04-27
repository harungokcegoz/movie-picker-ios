import SwiftUI

struct HouseView: View {
    @State var currentTab: Int = 0
    
    var body: some View {
        movieSeriesTabBar()
    }
}

extension HouseView {
    func movieSeriesTabBar() -> some View {
        VStack {
            TabBarView(currentTab: self.$currentTab)
            ZStack(alignment: .top){
                TabView(selection: self.$currentTab) {
                    movieSliders()
                        .tag(0)
                    seriesSliders()
                        .tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                Spacer()
            }
        }
    }
    
    func movieSliders() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack {
                ScrollCardStack(categoryName: "Top Movies", cardStackType: .movie, isRankingNeeded: true, viewModel: MovieViewModel())
            }
            .padding(.top, 10)
            HStack {
                ScrollCardStack(categoryName: "Coming Soon Trailers", cardStackType: .trailer, isRankingNeeded: false, viewModel: MovieViewModel())
            }
            HStack {
                ScrollCardStack(categoryName: "Recently Awarded", cardStackType: .movie, isRankingNeeded: false, viewModel: MovieViewModel())
            }
            HStack {
                ScrollCardStack(categoryName: "IMDb Bests", cardStackType: .movie, isRankingNeeded: true, viewModel: MovieViewModel())
            }
        }
        .padding(.bottom, 85)
    }
    
    func seriesSliders() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack {
                ScrollCardStack(categoryName: "Top Series", cardStackType: .movie, isRankingNeeded: true, viewModel: MovieViewModel())
            }
            .padding(.top, 10)
            HStack {
                ScrollCardStack(categoryName: "Coming Soon Series", cardStackType: .trailer, isRankingNeeded: false, viewModel: MovieViewModel())
            }
            HStack {
                ScrollCardStack(categoryName: "Recently Awarded", cardStackType: .movie, isRankingNeeded: false, viewModel: MovieViewModel())
            }
            HStack {
                ScrollCardStack(categoryName: "IMDb Bests", cardStackType: .movie, isRankingNeeded: true, viewModel: MovieViewModel())
            }
        }
        .padding(.bottom, 85)
    }
}

struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace
    
    var tabBarOptions: [String] = ["Movies", "Series"]
    var body: some View {
        
        HStack {
            ForEach(Array(zip(self.tabBarOptions.indices,
                              self.tabBarOptions)),
                    id: \.0,
                    content: {
                index, name in
                TabBarItem(currentTab: self.$currentTab,
                           namespace: namespace.self,
                           tabBarItemName: name,
                           tab: index)
                
            })
        }
        .frame(width: 160, height: 30)
        .edgesIgnoringSafeArea(.all)
        .overlay {
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                .frame(width: 160, height: 40)
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
}

struct TabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    
    var tabBarItemName: String
    var tab: Int
    
    var body: some View {
        Button {
            withAnimation(.spring(duration: 0.7)){
                self.currentTab = tab
            }
        } label: {
            ZStack {
                Text(tabBarItemName)
                    .font(Font.custom(currentTab == tab ? "SFProRounded-Regular" : "SFProRounded-Light", size: 13))
                    .zIndex(1)
                    .foregroundColor(currentTab == tab ? .black : .gray)
                    .scaleEffect(currentTab == tab ? 1.2 : 1)
                if currentTab == tab {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.imdbYellow)
                        .frame(width: 80, height: 40)
                } else {
                    Color.clear.frame(height: 2)
                }
            }
        }
        .buttonStyle(.plain)
    }
}
