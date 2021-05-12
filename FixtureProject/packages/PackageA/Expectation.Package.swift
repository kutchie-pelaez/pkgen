// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "PackageA",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "PackageA",
            targets: [
                "PackageA"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/PathKit.git", .branch("master")),
        .package(url: "https://github.com/jpsim/Yams.git", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "PackageA",
            dependencies: [
                .product(name: "PathKit", package: "PathKit"),
                .product(name: "Yams", package: "Yams")
            ],
            path: "Sources"
        )
    ]
)
