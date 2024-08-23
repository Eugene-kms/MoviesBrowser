import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
