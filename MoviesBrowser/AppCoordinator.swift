import UIKit
import MBMovies
import Swinject

class AppCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let container: Container
    
    init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let coordinator = MoviesCoordinatorLive(
            navigationController: navigationController,
            container: container
        )
        coordinator.start()
    }
}
