import SwiftUI

enum Tab: String, CaseIterable  {
    case house
    case shuffle
    case star
    case person
}

struct CustomTabBar: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack {
            tabBarContent
        }
        .tabBarStyle()
    }
    
    private var tabBarContent: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tab in
                Spacer()
                tabButton(for: tab)
                Spacer()
            }
        }
    }
    
    private func tabButton(for tab: Tab) -> some View {
        Image(systemName: tab == selectedTab ? fillImage(for: tab) : tab.rawValue)
            .scaleEffect(selectedTab == tab ? 1.4 : 1)
            .foregroundColor(selectedTab == tab ? Color("icon-orange") : Color("imdb-yellow"))
            .font(.system(size: 22))
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.1)) {
                    selectedTab = tab
                }
            }
    }
    
    private func fillImage(for tab: Tab) -> String {
        switch tab {
        case .house: return "house.fill"
        case .shuffle: return "shuffle"
        case .star: return "star.fill"
        case .person: return "person.fill"
        }
    }
}

extension View {
    func tabBarStyle() -> some View {
        self
            .frame(height: 65)
            .background(Color.black)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("imdb-yellow"), lineWidth: 0.3)
            )
            .shadow(radius: 5)
            .padding(.horizontal, 20)

    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.house))
}
