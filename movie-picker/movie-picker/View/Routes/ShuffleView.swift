import SwiftUI

struct ShuffleView: View {
    var body: some View {
        MovieListView(viewModel: MovieViewModel())
    }
}

#Preview {
    ShuffleView()
}
