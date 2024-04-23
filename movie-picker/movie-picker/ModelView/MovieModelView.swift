import Foundation

private enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}

class WebService {
    func downloadData(url: URL, headers: [String: String]) async throws -> [MovieModel]? {
        do {
//            var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//            request.allHTTPHeaderFields = headers
//
//            let (data, response) = try await URLSession.shared.data(for: request)
//            guard let httpResponse = response as? HTTPURLResponse else {
//                throw NetworkError.badResponse
//            }
//
//            guard (200..<300).contains(httpResponse.statusCode) else {
//                throw NetworkError.badStatus
//            }
            // Mock response
//            let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: mockResponse)
            
            let decodedResponse = Bundle.main.decode(type: MovieResponse.self, from: "MockData.json")
            return decodedResponse.results
        } catch {
            print("Error: \(error)")
            throw error
        }
    }
}

extension Bundle {
    func decode<T: Codable>(type: T.Type, from file: String) -> T {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("No file named: \(file) in Bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load")
        }
        
        let decoder = JSONDecoder()
        
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundel, missing file '\(key.stringValue)' - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Type mismatch context \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(type) - context: \(context.debugDescription)")
        }  catch DecodingError.dataCorrupted(_) {
            fatalError("Wrong JSON")
        } catch {
            fatalError("Filed to decode \(file) from bundle")
        }
    }
}

class MovieViewModel: ObservableObject {
    @Published var movies: [MovieModel] = []
    @Published var sheetMovie: MovieModel? = nil
    @Published var isSideMenuOpen: Bool = false
    
    let headers = [
        "X-RapidAPI-Key": "2285790515msh8e72398585d3ec8p1858ddjsnf22bb78122aa",
        "X-RapidAPI-Host": "advanced-movie-search.p.rapidapi.com"
    ]

    let url = URL(string: "https://advanced-movie-search.p.rapidapi.com/search/movie?query=kong&page=1")!
    
    func fetchMovies() async {
        do {
            guard let fetchedMovies = try await WebService().downloadData(url: url, headers: headers) else {
                return
            }
            movies = fetchedMovies
        } catch {
            print("Error fetching movies: \(error)")
        }
    }
    
    func shuffleMovies() {
        movies.shuffle()
    }
}

