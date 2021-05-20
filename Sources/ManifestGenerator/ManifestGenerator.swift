import Core

final class ManifestGenerator {

    private let manifest: Manifest

    init(with manifest: Manifest) {
        self.manifest = manifest
    }

    public func generateRawPackageString() -> String {
        header
            .chain(name)
            .chain(defaultLocalization)
            .chain(platforms)
            .chain(pkgConfig)
            .chain(providers)
            .chain(products)
            .chain(dependencies)
            .chain(targets)
            .chain(swiftLanguageVersions)
            .chain(cLanguageStandard)
            .chain(cxxLanguageStandard)
            .chain(package)
            .newLine
            .string
    }
}

private extension ManifestGenerator {

    var header: PrimitiveProtocol {
        SwiftToolsVersion(manifest.swiftToolsVersion)
            .newLines(2)
            .import("PackageDescription")
            .newLines(2)
    }

    var name: PrimitiveProtocol {
        PropertyDeclaration(name: "name", type: "String")
            .string(manifest.name)
            .newLines(2)
    }

    var defaultLocalization: PrimitiveProtocol {
        if let manifestDefaultLocalization = manifest.defaultLocalization {
            return PropertyDeclaration(name: "defaultLocalization", type: "LanguageTag")
                .string(manifestDefaultLocalization)
                .newLines(2)
        } else {
            return Empty()
        }
    }

    var platforms: PrimitiveProtocol {
        if let manifestPlatforms = manifest.platforms {
            return PropertyDeclaration(name: "platforms", type: "[SupportedPlatform]")
                .platforms(manifestPlatforms)
                .newLines(2)
        } else {
            return Empty()
        }
    }

    var pkgConfig: PrimitiveProtocol {
        if let manifestPKGConfig = manifest.pkgConfig {
            return PropertyDeclaration(name: "pkgConfig", type: "String")
                .string(manifestPKGConfig)
                .newLines(2)
        } else {
            return Empty()
        }
    }

    var providers: PrimitiveProtocol {
        if let manifestProviders = manifest.providers {
            return PropertyDeclaration(name: "providers", type: "[SystemPackageProvider]")
                .providers(manifestProviders)
                .newLines(2)
        } else {
            return Empty()
        }
    }

    var products: PrimitiveProtocol {
        if let manifestProducts = manifest.products {
            return PropertyDeclaration(name: "products", type: "[Product]")
                .chain("TODO")
                .newLines(2)
        } else {
            return Empty()
        }
    }

    var dependencies: PrimitiveProtocol {
        if let manifestDependencies = manifest.dependencies {
            return PropertyDeclaration(name: "dependencies", type: "[Package.Dependency]")
                .chain("TODO")
                .newLines(2)
        } else {
            return Empty()
        }
    }

    var targets: PrimitiveProtocol {
        if let manifestTargets = manifest.targets {
            return PropertyDeclaration(name: "targets", type: "[Target]")
                .chain("TODO")
                .newLines(2)
        } else {
            return Empty()
        }
    }

    var swiftLanguageVersions: PrimitiveProtocol {
        if let manifestSwiftLanguageVersions = manifest.swiftLanguageVersions {
            return PropertyDeclaration(name: "swiftLanguageVersions", type: "[SwiftVersion]")
                .chain("TODO")
                .newLines(2)
        } else {
            return Empty()
        }
    }

    var cLanguageStandard: PrimitiveProtocol {
        if let manifestCLanguageStandard = manifest.cLanguageStandard {
            return PropertyDeclaration(name: "cLanguageStandard", type: "CLanguageStandard")
                .chain("TODO")
                .newLines(2)
        } else {
            return Empty()
        }
    }

    var cxxLanguageStandard: PrimitiveProtocol {
        if let manifestCXXLanguageStandard = manifest.cxxLanguageStandard {
            return PropertyDeclaration(name: "cxxLanguageStandard", type: "[CXXLanguageStandard]")
                .chain("TODO")
                .newLines(2)
        } else {
            return Empty()
        }
    }

    var package: PrimitiveProtocol {
        Package(
            hasDefaultLocalization: manifest.defaultLocalization != nil,
            hasPlatforms: manifest.platforms != nil,
            hasPKGConfig: manifest.pkgConfig != nil,
            hasProviders: manifest.providers != nil,
            hasProducts: manifest.products != nil,
            hasDependencies: manifest.dependencies != nil,
            hasTargets: manifest.targets != nil,
            hasSwiftLanguageVersions: manifest.swiftLanguageVersions != nil,
            hasCLanguageStandard: manifest.cLanguageStandard != nil,
            hasCXXLanguageStandard: manifest.cxxLanguageStandard != nil
        )
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
    .apt(
        [
            "A",
            "B"
        ]
    ),
    .brew(
        [
            "A",
            "B"
        ]
    )
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
