// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ModuleD",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "ModuleD",
            targets: [
                "ModuleD"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/PathKit.git", .branch("master")),
        .package(url: "https://github.com/jpsim/Yams.git", from: "4.0.0"),
        .package(path: "../ModuleC"),
        .package(path: "../ModuleB"),
        .package(path: "../ModuleA")
    ],
    targets: [
        .target(
            name: "ModuleD",
            dependencies: [
                .product(name: "PathKit", package: "PathKit"),
                .product(name: "Yams", package: "Yams"),
                .product(name: "ModuleC", package: "ModuleC"),
                .product(name: "ModuleB", package: "ModuleB"),
                .product(name: "ModuleA", package: "ModuleA")
            ],
            path: "Sources"
        )
    ]
)
