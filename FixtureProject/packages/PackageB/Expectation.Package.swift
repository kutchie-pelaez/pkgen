// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "PackageB",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "PackageB",
            targets: [
                "PackageB"
            ]
        )
    ],
    dependencies: [
        .package(path: "../PackageA")
    ],
    targets: [
        .target(
            name: "PackageB",
            dependencies: [
                .product(name: "PackageA", package: "PackageA")
            ],
            path: "Sources"
        )
    ]
)
