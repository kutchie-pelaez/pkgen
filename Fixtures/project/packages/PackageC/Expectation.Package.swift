// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "PackageC",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "PackageC",
            targets: [
                "PackageC"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/PathKit.git", .branch("master")),
        .package(path: "../PackageA"),
        .package(path: "../PackageB")
    ],
    targets: [
        .target(
            name: "PackageC",
            dependencies: [
                .product(name: "PathKit", package: "PathKit"),
                .product(name: "PackageA", package: "PackageA"),
                .product(name: "PackageB", package: "PackageB")
            ],
            path: "Sources"
        )
    ]
)
