import Foundation

class MoviesServiceMock: MoviesService {
    let mockData: [Movie] = [Movie(
        id: 33,
        title: "Alien: Romulus",
        posterPath: nil,
        releaseDate: "2023"
    ),
    Movie(
        id: 2,
        title: "Twilight of the Warriors: Walled In",
        posterPath: nil,
        releaseDate: "2023"
    ),
    Movie(
        id: 88,
        title: "DeadPool",
        posterPath: nil,
        releaseDate: "2021"
    )]
    
    func fetchPopularMovies() async throws -> [Movie] {
        return mockData
    }
    
    func searchMovies(query: String) async throws -> [Movie] {
        return mockData.filter {
            $0.title.lowercased().contains(query.lowercased())
        }
    }
    
    func fetchMovieDetails(id: Int) async throws -> MovieDetail {
        if let movie = mockData.first(where: { $0.id == id }) {
            return MovieDetail(
                id: id,
                title: movie.title,
                overview: "Overview of \(movie.title)",
                posterPath: movie.posterPath,
                releaseDate: movie.releaseDate,
                voteAverage: 8.5
            )
        } else {
            throw NSError(domain: "Movie not found", code: 404, userInfo: nil)
        }
    }
}
