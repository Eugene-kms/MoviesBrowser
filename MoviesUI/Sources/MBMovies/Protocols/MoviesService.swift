import Foundation

public protocol MoviesService {
    func fetchPopularMovies() async throws -> [Movie]
    func searchMovies(query: String) async throws -> [Movie]
    func fetchMovieDetails(id: Int) async throws -> MovieDetail
}
