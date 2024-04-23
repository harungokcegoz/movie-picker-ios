import SwiftUI

struct Header: View {
    @ObservedObject var vm: MovieViewModel
    
    var body: some View {
        VStack {
            HStack {
                SideMenuButton()
                    .opacity(vm.isSideMenuOpen ? 0 : 1)
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 50)
                    .padding(.top, 10)
                    .padding(.leading, 40)
                Spacer()
            }
            Divider()
                .frame(height: 1)
                .background(.gray.opacity(0.3))
        }
    }
}

extension Header {
    @ViewBuilder
    func SideMenuButton() -> some View {
        Button {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)){
                vm.isSideMenuOpen.toggle()
            }
        } label: {
            Image(systemName: "line.3.horizontal")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .padding(.leading, 30)
                .padding(.top, 10)

        }
        .disabled(vm.isSideMenuOpen)
    }
}
