//
//  HouseView.swift
//  movie-picker
//
//  Created by Harun Mert Gokcegoz on 10/04/2024.
//

import SwiftUI

struct HouseView: View {
    
    var body: some View {
        VStack {
            HStack {
                ScrollCardStack(categoryName: "Top Movies", viewModel: MovieViewModel(), degree: 0.0, cardHeight: 180, cardWidth: 120)
            }
        }
    }
}

#Preview {
    HouseView()
}
