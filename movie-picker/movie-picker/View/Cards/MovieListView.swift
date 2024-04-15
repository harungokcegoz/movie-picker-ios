import SwiftUI

struct MovieListView: View {
    @ObservedObject var viewModel: MovieViewModel
    
    @State private var isLoading = false
    @State private var shufflePressed = false
    
    var body: some View {
        VStack {
            ZStack {
               movieStack
            }
            button
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
    
    private var button: some View {
       Button {
           shufflePressed = true
       } label: {
           HStack {
               Image(systemName: "shuffle")
               Text("Reshuffle")
           }
           .foregroundColor(.black)
           .padding()
           .padding(.horizontal, 15)
           .background(Color("imdb-yellow"))
           .cornerRadius(10)
       }
    }
    
    private var movieStack: some View {
        ForEach(viewModel.movies) { movie in
            MovieCardView(movie: movie)
        }
    }
}



// Preview code
struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(viewModel: MovieViewModel())
    }
}
