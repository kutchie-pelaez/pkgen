// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ModuleC",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "ModuleC",
            targets: [
                "ModuleC"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/PathKit.git", .branch("master")),
        .package(path: "../ModuleA"),
        .package(path: "../ModuleB")
    ],
    targets: [
        .target(
            name: "ModuleC",
            dependencies: [
                .product(name: "PathKit", package: "PathKit"),
                .product(name: "ModuleA", package: "ModuleA"),
                .product(name: "ModuleB", package: "ModuleB")
            ],
            path: "Sources"
        )
    ]
)
