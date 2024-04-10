import SwiftUI

struct MovieListView: View {
    @ObservedObject var viewModel: MovieViewModel
    
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(viewModel.movies) { movie in
                    MovieCardView(movie: movie)
                }
            }
        }
        .onAppear {
            isLoading = true
            Task {
                await viewModel.fetchMovies()
                isLoading = false
            }
        }
        .disabled(isLoading)
    }
}

#Preview {
    MovieListView(viewModel: MovieViewModel())
}
