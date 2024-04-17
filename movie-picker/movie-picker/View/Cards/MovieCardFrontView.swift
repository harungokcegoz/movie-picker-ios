import SwiftUI

struct MovieCardFrontView: View {
    let movie: MovieModel
    let cardHeight: CGFloat
    let cardWidth: CGFloat
    
    @Binding var degree : Double
    
    var body: some View {
        VStack {
//            notificationView
            cardContent
        }
        .padding(.top, 40)
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
    
    private var cardContent: some View {
        ZStack {
            posterImage
        }
        .padding(.vertical, 20)

    }
    
    private var posterImage: some View {
        AsyncImage(url: URL(string: movie.posterPath ?? "film")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: cardWidth, height: cardHeight)
        .cornerRadius(20)
    }
    
}

struct MovieCardFrontView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardFrontView(
            movie: MovieModel(
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
            ), cardHeight: 400, cardWidth: 250, degree: .constant(0)
        )
    }
}
