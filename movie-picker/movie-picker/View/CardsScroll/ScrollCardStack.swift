import SwiftUI

struct ScrollCardStack: View {
    let categoryName: String
    let cardStackType: CardStackType
    let isRankingNeeded: Bool
    
    private let cardHeight: CGFloat = 210
    private let cardWidth: CGFloat = 150
    private var rankingNumberCount: Int = 0
    
    @ObservedObject var viewModel: MovieViewModel
    
    init(categoryName: String, cardStackType: CardStackType, isRankingNeeded: Bool, viewModel: MovieViewModel) {
        self.categoryName = categoryName
        self.cardStackType = cardStackType
        self.isRankingNeeded = isRankingNeeded
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            categorySpan
            cardScroll
        }
        .onAppear {
            Task {
                await viewModel.fetchMovies()
            }
        }
    }
}

extension ScrollCardStack {
    enum CardStackType {
        case trailer
        case movie
    }
    
    private var categorySpan: some View {
        HStack {
            Text(categoryName)
                .font(Font.custom("SFProRounded-Bold", size: 20))
                .foregroundColor(.iconOrange)
            Spacer()
        }
        .padding(.leading)
    }
    
    private var cardScroll: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 10) {
                ForEach(Array(viewModel.movies.enumerated()), id: \.offset) { index, movie in
                    VStack {
                        switch cardStackType {
                        case .trailer:
                            ScrollCard(movie: movie, cardType: .trailer, cardHeight: cardHeight, cardWidth: cardWidth, isRankingNeeded: isRankingNeeded, rankNumber: index + 1)
                        case .movie:
                            ScrollCard(movie: movie, cardType: .movie, cardHeight: cardHeight, cardWidth: cardWidth, isRankingNeeded: isRankingNeeded, rankNumber: index + 1)
                        }
                        Spacer()
                    }
                    .sheet(item: $viewModel.sheetMovie, onDismiss: nil) { movie in
                        if cardStackType == .trailer {
                            YouTubeSheet(videoURL: "https://www.youtube.com/watch?v=1ZdlAg3j8nI", vm: viewModel, movie: movie)
                        } else {
                            ScrollCardDetailView(movie: movie, vm: viewModel)
                        }
                    }
                    .onTapGesture {
                        viewModel.sheetMovie = movie
                    }
                }
            }
            .padding(.horizontal)
        }
    }

}

//#Preview {
//    ScrollCardStack(categoryName: "Top Movies", cardStackType: .trailer, viewModel: MovieViewModel())
//}


