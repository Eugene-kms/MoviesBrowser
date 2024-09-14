import UIKit
import Swinject

public final class MovieDetailCoordinatorLive: MovieDetailCoordinator {
    
    private let navigationController: UINavigationController
    private let container: Container
    private let movieDetail: MovieDetail
    
    public init(navigationController: UINavigationController, container: Container, movieDetail: MovieDetail) {
        self.navigationController = navigationController
        self.container = container
        self.movieDetail = movieDetail
    }
    
    public func start() {
        let viewModel = MovieDetailViewModel(
            movieDetail: movieDetail,
            coordinator: self,
            container: container
        )
        
        Task { @MainActor in
            let movieDetailVC = MovieDetailViewController()
            movieDetailVC.viewModel = viewModel
            navigationController.pushViewController(movieDetailVC, animated: true)
        }
    }
    
    public func showMovieDetail() {
        let coordinator = MovieDetailCoordinatorLive(
            navigationController: navigationController,
            container: container,
            movieDetail: movieDetail
        )
        coordinator.start()
    }
}
