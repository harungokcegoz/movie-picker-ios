// Mock Movie data
//adult:false
//backdrop_path:"https://image.tmdb.org/t/p/original/oFS0DgInCdvYRwaPkl3BLpmIuq5.jpg"
//genre_ids:
//id:1013240
//original_language:"id"
//original_title:"24 Jam Bersama Gaspar"
//overview:"With only 24 hours left to live, a private investigator follows a trail of confounding clues to uncover the disappearance of his childhood friend."
//popularity:658.56
//poster_path:"https://image.tmdb.org/t/p/original/8jJKM0ZR3GQo6E3CUkMKKVa4S8B.jpg"
//release_date:"2023-10-06"
//title:"24 Hours with Gaspar"
//video:false
//vote_average:6.611
//vote_count:27

struct MovieResponse: Decodable {
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

struct MovieModel: Identifiable, Decodable {
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
