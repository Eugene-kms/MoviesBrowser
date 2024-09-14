import XCTest
import Swinject
@testable import MBMovies

final class MoviesViewModelTests: XCTestCase {
    private var viewModel: MoviesViewModel!
    private var container: Container!
    private var coordinator: MoviesCoordinatorMock!
    
    override func setUp() {
        super.setUp()
        container = Container()
        container.register(MoviesService.self, 
                           factory: { _ in MoviesServiceMock() })
        
        coordinator = MoviesCoordinatorMock()
        viewModel = MoviesViewModel(
            container: container,
            coordinator: coordinator
        )
    }
    
    func test_whenSearch_thenOnlyOneSectionShown() {
        //given
        let query = "a"
        
        //when
        viewModel.search(with: query)
        
        //then
        XCTAssertEqual(viewModel.sectionTitles.count, 1)
        XCTAssertEqual(viewModel.sectionTitles[0], MoviesStrings.moviesSection.rawValue)
    }
    
    func test_whenSearch_thenShouldFilterResults() async throws {
        //given
        let query = "al"
        await viewModel.loadMovies()
        
        //when
        viewModel.search(with: query)
        
        //then
        XCTAssertEqual(viewModel.movies.keys.count, 1)
        XCTAssertEqual(viewModel.movies[MoviesStrings.moviesSection.rawValue]!.count, 2)
        XCTAssertEqual(viewModel.movies[MoviesStrings.moviesSection.rawValue]!.map { $0.title }, ["Alien: Romulus", "Twilight of the Warriors: Walled In"])
    }
    
    func test_whenSearchAndCancel_thenShouldShownAllContacts() async throws {
        //given
        await viewModel.loadMovies()
        let query = "al"
        viewModel.search(with: query)
        
        //when
        viewModel.search(with: "")
        
        //then
        XCTAssertEqual(viewModel.movies.keys.count, 3)
        XCTAssertEqual(viewModel.movies["A"]!.count, 1)
        XCTAssertEqual(viewModel.movies["T"]!.count, 1)
    }
    
    func test_DidSelectMovie_ShouldCallShowMovieDetail() async throws {
        //given
        let selectedMovie: Movie = Movie(
            id: 88,
            title: "DeadPool",
            posterPath: nil,
            releaseDate: "2021"
        )
        
        //when
        viewModel.didSelectMovie(selectedMovie)
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        //then
        XCTAssertTrue(coordinator.showMovieDetailCalled)
        XCTAssertEqual(coordinator.passedMovieDetail?.id, 88)
        XCTAssertEqual(coordinator.passedMovieDetail?.title, "DeadPool")
        XCTAssertEqual(coordinator.passedMovieDetail?.releaseDate, "2021")
    }
}
