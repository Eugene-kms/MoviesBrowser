import Foundation
import Swinject

class MovieDetailViewModel {
    var movieDetail: MovieDetail
    private let coordinator: MovieDetailCoordinator
    private let container: Container
    private var moviesService: MoviesService {
        container.resolve(MoviesService.self)!
    }
    
    init(
        movieDetail: MovieDetail,
        coordinator: MovieDetailCoordinator,
        container: Container
    ) {
        self.movieDetail = movieDetail
        self.coordinator = coordinator
        self.container = container
    }
    
    func fetch() async throws {
        movieDetail = try await moviesService.fetchMovieDetails(id: movieDetail.id)
    }
}
