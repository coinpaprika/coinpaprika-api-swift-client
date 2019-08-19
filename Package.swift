// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Coinpaprika",
    platforms: [.iOS(.v10), .macOS(.v10_12), .tvOS(.v10), .watchOS(.v3)],
    products: [
        .library(name: "Coinpaprika", targets: ["Coinpaprika"]),
        .library(name: "CoinpaprikaNetworking", targets: ["CoinpaprikaNetworking"]),
        .library(name: "CoinpaprikaNetworkingMocks", targets: ["CoinpaprikaNetworkingMocks"])
    ],
    targets: [
        .target(
            name: "Coinpaprika",
            dependencies: [.target(name: "CoinpaprikaNetworking")],
            path: "Sources/Client"
            ),
        .target(
            name: "CoinpaprikaNetworking",
            path: "Sources/Networking"
        ),
        .target(
            name: "CoinpaprikaNetworkingMocks",
            dependencies: ["CoinpaprikaNetworking"],
            path: "Sources/NetworkingMocks"
        ),
        .testTarget(
            name: "CoinpaprikaTests",
            dependencies: ["Coinpaprika", "CoinpaprikaNetworkingMocks"],
            path: "Tests"
        )
    ]
)
