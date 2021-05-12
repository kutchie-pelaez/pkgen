// swift-tools-version:5.3.0

import PackageDescription

let package = Package(
    name: "PackageGen",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .executable(
            name: "pkgen",
            targets: [
                "PackageGen"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/PathKit.git", from: "1.0.0"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "4.0.0"),
        .package(url: "https://github.com/jakeheis/SwiftCLI.git", from: "6.0.0")
    ],
    targets: [
        .target(
            name: "PackageGen",
            dependencies: [
                "PackageGenCLI"
            ]
        ),
        .target(
            name: "PackageGenCLI",
            dependencies: [
                "Generation",
                "SwiftCLI",
                "PathKit"
            ]
        ),
        .target(
            name: "Generation",
            dependencies: [
                "Core",
                "PathKit"
            ]
        ),
        .target(
            name: "Core",
            dependencies: [
                "PathKit",
                "Yams"
            ]
        ),
        .testTarget(
            name: "GenerationTests",
            dependencies: [
                "Generation",
                "Core",
                "PathKit"
            ],
            exclude: [
                "TestProject"
            ]
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: [
                "Core"
            ],
            exclude: [
                "dummy_package.yml",
                "DummyPackagefile"
            ]
        )
    ]
)
