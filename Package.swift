// swift-tools-version:5.3.0

import PackageDescription

// MARK: - Name

let name: String = "PackageGen"

// MARK: - Platforms

let platforms: [SupportedPlatform] = [
    .macOS(.v10_13)
]

// MARK: - Products

let products: [Product] = [
    .executable(
        name: "pkgen",
        targets: [
            "PackageGen"
        ]
    )
]

// MARK: - Dependencies

let dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/kylef/PathKit.git", from: "1.0.0"),
    .package(url: "https://github.com/jpsim/Yams.git", from: "4.0.0"),
    .package(url: "https://github.com/jakeheis/SwiftCLI.git", from: "6.0.0"),
    .package(url: "https://github.com/onevcat/Rainbow.git", .upToNextMajor(from: "4.0.0")),
    .package(url: "https://github.com/SwiftDocOrg/GraphViz.git", from: "0.4.1")
]

// MARK: - Targets

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
            "GraphKit"
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

// MARK: - Package

//let package = Package(
//    name: <#T##String#>,
//    defaultLocalization: <#T##LanguageTag?#>,
//    platforms: <#T##[SupportedPlatform]?#>,
//    pkgConfig: <#T##String?#>,
//    providers: <#T##[SystemPackageProvider]?#>,
//    products: <#T##[Product]#>,
//    dependencies: <#T##[Package.Dependency]#>,
//    targets: <#T##[Target]#>,
//    swiftLanguageVersions: <#T##[SwiftVersion]?#>,
//    cLanguageStandard: <#T##CLanguageStandard?#>,
//    cxxLanguageStandard: <#T##CXXLanguageStandard?#>
//)

let package = Package(
    name: name,
    platforms: platforms,
    products: products,
    dependencies: dependencies,
    targets: targets + testTargets
)
