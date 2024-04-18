import SwiftUI

struct ScrollCardStack: View {
    let categoryName: String
    @ObservedObject var viewModel: MovieViewModel
    
    @State var degree: Double
    var cardHeight: CGFloat
    var cardWidth: CGFloat

    var body: some View {
        VStack {
            HStack {
                Text(categoryName)
                    .font(Font.custom("SFProRounded-Bold", size: 20))
                    .foregroundColor(.iconOrange)
                Spacer()
            }
            .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(viewModel.movies) { movie in
                        VStack(spacing: 8) {
                            ScrollCard(movie: movie, cardHeight: cardHeight, cardWidth: cardWidth)
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
        .onAppear {
            Task {
                await viewModel.fetchMovies()
            }
        }
    }
}

#Preview {
    ScrollCardStack(categoryName: "Top Movies", viewModel: MovieViewModel(), degree: 0.0, cardHeight: 200, cardWidth: 120)
}


