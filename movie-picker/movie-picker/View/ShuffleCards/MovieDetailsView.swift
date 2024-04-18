import SwiftUI

struct MovieDetailsView: View {
    let movie: MovieModel
    
    var body: some View {
        
        VStack {
            Text(movie.title)
            Text(movie.overview)
        }
        .padding()
    }
}
