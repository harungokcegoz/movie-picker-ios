//
//  HouseView.swift
//  movie-picker
//
//  Created by Harun Mert Gokcegoz on 10/04/2024.
//

import SwiftUI

struct HouseView: View {
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack {
                ScrollCardStack(categoryName: "Coming Soon", cardStackType: .trailer, viewModel: MovieViewModel())
            }
            .padding(.top, 10)
            HStack {
                ScrollCardStack(categoryName: "Top Movies", cardStackType: .movie, viewModel: MovieViewModel())
            }
            HStack {
                ScrollCardStack(categoryName: "Recently Awarded", cardStackType: .movie, viewModel: MovieViewModel())
            }
            HStack {
                ScrollCardStack(categoryName: "IMDb Bests", cardStackType: .movie, viewModel: MovieViewModel())
            }
        }
    }
       
}

#Preview {
    HouseView()
}
