import SwiftUI

struct MovieCardView: View {
    let movie: MovieModel
    @State private var offset = CGSize.zero
    @State private var notification: String?
    @State private var notificationColor: Color?
    @State private var isNotificationVisible: Bool? = false
    @State private var rotation: CGFloat = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    AsyncImage(url: URL(string: movie.posterPath ?? "film")) { image in
                        image.resizable()
                    }
                placeholder: {
                    ProgressView()
                }
                }
                .frame(width: 250, height: 400)
                .cornerRadius(20)
                .shadow(radius: 5)
                
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .frame(width: 125, height: 750)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.clear, Color("imdb-yellow")]), startPoint: .top, endPoint: .bottom))
                    .rotationEffect(.degrees(rotation))
                    .mask(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(lineWidth: 7)
                            .frame(width: 255, height: 395)
                    )
                
                //                if let notification = notification {
                //                    RoundedRectangle(cornerRadius: 20)
                //                        .frame(width: 300, height: 500, alignment: .leading)
                //                        .foregroundColor(notificationColor ?? .clear)
                //                        .opacity(0.2)
                //                    Text(notification)
                //                        .font(.title)
                //                        .foregroundColor(.white)
                //                }
            }
            .onAppear{
                withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
            .offset(x: offset.width, y: offset.height * 0.4)
            .rotationEffect(.degrees(Double(offset.width / 40)))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                        updateNotification(width: offset.width)
                    }
                    .onEnded { _ in
                        withAnimation(.easeOut(duration: 0.2)) {
                            swipeCard(width: offset.width)
                            updateNotification(width: offset.width)
                        }
                    }
            )
            .padding()
            .animation(.spring)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 200, height: 50)
                    .foregroundColor(.gray.opacity(0.2))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                Text(notification ?? "")
                    .font(.subheadline)
            }
            .opacity(isNotificationVisible ?? false ? 1 : 0)
            
            
        }
        
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
        case -500...(-80):
            notification = "Skipped!"
            notificationColor = .red
            isNotificationVisible = true
        case 80...500:
            notification = "Added to favorites!"
            notificationColor = .green
            isNotificationVisible = true
        default:
            notification = nil
            notificationColor = nil
            isNotificationVisible = false
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
