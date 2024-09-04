import Foundation
import Swinject
import MBMovies

class AppAssembly {
    let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func asemble() {
        let accessToken = Bundle.main.object(forInfoDictionaryKey: "TMDBAPIAccessToken") as! String
        
        let config = TMDBNetworkConfig(accessToken: accessToken)
        let networkService = NetworkServiceLive(config: config)
        let service = MoviesServiceLive(
            accessToken: accessToken,
            networkService: networkService
        )
        
        container.register(NetworkConfig.self) { container in
            config
        }
        container.register(NetworkService.self) { container in
            networkService
        }
        container.register(MoviesService.self) { container in
            service
        }
    }
}
