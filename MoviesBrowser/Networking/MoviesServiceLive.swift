import Foundation
import MBMovies

class MoviesServiceLive: MoviesService {
    
    private let accessToken: String
    private let networkService: NetworkService
    
    init(accessToken: String, networkService: NetworkService) {
        self.accessToken = accessToken
        self.networkService = networkService
    }
    
    func fetchPopularMovies() async throws -> [Movie] {
        
        let moviesResponse: MoviesResponse = try await networkService.fetch(path: "/movie/popular", queryItems: [])
        
        return moviesResponse.results.map { $0.toDomain() }
    }
    
    func searchMovies(query: String) async throws -> [Movie] {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let queryItem = URLQueryItem(name: "query", value: encodedQuery)
        
        let moviesResponse: MoviesResponse = try await networkService.fetch(
            path: "/search/movie",
            queryItems: [queryItem]
        )
        
        return moviesResponse.results.map { $0.toDomain() }
    }
    
    func fetchMovieDetails(id: Int) async throws -> MovieDetail {
        try await networkService.fetch(path: "/movie/\(id)", queryItems: [])
    }
}
