// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Coinpaprika",
    platforms: [.iOS(.v10), .macOS(.v10_12), .tvOS(.v10), .watchOS(.v3)],
    products: [
        .library(name: "Coinpaprika", targets: ["Coinpaprika"]),
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "NetworkingMocks", targets: ["NetworkingMocks"])
    ],
    targets: [
        .target(
            name: "Coinpaprika",
            dependencies: [.target(name: "Networking")],
            path: "Sources/Client"
            ),
        .target(
            name: "Networking",
            path: "Sources/Networking"
        ),
        .target(
            name: "NetworkingMocks",
            dependencies: ["Networking"],
            path: "Sources/NetworkingMocks"
        ),
        .testTarget(
            name: "CoinpaprikaTests",
            dependencies: ["Coinpaprika", "NetworkingMocks"],
            path: "Tests"
        )
    ]
)
