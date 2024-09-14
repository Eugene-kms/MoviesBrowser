import UIKit
import Swinject

public final class MoviesCoordinatorLive: MoviesCoordinator {
    
    public var navigationController: UINavigationController
    private let container: Container
    
    public var rootViewController: UIViewController!
    
    public init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    public func start() {
        let viewModel = MoviesViewModel(
            container: container,
            coordinator: self
        )
        let moviesVC = MoviesViewController()
        moviesVC.viewModel = viewModel
        navigationController.setViewControllers(
            [moviesVC],
            animated: false
        )
        self.rootViewController = moviesVC
    }
    
    public func showMoviesDetail(for movie: MovieDetail) {
        let coordinator = MovieDetailCoordinatorLive(
            navigationController: navigationController,
            container: container,
            movieDetail: movie
        )
        coordinator.start()
    }
}
