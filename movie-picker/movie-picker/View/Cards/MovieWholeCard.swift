//
//  MovieWholeCard.swift
//  movie-picker
//
//  Created by Harun Mert Gokcegoz on 17/04/2024.
//

import SwiftUI

struct MovieWholeCard: View {
    //MARK: Variables
    let movie: MovieModel
    @State private var backDegree = 0.0
    @State private var frontDegree = -90.0
    @State private var isFlipped = false
    
    @State private var cardHeight: CGFloat = 400
    @State private var cardWidth: CGFloat = 250
    @State private var offset = CGSize.zero
    @State private var rotation: Double = 0.0
    
    private let durationAndDelay : CGFloat = 0.3
    
    //MARK: View Body
    var body: some View {
        ZStack {
            MovieCardFrontView(movie: movie, cardHeight: cardHeight, cardWidth: cardWidth, degree: $backDegree)
            MovieCardBackView(movie: movie, cardHeight: cardHeight * 1.1, cardWidth: cardWidth * 1.2,  degree: $frontDegree)
        }
        .offset(x: offset.width, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(dragGesture)
        .onTapGesture {
            flipCard ()
        }
        .animation(.spring)
    }
    
    //MARK: Utils Functions
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
            }
            .onEnded { _ in
                withAnimation(.easeOut(duration: 0.2)) {
                    swipeCard(width: offset.width)
                }
            }
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
}

#Preview {
    MovieWholeCard( movie: MovieModel(
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
        originalLanguage: "en")
    )}
