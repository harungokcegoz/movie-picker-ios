import SwiftUI

struct ScrollCardDetailView: View {
    let movie: MovieModel
    let vm: MovieViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    overviewSection
                    VStack(alignment: .center, spacing: 8){
                        yearRatingLanguage
                        genre
                        whereToWatch
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.bgBlack)
        .overlay(backButton, alignment: .topLeading)
    }
}

extension ScrollCardDetailView {
    private var imageSection: some View {
        TabView {
            posterImage
            posterImage
        }
        .frame(height: 550)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var posterImage: some View {
        AsyncImage(url: URL(string: movie.posterPath ?? "film")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: UIScreen.main.bounds.width, height: 550)
        .clipped()
        .cornerRadius(10)
        .shadow(color: .imdbYellow.opacity(0.1) ,radius: 5, x: 0, y: 2)
        .padding(.top)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(movie.title)
                .font(.custom("SFProRounded-Bold", size: 27))
                .foregroundColor(.white)
                .padding(.top, 5)
                .padding(.horizontal, 10)
        }
    }
    
    private var overviewSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(movie.overview)
                .font(.custom("SFProRounded-Light", size: 18))
                .foregroundColor(.white)
                .padding(.top, 5)
                .padding(.horizontal, 10)
        }
    }
    
    private var yearRatingLanguage: some View {
        HStack{
            Spacer()
            Image(systemName: "calendar")
                .foregroundColor(.iconOrange)
            Text(date)
                .foregroundColor(.white)
                .font(Font.custom("SFProRounded-Light", size: 17))
            Image(systemName: "star")
                .foregroundColor(.iconOrange)
            Text(String(format: "%.1f", movie.voteAverage))
                .foregroundColor(.white)
                .font(Font.custom("SFProRounded-Light", size: 17))
            Image(systemName: "globe")
                .foregroundColor(.iconOrange)
            Text(movie.originalLanguage.uppercased())
                .foregroundColor(.white)
                .font(Font.custom("SFProRounded-Light", size: 17))
            Spacer()
        }
        .padding(.vertical, 20)
    }
    
    private var genre: some View {
        HStack(){
            //            ForEach(movie.genreIds, id: \.self) { genre in
            //                VStack {
            //                    Text("\(genre)")
            //                        .foregroundColor(.white)
            //                    .font(Font.custom("SFProRounded-Light", size: 12))
            //                }
            //            }
            Text("Action")
                .foregroundColor(.white)
                .font(Font.custom("SFProRounded-Light", size: 17))
                .padding(8)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.iconOrange, lineWidth: 1)
                })
            Text("Romantic")
                .foregroundColor(.white)
                .font(Font.custom("SFProRounded-Light", size: 17))
                .padding(8)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.iconOrange, lineWidth: 1)
                })
            Text("Drama")
                .foregroundColor(.white)
                .font(Font.custom("SFProRounded-Light", size: 17))
                .padding(8)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.iconOrange, lineWidth: 1)
                })
        }
        .padding(.vertical)
    }
    
    private var whereToWatch: some View {
        VStack {
            Text("Where to watch")
                .foregroundColor(.iconOrange)
                .font(Font.custom("SFProRounded-Bold", size: 20))
                .padding(5)
            HStack {
                Image("netflix-icon")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(15)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.gray, lineWidth: 1)
                    })
                Image("prime-video-icon")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(15)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.gray, lineWidth: 1)
                    })
                Image("hulu-icon")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(15)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.gray, lineWidth: 1)
                    })
            }
            .padding(5)
        }
        .padding(.vertical)
    }
    
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
    
    private var backButton: some View {
        Button {
            vm.sheetMovie = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.iconOrange)
                .background(.bgBlack)
                .cornerRadius(20)
                .shadow(radius: 4)
                .padding()
        }
    }
}


#Preview {
    ScrollCardDetailView(
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
        ), vm: MovieViewModel()
    )
}
