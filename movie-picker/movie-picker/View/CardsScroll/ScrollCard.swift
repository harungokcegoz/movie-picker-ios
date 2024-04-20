import SwiftUI
import YouTubePlayerKit

struct ScrollCard: View {
    let movie: MovieModel
    let cardType: CardType
    let cardHeight: CGFloat
    let cardWidth: CGFloat
    let isRankingNeeded: Bool
    let rankNumber: Int
    
    var body: some View {
        switch cardType {
        case .trailer:
           trailerCard
        case .movie:
            movieCard
        }
    }
    
}

extension ScrollCard {
    enum CardType {
        case trailer
        case movie
    }
    
    private var trailerCard: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                posterImage(movie: movie, width: cardWidth, height: cardHeight)
                Image(systemName: "play.rectangle.fill")
                    .resizable()
                    .frame(width: 30, height: 20)
                    .foregroundColor(.red)
                    .background(.white)
                    .cornerRadius(5)
                    .padding(.top, 10)
                    .zIndex(1)
            }
            date
            title
        }
        .frame(width: cardWidth, height: cardHeight * 1.5)
    }
    
    private var movieCard: some View {
        ZStack(alignment: .bottomLeading) {
            VStack {
                posterImage(movie: movie, width: cardWidth, height: cardHeight)
                VStack {
                    dateAndRate
                    title
                }
                Spacer()
            }
            HStack {
                ZStack {
                    Text(String(rankNumber))
                        .font(.custom("Impact", size: 80))
                        .foregroundColor(.imdbYellow)
                        .padding(.bottom, 50)
                        .zIndex(1)
                    Text(String(rankNumber))
                        .font(.custom("Impact", size: 80))
                        .foregroundColor(.red.opacity(0.8))
                        .offset( x: 2, y: -1)
                        .padding(.bottom, 50)
            
                }
                .opacity(isRankingNeeded ? 1 : 0)
                Spacer()
            }
        }
        .frame(width: isRankingNeeded ? cardWidth + 40 : cardWidth, height: cardHeight * 1.4)
    }
    
    private var date: some View {
        HStack {
            Image(systemName: "calendar.badge.clock")
                .resizable()
                .frame(width: 20, height: 18)
                .foregroundColor(.iconOrange)
            Text(movie.releaseDate)
                .font(.custom("SFProRounded-Regular", size: 13))
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.leading, 8)
        .padding(.top, 5)
    }
    
    private var dateAndRate: some View {
        HStack {
            Spacer()
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundColor(.iconOrange)
            Text(String(format: "%.1f", movie.voteAverage))
                .font(.custom("SFProRounded-Regular", size: 13))
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "calendar")
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundColor(.iconOrange)
            Text(getYear(movie: movie))
                .font(.custom("SFProRounded-Regular", size: 13))
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.top, 10)
        .padding(.horizontal, 5)
    }
    
    private var title: some View {
        Text(movie.title)
            .font(.custom("SFProRounded-Regular", size: 15))
            .foregroundColor(.white)
    }
    
    private func getYear(movie: MovieModel) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: movie.releaseDate) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return "\(year)"
        } else {
            return "N/A"
        }
    }
    
    private func posterImage(movie: MovieModel, width: CGFloat, height: CGFloat) -> some View {
        AsyncImage(url: URL(string: movie.posterPath ?? "film")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: width, height: height)
        .cornerRadius(10)
        .shadow(color: .imdbYellow.opacity(0.1) ,radius: 5, x: 0, y: 2)
    }

}


//#Preview {
//    ScrollCard(
//        movie: MovieModel(
//            id: 1,
//            title: "Godzilla vs. Kong",
//            overview: "In a time when monsters walk the Earth, humanity’s fight for its future sets Godzilla and Kong on a collision course that will see the two most powerful forces of nature on the planet collide in a spectacular battle for the ages.",
//            posterPath: "https://image.tmdb.org/t/p/original/pgqgaUx1cJb5oZQQ5v0tNARCeBp.jpg",
//            releaseDate: "2023-10-06",
//            voteAverage: 8.3,
//            voteCount: 4719,
//            popularity: 5389.258,
//            adult: false,
//            genreIds: [1, 2, 3],
//            originalLanguage: "en"
//        ), cardType: .trailer, cardHeight: 120, cardWidth: 200
//    )
//}

