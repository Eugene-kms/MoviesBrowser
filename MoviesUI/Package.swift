// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "MoviesUI",
    platforms: [.iOS(.v17)],
    products: [
        
        .library(
            name: "MBMovies",
            targets: ["MBMovies"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.1.0"),
        .package(url: "https://github.com/Swinject/Swinject.git", .upToNextMajor(from: "2.9.1"))
    ],
    targets: [
        .target(
            name: "MBMovies",
            dependencies: [
                "SnapKit",
                "SDWebImage",
                "Swinject"
            ]
        ),
        
        .testTarget(
            name: "MBMoviesTests",
            dependencies: ["MBMovies"]
        )
    ]
)
