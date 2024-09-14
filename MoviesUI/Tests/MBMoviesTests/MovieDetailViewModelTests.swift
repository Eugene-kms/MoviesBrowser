import Foundation
import XCTest
import Swinject
@testable import MBMovies

final class MovieDetailViewModelTests: XCTestCase {
    private var viewModel: MovieDetailViewModel!
    private var movieDetail: MovieDetail!
    private var container: Container!
    private var coordinator: MovieDetailCoordinatorMock!
    
    override func setUp() {
        super.setUp()
        container = Container()
        container.register(MoviesService.self,
                           factory: { _ in MoviesServiceMock() })
        
        movieDetail = MovieDetail(
            id: 33,
            title: "Alien: Romulus",
            overview: "Overview",
            posterPath: nil,
            releaseDate: "2023",
            voteAverage: 8.5
        )
        
        coordinator = MovieDetailCoordinatorMock()
        viewModel = MovieDetailViewModel(
            movieDetail: movieDetail,
            coordinator: coordinator,
            container: container
        )
    }
    
    func test_whenTapedCellMovie_thenShouldShowMovieDetail() async throws {
        //when
        try await viewModel.fetch()
        
        //then
        XCTAssertEqual(viewModel.movieDetail.id, 33)
        XCTAssertEqual(viewModel.movieDetail.title, "Alien: Romulus")
        XCTAssertEqual(viewModel.movieDetail.voteAverage, 8.5)
    }
}
