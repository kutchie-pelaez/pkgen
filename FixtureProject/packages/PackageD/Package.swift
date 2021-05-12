// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "PackageD",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "PackageD",
            targets: [
                "PackageD"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/PathKit.git", .branch("master")),
        .package(url: "https://github.com/jpsim/Yams.git", from: "4.0.0"),
        .package(path: "../PackageC"),
        .package(path: "../PackageB"),
        .package(path: "../PackageA")
    ],
    targets: [
        .target(
            name: "PackageD",
            dependencies: [
                .product(name: "PathKit", package: "PathKit"),
                .product(name: "Yams", package: "Yams"),
                .product(name: "PackageC", package: "PackageC"),
                .product(name: "PackageB", package: "PackageB"),
                .product(name: "PackageA", package: "PackageA")
            ],
            path: "Sources"
        )
    ]
)
