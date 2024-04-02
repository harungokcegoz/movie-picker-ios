import SwiftUI

struct MovieListView: View {
    @ObservedObject var viewModel: MovieViewModel
    @State private var isLoading = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(viewModel.movies) { movie in
                        NavigationLink(destination: MovieDetailsView(movie: movie)) {
                            MovieCardView(movie: movie)
                                .frame(width: geometry.size.width - 40, height: geometry.size.height)
                        }
                    }
                }
                .padding(.horizontal, 20)
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
