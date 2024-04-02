//
//  movie_pickerApp.swift
//  movie-picker
//
//  Created by Harun Mert Gokcegoz on 02/04/2024.
//

import SwiftUI

@main
struct movie_pickerApp: App {
    var body: some Scene {
        WindowGroup {
            MovieListView(viewModel: MovieViewModel())
        }
    }
}

#Preview {
    MovieListView(viewModel: MovieViewModel())
}
