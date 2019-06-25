// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Coinpaprika",
    platforms: [.iOS(.v10), .macOS(.v10_12), .tvOS(.v10), .watchOS(.v3)],
    products: [
        .library(name: "Coinpaprika", targets: ["Coinpaprika", "CoinpaprikaNetworking"])
    ],
    targets: [
        .target(
            name: "Coinpaprika",
            dependencies: [.target(name: "CoinpaprikaNetworking")],
            path: "CoinpaprikaAPI/Classes/Client"
            ),
        .target(
            name: "CoinpaprikaNetworking",
            path: "CoinpaprikaAPI/Classes/Networking"
        )   
    ]
)
