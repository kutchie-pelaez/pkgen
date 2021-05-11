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
        .package(url: "https://github.com/onevcat/Rainbow.git", from: "3.0.0"),
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
                "Core",
                "SwiftCLI",
                "Rainbow",
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
    ]
)
