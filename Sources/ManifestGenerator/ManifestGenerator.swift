import Core

final class PackageGenerator {

    private let manifest: Manifest

    init(with manifest: Manifest) {
        self.manifest = manifest
    }

    public func generateRawPackageBasedOnManifest() throws -> String {
        let header = SwiftToolsVersion(manifest.swiftToolsVersion)
            .newLines(2)
            .import("PackageDescription")
            .newLines(2)

        let packageDeclartion = PackageDeclarationStart()
            .newLine

        let name = Name(manifest.name, isLastArgument: false)
            .indented(with: .tab)
            .newLine

//        let platforms = Platforms(manifest.platforms, isLastArgument: false)
//            .indented(with: .tab)
//            .newLine
//
//        let products = Products(manifest.products, isLastArgument: false)
//            .indented(with: .tab)
//            .newLine
//
//        let dependencies = Dependencies(manifest.dependencies, isLastArgument: false)
//            .indented(with: .tab)
//            .newLine
//
//        let targets = Targets(manifest.targets, isLastArgument: true)
//            .indented(with: .tab)
//            .newLine

        return header
//            .chain(packageDeclartion)
//            .chain(name)
//            .chain(platforms)
//            .chain(products)
//            .chain(dependencies)
//            .chain(targets)
//            .parenthesis(type: .closed)
//            .newLine
            .string
    }
}



/*



// swift-tools-version:5.3.0

import PackageDescription

let name: String = "PackageGen"

let defaultLocalization: LanguageTag = ""

let platforms: [SupportedPlatform] = [
    .macOS(.v10_13)
]

let pkgConfig: String = ""

let providers: [SystemPackageProvider] = [

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
    ),
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

let swiftLanguageVersions: [SwiftVersion] = [

]

let cLanguageStandard: CLanguageStandard = .c11

let cxxLanguageStandard: CXXLanguageStandard = .cxx03

let package = Package(
    name: name,
    defaultLocalization: defaultLocalization,
    platforms: platforms,
    pkgConfig: pkgConfig,
    providers: providers,
    products: products,
    dependencies: dependencies,
    targets: targets,
    swiftLanguageVersions: swiftLanguageVersions,
    cLanguageStandard: cLanguageStandard,
    cxxLanguageStandard: cxxLanguageStandard
)


 
*/
