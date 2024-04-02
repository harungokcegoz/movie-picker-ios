import Foundation

private enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}

class WebService: Codable {
    func downloadData<T: Codable>(url: URL, headers: [String: String]) async -> T? {
        do {
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            
            guard (200..<300).contains(httpResponse.statusCode) else { throw NetworkError.badStatus }
            
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
}


class MovieViewModel: ObservableObject {
    @Published var movies: [MovieModel] = []
    
    let headers = [
        "X-RapidAPI-Key": "2285790515msh8e72398585d3ec8p1858ddjsnf22bb78122aa",
        "X-RapidAPI-Host": "advanced-movie-search.p.rapidapi.com"
    ]

    let url = URL(string: "https://advanced-movie-search.p.rapidapi.com/search/movie?query=kong&page=1")!
    
    func fetchMovies() async {
        guard let fetchedMovies: [MovieModel] = await WebService().downloadData(url: url, headers: headers) else { return }
        movies = fetchedMovies
        print(movies)
    }
}

