// swift-tools-version:5.3.0

import PackageDescription

let package = Package(
    name: "ModuleB",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "ModuleB",
            targets: [
                "ModuleB"
            ]
        )
    ],
    dependencies: [
        .package(path: "../ModuleA")
    ],
    targets: [
        .target(
            name: "ModuleB",
            dependencies: [
                .product(name: "ModuleA", package: "ModuleA")
            ],
            path: "Sources"
        )
    ]
)
