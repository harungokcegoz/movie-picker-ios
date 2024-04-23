import SwiftUI

struct SideMenu: View {
    @State private var selectedMood: MenuItem? = menuItems.first
    @ObservedObject var vm: MovieViewModel
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                CloseButton()
            }
            
            HeaderView()
            
            Divider()
            
            ForEach(menuItems) { mood in
                MenuItemView(mood: mood, isSelected: mood == selectedMood)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            self.selectedMood = mood
                        }
                    }
            }
            
            Spacer()
        }
        .menuStyle()
    }
    
}

// MARK: - Subviews

private extension SideMenu {
    struct HeaderView: View {
        var body: some View {
            HStack {
                Text("What's your mood?")
                    .font(.custom("SFProRounded-Bold", size: 23))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.top, 20)
            }
        }
    }
    
    struct MenuItemView: View {
        let mood: MenuItem
        let isSelected: Bool
        
        var body: some View {
            ZStack(alignment: .leading) {
                HStack {
                    MoodIconView(mood: mood, isSelected: isSelected)
                    
                    Text(mood.text)
                        .font(.custom("SFProRounded-Regular", size: 16))
                        .foregroundColor(isSelected ? .imdbYellow : .white)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 8)
                        .cornerRadius(8)
                }
                .scaleEffect(isSelected ? 1.1 : 1)
                .padding(.init(top: 10, leading: 30, bottom: 10, trailing: 10))
                .frame(width: .infinity, alignment: .leading)
                .offset(x: isSelected ? 15 : 0)
                
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.iconOrange, lineWidth: 2)
                    .frame(width: 270, height: 60)
                    .background(isSelected ? .imdbYellow.opacity(0.1) : Color.clear)
                    .shadow(color: .iconOrange.opacity(0.5), radius: isSelected ? 5 : 0, x: 0, y: 0)
                    .opacity(isSelected ? 1 : 0)
                    .padding(.leading, 10)
            }
        }
    }
    
    struct MoodIconView: View {
        let mood: MenuItem
        let isSelected: Bool
        
        var body: some View {
            ZStack {
                Circle()
                    .stroke(Color.iconOrange, lineWidth: isSelected ? 2 : 1)
                    .frame(width: 25, height: 25)
                    .opacity(isSelected ? 0 : 1)
                Text(mood.icon)
                    .font(.custom("SFProRounded-Bold", size: 25))
                    .foregroundColor(.iconOrange)
                    .opacity(isSelected ? 1 : 0)
            }
        }
    }
    
    func CloseButton() -> some View {
        Button(action: {
            withAnimation(.easeIn) {
                vm.isSideMenuOpen.toggle()

            }
        }) {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.black)
                .background(.imdbYellow)
                .cornerRadius(20)
                .shadow(radius: 4)
                .padding()
        }
       
    }
}

// MARK: - Style

private extension View {
    func menuStyle() -> some View {
        self
            .frame(maxWidth: 288, maxHeight: 700)
            .background(.bgBlack.opacity(0.5))
            .cornerRadius(16)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Model

struct MenuItem: Identifiable, Equatable {
    var id = UUID()
    var text: String
    var icon: String
    var menu: SelectedMenu
}

var menuItems = [
    MenuItem(text: "Need to see Action", icon: "🚀", menu: .action),
    MenuItem(text: "LOVE LOVE LOVE 777", icon: "🧡", menu: .love),
    MenuItem(text: "Wanna Cry", icon: "😢", menu: .cry),
    MenuItem(text: "Something Real", icon: "💪", menu: .biography),
    MenuItem(text: "Anything can't scare me", icon: "😬", menu: .horror)
]

enum SelectedMenu: String {
    case action
    case love
    case cry
    case biography
    case horror
}

// MARK: - Preview

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu(vm: MovieViewModel())
    }
}
