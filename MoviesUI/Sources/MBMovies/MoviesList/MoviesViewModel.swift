import UIKit
import Swinject

public final class MoviesViewModel {
    private let container: Container
    private let coordinator: MoviesCoordinator
    private var networkService: NetworkService {
        container.resolve(NetworkService.self)!
    }
    public var moviesService: MoviesService
    private var moviesSource: [Movie] = []
    var movies: [String: [Movie]] = [:]
    var sectionTitles: [String] = []
    
    public init(container: Container, coordinator: MoviesCoordinator) {
        self.container = container
        self.coordinator = coordinator
        
        guard let service = container.resolve(MoviesService.self) else {
            fatalError("MoviesService could not be resolved")
        }
        self.moviesService = service
    }
    
    public func loadMovies() async {
        do {
            moviesSource = try await moviesService.fetchPopularMovies()
            updateMovies(with: moviesSource)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func search(with query: String) {
        guard !query.isEmpty else {
            updateMovies(with: moviesSource)
            return
        }
        let searchResults = moviesSource.filter {
            $0.title.lowercased().contains(query.lowercased())
        }
        didCompleteSearch(with: searchResults)
    }
    
    private func didCompleteSearch(with results: [Movie]) {
        self.movies = [
            MoviesStrings.moviesSection.rawValue: results
        ]
        sectionTitles = self.movies.keys.sorted()
    }
    
    private func updateMovies(with movies: [Movie]) {
        self.movies = Dictionary(grouping: movies, by: { $0.title.first.map { String($0) } ?? "A" })
        sectionTitles = self.movies.keys.sorted()
    }
    
    func didSelectMovie(_ movie: Movie) {
        Task {
            do {
                let movieDetail = try await moviesService.fetchMovieDetails(id: movie.id)
                coordinator.showMoviesDetail(for: movieDetail)
            } catch {
                print("Failed to fetch movie details: \(error)")
            }
        }
    }
 }
