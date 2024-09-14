import Foundation

public protocol MoviesCoordinator: Coordinator {
    func showMoviesDetail(for movie: MovieDetail)
}
