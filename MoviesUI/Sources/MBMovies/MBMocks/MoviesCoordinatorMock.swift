import Foundation

class MoviesCoordinatorMock: MoviesCoordinator {
    var showMovieDetailCalled: Bool = true
    var passedMovieDetail: MovieDetail?
    
    func showMoviesDetail(for movie: MovieDetail) {
        showMovieDetailCalled = true
        passedMovieDetail = movie
    }
    func start() {}
}
