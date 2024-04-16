import SwiftUI

struct MovieListView: View {
    @ObservedObject var viewModel: MovieViewModel
    
    @State private var isLoading = false
    @State private var shufflePressed = false
    
    @State var backDegree = 0.0
     @State var frontDegree = -90.0
     @State var isFlipped = false

     let width : CGFloat = 200
     let height : CGFloat = 250
     let durationAndDelay : CGFloat = 0.3
    
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
                    await Task.sleep(4 * 1_000_000_000)
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
            MovieCardFrontView(movie: movie)
        }
    }
    
    private func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
}



// Preview code
struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(viewModel: MovieViewModel())
    }
}
