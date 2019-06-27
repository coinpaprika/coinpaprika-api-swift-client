// swift-tools-version:5.1
import PackageDescription

let excludeList = ["Example", "docs", "fastlane"]

let package = Package(
    name: "Coinpaprika",
    platforms: [.iOS(.v10), .macOS(.v10_12), .tvOS(.v10), .watchOS(.v3)],
    products: [
        .library(name: "Coinpaprika", targets: ["Coinpaprika"]),
        .library(name: "Networking", targets: ["Networking"])
    ],
    targets: [
        .target(
            name: "Coinpaprika",
            dependencies: [.target(name: "Networking")],
            path: "CoinpaprikaAPI/Classes/Client",
            exclude: excludeList
            ),
        .target(
            name: "Networking",
            path: "CoinpaprikaAPI/Classes/Networking",
            exclude: excludeList
        ),
        .testTarget(
            name: "CoinpaprikaTests",
            dependencies: ["Coinpaprika"],
            path: "Example/Tests",
            exclude: excludeList
        )
    ]
)
