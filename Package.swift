// swift-tools-version:5.3.0

import PackageDescription

let name: String = "PackageGen"

let platforms: [SupportedPlatform] = [
    .macOS(.v10_13)
]

let products: [Product] = [
    .executable(
        name: "pkgen",
        targets: [
            "PackageGen"
        ]
    )
]

let dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/kylef/PathKit.git", from: "1.0.0"),
    .package(url: "https://github.com/jpsim/Yams.git", from: "4.0.0"),
    .package(url: "https://github.com/jakeheis/SwiftCLI.git", from: "6.0.0"),
    .package(url: "https://github.com/onevcat/Rainbow.git", .upToNextMajor(from: "4.0.0")),
    .package(url: "https://github.com/SwiftDocOrg/GraphViz.git", from: "0.4.1")
]

let targets: [Target] = [
    .target(
        name: "PackageGen",
        dependencies: [
            "PackageGenCLI"
        ]
    ),
    .target(
        name: "PackageGenCLI",
        dependencies: [
            "ManifestGenerator",
            "SwiftCLI",
            "PathKit",
            "Rainbow",
            "GraphGenerator"
        ]
    ),
    .target(
        name: "GraphGenerator",
        dependencies: [
            "Core",
            "PathKit",
            "Rainbow",
            "GraphViz"
        ]
    ),
    .target(
        name: "ManifestGenerator",
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
    )
]

let testTargets: [Target] = [
    .testTarget(
        name: "CacheTests",
        dependencies: [
            "PackageGenCLI",
            "Core",
            "PathKit"
        ]
    ),
    .testTarget(
        name: "CodeGenerationTests",
        dependencies: [
            "ManifestGenerator",
            "Core",
            "PathKit"
        ]
    ),
    .testTarget(
        name: "CoreTests",
        dependencies: [
            "Core"
        ]
    )
]

let package = Package(
    name: name,
    platforms: platforms,
    products: products,
    dependencies: dependencies,
    targets: targets + testTargets
)
