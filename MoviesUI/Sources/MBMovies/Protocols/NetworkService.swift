import Foundation

public protocol NetworkService {
    func fetch<T: Decodable>(path: String, queryItems: [URLQueryItem]) async throws -> T
}

extension NetworkService {
    func fetch<T: Decodable>(path: String) async throws -> T {
        try await fetch(path: path, queryItems: [])
    }
}
