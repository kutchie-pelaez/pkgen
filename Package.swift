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
        .package(url: "https://github.com/jakeheis/SwiftCLI.git", from: "6.0.0"),
        .package(url: "https://github.com/onevcat/Rainbow.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/SwiftDocOrg/GraphViz.git", from: "0.4.1")
    ],
    targets: [
        .target(
            name: "PackageGen",
            dependencies: [
                "PackageGenCLI"
            ]
        ),
        .target(
            name: "GraphKit",
            dependencies: [
                "Core",
                "PathKit",
                "Rainbow",
                "GraphViz"
            ]
        ),
        .target(
            name: "PackageGenCLI",
            dependencies: [
                "CodeGeneration",
                "SwiftCLI",
                "PathKit",
                "Rainbow"
            ]
        ),
        .target(
            name: "CodeGeneration",
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
            name: "PackageGenCLITests",
            dependencies: [
                "PackageGenCLI",
                "Core",
                "PathKit"
            ]
        ),
        .testTarget(
            name: "CodeGenerationTests",
            dependencies: [
                "CodeGeneration",
                "Core",
                "PathKit"
            ]
        ),
        .testTarget(
            name: "CoreModelsTests",
            dependencies: [
                "Core"
            ]
        )
    ]
)
