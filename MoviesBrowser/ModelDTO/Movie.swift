import Foundation
import MBMovies

struct MovieDTO: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
    
    func toDomain() -> Movie {
        return Movie(
            id: id,
            title: title,
            posterPath: posterPath,
            releaseDate: releaseDate
        )
    }
}
