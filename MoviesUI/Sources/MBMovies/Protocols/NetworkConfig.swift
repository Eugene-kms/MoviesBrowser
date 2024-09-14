import Foundation

public protocol NetworkConfig {
    var baseURL: URL { get }
    var headers: [String: String] { get }
}
