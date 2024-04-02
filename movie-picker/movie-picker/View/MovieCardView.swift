import SwiftUI

struct MovieCardView: View {
    let movie: MovieModel
    
    var body: some View {
        VStack {
            Text(movie.title)
            // Display movie poster or other details
            Image(systemName: "film")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 200)
            // Add other movie details as needed
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
