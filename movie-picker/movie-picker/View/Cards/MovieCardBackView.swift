import SwiftUI

struct MovieCardBackView: View {
    let movie: MovieModel
    
    @State private var cardHeight: CGFloat = 400
    @State private var cardWidth: CGFloat = 250
    
    var body: some View {
        VStack {
            title.padding()
            overview.padding(.leading)
            releaseAndRating.padding(.top)
            details
            whereToWatch
        }
        .padding(20)
        .frame(width: cardWidth, height: cardHeight)
        .background(.black.opacity(0.8))
        .cornerRadius(20)
    }

    //MARK: Props
    private var title: some View {
        HStack {
            Spacer()
            Text(movie.title)
                .foregroundColor(.white)
                .font(Font.custom("SFProRounded-Bold", size: 16))
            Spacer()
        }
    }
    
    private var overview: some View {
        HStack{
            Text(movie.overview)
                .foregroundColor(.white)
                .font(Font.custom("SFProRounded-Light", size: 14))
                Spacer()
        }
    }
    
    private var releaseAndRating: some View {
        HStack(){
            Text("Release year:")
                .foregroundColor(.white)
                .font(Font.custom("SFProRounded-Bold", size: 13))
            Text(date)
                .foregroundColor(.white)
                .font(Font.custom("SFProRounded-Light", size: 12))
                Spacer()
            Text("Rating:")
                .foregroundColor(.white)
                .font(Font.custom("SFProRounded-Bold", size: 13))
            Text(String(format: "%.1f", movie.voteAverage))
                .foregroundColor(.white)
                .font(Font.custom("SFProRounded-Light", size: 12))
                Spacer()
        }
    }
    
    private var details: some View {
        HStack(){
            Text("Language:")
                .foregroundColor(.white)
                .font(Font.custom("SFProRounded-Bold", size: 13))
            Text(movie.originalLanguage.uppercased())
                .foregroundColor(.white)
                .font(Font.custom("SFProRounded-Light", size: 12))
                Spacer()
            Text("Genre:")
                .foregroundColor(.white)
                .font(Font.custom("SFProRounded-Bold", size: 13))

            ForEach(movie.genreIds, id: \.self) { genre in
                Text("\(genre)")
                    .foregroundColor(.white)
                    .font(Font.custom("SFProRounded-Light", size: 12))
            }
        }
    }
    
    private var whereToWatch: some View {
        VStack {
            Text("Where to watch")
                .foregroundColor(.white)
                .font(Font.custom("SFProRounded-Bold", size: 13))
                .padding(5)
            HStack {
                Image("netflix-icon")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .cornerRadius(20)
                Image("prime-video-icon")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .cornerRadius(20)
                Image("hulu-icon")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .cornerRadius(20)
            }
        }
    }
    
    
    //MARK: Utils functions
    private var date: String  {
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

struct MovieCardBackView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardBackView(
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
            )
        )
    }
}
