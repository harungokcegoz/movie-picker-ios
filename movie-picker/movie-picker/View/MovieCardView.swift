import SwiftUI

struct MovieCardView: View {
    let movie: MovieModel
    @State private var offset = CGSize.zero
    @State private var notification: String?
    @State private var notificationColor: Color?
    
    var body: some View {
        ZStack {
            VStack {
                AsyncImage(url: URL(string: movie.posterPath ?? "film")) { image in
                    image.resizable()
                }
            placeholder: {
                ProgressView()
            }
            }
            .frame(width: 300, height: 500)
            .cornerRadius(20)
            .shadow(radius: 5)
            
            if let notification = notification {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 300, height: 500, alignment: .leading)
                    .foregroundColor(notificationColor ?? .clear)
                    .opacity(0.2)
                Text(notification)
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
        .offset(x: offset.width, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    withAnimation(.easeOut(duration: 0.2)) {
                        updateNotification(width: offset.width)
                    }
                }
                .onEnded { _ in
                    withAnimation(.easeOut(duration: 0.2)) {
                        swipeCard(width: offset.width)
                        updateNotification(width: offset.width)
                    }
                }
        )
    }
    
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
        case 150...500:
            offset = CGSize(width: 500, height: 0)
        default:
            offset = .zero
        }
    }
    
    func updateNotification(width: CGFloat) {
        switch width {
        case -500...(-100):
            notification = "Remove the suggestion"
            notificationColor = .red
        case 100...500:
            notification = "Add to favorites"
            notificationColor = .green
        default:
            notification = nil
            notificationColor = nil
        }
    }
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView(
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
