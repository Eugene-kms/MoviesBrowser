import Foundation

public struct Movie: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String
    
    public init(id: Int, title: String, posterPath: String?, releaseDate: String) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
