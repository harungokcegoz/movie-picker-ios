import SwiftUI

struct ScrollCard: View {
    let movie: MovieModel
    let cardHeight: CGFloat
    let cardWidth: CGFloat

    
    var body: some View {
        VStack {
            posterImage
            HStack {
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
            }
            .padding(.top, 2)
            .padding(.horizontal, 5)
            Text(movie.title)
                .font(.custom("SFProRounded-Regular", size: 15))
                .foregroundColor(.white)
            Spacer()
        }

    }
    
    private var posterImage: some View {
        AsyncImage(url: URL(string: movie.posterPath ?? "film")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: cardWidth, height: cardHeight)
        .cornerRadius(10)
        .shadow(color: .imdbYellow.opacity(0.1) ,radius: 5, x: 0, y: 2)
        .padding(.top)
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
    
}

#Preview {
    ScrollCard(
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
        ), cardHeight: 400, cardWidth: 250
    )
}
    