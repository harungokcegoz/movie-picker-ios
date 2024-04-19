import SwiftUI

struct HouseView: View {
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack {
                ScrollCardStack(categoryName: "Top Movies", cardStackType: .movie, isRankingNeeded: true, viewModel: MovieViewModel())
            }
            .padding(.top, 10)
            HStack {
                ScrollCardStack(categoryName: "Coming Soon Trailers", cardStackType: .trailer, isRankingNeeded: false, viewModel: MovieViewModel())
            }
            HStack {
                ScrollCardStack(categoryName: "Recently Awarded", cardStackType: .movie, isRankingNeeded: false, viewModel: MovieViewModel())
            }
            HStack {
                ScrollCardStack(categoryName: "IMDb Bests", cardStackType: .movie, isRankingNeeded: true, viewModel: MovieViewModel())
            }
        }
        .padding(.bottom, 85)
    }
}

//#Preview {
//    HouseView()
//}
