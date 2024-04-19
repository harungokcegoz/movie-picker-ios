import SwiftUI

struct ScrollCardStack: View {
    let categoryName: String
    let cardStackType: CardStackType
    
    private let trailerCardHeight: CGFloat = 120
    private let trailerCardWidth: CGFloat = 180
    private let cardHeight: CGFloat = 180
    private let cardWidth: CGFloat = 120
    
    @ObservedObject var viewModel: MovieViewModel
    
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
            HStack(alignment: .top, spacing: 16) {
                ForEach(viewModel.movies) { movie in
                    VStack(spacing: 8) {
                        switch cardStackType {
                        case .trailer:
                            ScrollCard(movie: movie, cardType: .trailer, cardHeight: trailerCardHeight, cardWidth: trailerCardWidth)
                        case .movie:
                            ScrollCard(movie: movie, cardType: .movie, cardHeight: cardHeight, cardWidth: cardWidth)
                        }
                        Spacer()
                    }
                    .frame(width: cardWidth, height: cardHeight * 1.7)
                    .sheet(item: $viewModel.sheetMovie, onDismiss: nil){
                        movie in
                        ScrollCardDetailView(movie: movie, vm: viewModel)
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

#Preview {
    ScrollCardStack(categoryName: "Top Movies", cardStackType: .trailer, viewModel: MovieViewModel())
}


