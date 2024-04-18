struct MovieResponse: Decodable, Encodable {
    let page: Int
    let results: [MovieModel]
    let totalPages: Int
    let totalResults: Int
    
    private enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieModel: Identifiable, Decodable, Encodable {
    var id: Int
    var title: String
    var overview: String
    var posterPath: String?
    var backdropPath: String?
    var releaseDate: String
    var voteAverage: Double
    var voteCount: Int
    var popularity: Double
    var adult: Bool
    var genreIds: [Int]
    var originalLanguage: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity
        case adult
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
    }
}
