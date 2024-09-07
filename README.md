# MoviesBrowser

MoviesBorowser is an iOS app that allows you to view the 20 most popular movies, details of each film separately and search for a film by title. The information is available from www.themoviedb.org via link: https://www.themoviedb.org/movie using TMDb API.
When we click on the selected film we can see detailed information about the film, namely: title, release date, rating, film description.
The application is written using MVVM-C architecture.

## Setup instructions

### Prerequisites
- **Xcode**: Make sure you have the latest version of Xcode installed.
- Clone the Repository:
    git clone https://github.com/Eugene-kms/MoviesBrowser.git
    cd MoviesBrowser
- Setting up with Swift Package Manager.
- Install Dependencies.
- Open the .xcworkspace file.
- Add Your TMDb API Key in Info.plist file, TMDBAPIAccessToken = YOUR_TMDB_API_KEY.
    Before doing so, register at https://www.themoviedb.org to receive an API key.
- Run the Project.
- Third-Party Libraries:
    The app uses the following third-party libraries:
    -Swinject: A dependency injection framework for Swift to manage dependencies cleanly.
    -SDWebImage: A popular image downloading and caching library for asynchronously loading movie posters from the internet.
    -SnapKit: A layout framework used to create Auto Layout constraints programmatically.
    -XCTest: The built-in testing framework used for unit and integration tests.

- Architectural Decisions:
    MVVM-C (Model-View-ViewModel-Coordinator)
    Components:
    Model: Contains the data logic and structures, such as Movie and MovieDetail.
    ViewModel: Manages business logic, performs data manipulation, and interacts with services like MoviesService. For example, MoviesViewModel handles fetching and organizing movie data.
    View (ViewController): The user interface components that display the data from the ViewModel and interact with the user.
    Coordinator: Handles the navigation flow, ensuring that view controllers are decoupled from navigation logic. For example, MoviesCoordinator is responsible for navigating between the movie list and the movie detail view.
    
    Why MVVM-C?
    Navigation Logic Separation: By introducing the Coordinator, navigation logic is separated from the view controllers, allowing for more flexibility and reusability.
    Testability: Each component in the MVVM-C pattern can be tested in isolation, especially the business logic in ViewModel and the navigation flow in Coordinator.
    Scalability: With Coordinators, the app can easily scale with more complex navigation flows without cluttering the view controllers.

    Dependency Injection:
    The app uses Swinject for dependency injection to decouple components, making testing easier and promoting reusable code. The coordinator and services are injected into the view models, ensuring that no components are tightly coupled.

    Coordinators:
    The Coordinator pattern allows for the navigation logic to be extracted from the view controllers. This makes the navigation flow more modular and easier to extend, as different flows can have their own coordinators without cluttering the main views. For example:
    -MoviesCoordinator handles the navigation from the movie list to the movie detail screen.
