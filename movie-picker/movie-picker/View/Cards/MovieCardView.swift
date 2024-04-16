import SwiftUI

struct MovieCardView: View {
    let movie: MovieModel
    
    @State private var offset = CGSize.zero
    @State private var notification: String?
    @State private var notificationColor: Color?
    @State private var isNotificationVisible: Bool? = false
    @State private var rotation: Double = 0.0
    @State private var cardHeight: CGFloat = 400
    @State private var cardWidth: CGFloat = 250
    
    var body: some View {
        VStack {
//            notificationView
            cardContent
        }
        .padding(.top, 40)
    }
    
    private var cardContent: some View {
        ZStack {
            posterImage
//            rotatingGradient
        }
        .offset(x: offset.width, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(dragGesture)
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
    
//    private var rotatingGradient: some View {
//        RoundedRectangle(cornerRadius: 20, style: .continuous)
//            .frame(width: cardWidth - 150, height: cardHeight + 150)
//            .foregroundStyle(
//                LinearGradient(
//                    gradient: Gradient(colors: [
//                        Color("icon-orange").opacity(0.1),
//                        Color("icon-orange"),
//                        Color("icon-orange"),
//                        Color("icon-orange").opacity(0.1)
//                    ]),
//                    startPoint: .top,
//                    endPoint: .bottom
//                )
//            )
//            .rotationEffect(.degrees(rotation))
//            .mask(
//                RoundedRectangle(cornerRadius: 20, style: .continuous)
//                    .stroke(lineWidth: 3)
//                    .frame(width: cardWidth + 1, height: cardHeight + 1)
//            )
//    }
    
    private var dragGesture: some Gesture {
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
    }
    
    private var notificationView: some View {
        ZStack {
            Text(notification ?? "")
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .opacity(isNotificationVisible ?? false ? 1 : 0)
    }
    
    private func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
        case 150...500:
            offset = CGSize(width: 500, height: 0)
        default:
            offset = .zero
        }
    }
    
    private func updateNotification(width: CGFloat) {
        clearNotifications()
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
    
//    private func startRotating() {
//        let timer = Timer.scheduledTimer(withTimeInterval: 0.04, repeats: true) { _ in
//            withAnimation(.linear(duration: 0.04)) {
//                rotation += 3
//            }
//        }
//        RunLoop.current.add(timer, forMode: .common)
//    }
    
    private func clearNotifications() {
        notification = nil
        notificationColor = nil
        isNotificationVisible = false
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
