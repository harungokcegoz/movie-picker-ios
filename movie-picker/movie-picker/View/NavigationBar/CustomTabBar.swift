//
//  CustomTabBar.swift
//  movie-picker
//
//  Created by Harun Mert Gokcegoz on 09/04/2024.
//

import SwiftUI

enum Tab: String, CaseIterable  {
    case house
    case shuffle
    case star
    case person
}


struct CustomTabBar: View {
    
    @Binding var selectedTab: Tab
    private var fillImage: String {
        switch selectedTab {
        case .house:
            return "house.fill"
        case .shuffle:
            return "shuffle"
        case .star:
            return "star.fill"
        case .person:
            return "person.fill"
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Spacer()
                    Image(systemName: tab == selectedTab ? fillImage : tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.4 : 1)
                        .foregroundColor(selectedTab == tab ? Color("icon-orange") : Color("imdb-yellow"))
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
        }
        .frame(width: nil, height: 65)
        .background(Color.black)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("imdb-yellow"), lineWidth: 0.3)
        )
        .shadow(radius: 5)
        .padding(20)
    }
    
}

#Preview {
    CustomTabBar(selectedTab: .constant(.house))
}
