import SwiftUI

@main
struct movie_pickerApp: App {
    var body: some Scene {
        WindowGroup {
            MovieListView(viewModel: MovieViewModel())
        }
    }
}

#Preview {
    MovieListView(viewModel: MovieViewModel())
}
