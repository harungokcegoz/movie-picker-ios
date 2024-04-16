import SwiftUI

struct MovieListView: View {
    @ObservedObject var viewModel: MovieViewModel
    
    @State private var isLoading = false
    @State private var shufflePressed = false
    
    var body: some View {
        
        ZStack {
            VStack {
                Loading()
            }
            .opacity(isLoading ? 1 : 0)
            
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
                    await Task.sleep(2 * 1_000_000_000)
                    isLoading = false
                }
            }
            .opacity(isLoading ? 0 : 1)
        }
    }
    
    private var button: some View {
       Button {
           shufflePressed = true
       } label: {
           HStack {
               Image(systemName: "shuffle")
               Text("Reshuffle")
                   .font(Font.custom("SFProRounded-Medium", size: 16))
           }
           .foregroundColor(.black)
           .padding()
           .padding(.horizontal, 5)
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
