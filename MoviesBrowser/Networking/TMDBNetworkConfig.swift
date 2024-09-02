import Foundation
import MBMovies

class TMDBNetworkConfig: NetworkConfig {
    let baseURL: URL = URL(string: "https://api.themoviedb.org/3")!
    var headers: [String: String] {
        [
            "Authorization": "Bearer \(accessToken)",
            "accept": "application/json"
        ]
    }
    
    private let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
}
