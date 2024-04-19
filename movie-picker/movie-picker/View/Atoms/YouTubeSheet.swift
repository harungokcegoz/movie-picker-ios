import SwiftUI
import YouTubePlayerKit

struct YouTubeSheet: View {
    let videoURL: String
    let vm: MovieViewModel
    let movie: MovieModel
    
    var body: some View {
        ScrollView {
            VStack {
                let player = YouTubePlayer(stringLiteral: videoURL)
                YouTubePlayerView(player)
                    .scaledToFit()
                
                HStack {
                    Text("Official Trailer - \(movie.title)")
                        .font(Font.custom("SFProRounded-Bold", size: 20))
                        .foregroundColor(.iconOrange)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                        .padding(.leading)
                    Spacer()
                }
                Divider()
                Text("Release Date: 12 July 2024")
                    .font(Font.custom("SFProRounded-Bold", size: 15))
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.leading)
                Divider()
                Text(movie.overview)
                    .font(Font.custom("SFProRounded-Light", size: 15))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    .padding(.leading)
            }
       
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100)
        .ignoresSafeArea()
        .background(.bgBlack)
        .overlay(backButton, alignment: .topTrailing)
    }
    
}

extension YouTubeSheet {
    private var backButton: some View {
        Button {
            vm.sheetMovie = nil
        } label: {
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

#Preview {
    YouTubeSheet(videoURL: "https://www.youtube.com/watch?v=1ZdlAg3j8nI" , vm: MovieViewModel(),     movie: MovieModel(
        id: 1,
        title: "Godzilla vs. Kong",
        overview: "In a time when monsters walk the Earth, humanity’s fight for its future sets Godzilla and Kong on a collision course that will see the two most powerful forces of nature on the planet collide in a spectacular battle for the ages.",
        posterPath: "https://image.tmdb.org/t/p/original/pgqgaUx1cJb5oZQQ5v0tNARCeBp.jpg",
        releaseDate: "2023-10-06",
        voteAverage: 8.3,
        voteCount: 4719,
        popularity: 5389.258,
        adult: false,
        genreIds: [1, 2, 3],
        originalLanguage: "en"
    ))
}
