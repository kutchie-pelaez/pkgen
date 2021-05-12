import Yams
import PathKit
import Foundation

public struct Manifest: Decodable {
    public private(set) var swiftToolsVersion: String!
    public private(set) var name: String!
    public private(set) var platforms: [Platform]!
    public private(set) var products: [Product]!
//    public private(set) var dependencies: [Dependency]!
//    public private(set) var targets: [Target]!

    public init(from data: Data,
                at path: Path,
                with configuration: Configuration) throws {
        let decoder = YAMLDecoder()
        var manifest = try decoder.decode(Manifest.self, from: data)

        // Fallback accessors

        let fallbackName = { () throws -> String in
            if let lastPathComponent = path.components.last {
                return lastPathComponent
            } else {
                throw ManifestDecodingError.invalidPackagePath
            }
        }

        let fallbackPlatforms = { () throws -> [Platform] in
            let configurationPlatforms = configuration.options.platforms
            if !configurationPlatforms.isEmpty {
                return configurationPlatforms
            } else {
                throw ManifestDecodingError.noPlatformsSpecified
            }
        }

        let fallbackProducts = { () throws -> [Product] in
            let fallbackStaticLibrary = Product.library(
                .init(name: try fallbackName(),
                      targets: [
                        try fallbackName()
                      ],
                      linking: .static
                )
            )

            return [fallbackStaticLibrary]
        }

        // Fallback nil properties

        if manifest.swiftToolsVersion == nil {
            manifest.swiftToolsVersion = configuration.options.swiftToolsVersion
        }

        if manifest.name == nil {
            manifest.name = try fallbackName()
        }

        if manifest.platforms == nil {
            manifest.platforms = try fallbackPlatforms()
        }

        if manifest.products == nil {
            manifest.products = try fallbackProducts()
        }
    }

    // MARK: - Decodable

    private enum CodingKeys: String, CodingKey {
        case swiftToolsVersion, name, platforms, products
//             , dependencies, targets
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        swiftToolsVersion = try? container.decode(String.self, forKey: .swiftToolsVersion)
        name = try? container.decode(String.self, forKey: .name)
        platforms = try? container.decode([Platform].self, forKey: .platforms)
        products = try? container.decode([Product].self, forKey: .products)
    }

    // MARK: - Decoding errors

    public enum ManifestDecodingError: Error {
        case invalidPackagePath
        case noPlatformsSpecified
    }
}



//// swift-tools-version:5.3.0
//
//import PackageDescription
//
//let package = Package(
//    name: "PackageGen",
//    platforms: [
//        .macOS(.v10_13)
//    ],
//    products: [
//        .executable(
//            name: "pkgen",
//            targets: [
//                "PackageGen"
//            ]
//        )
//    ],
//    dependencies: [
//        .package(url: "https://github.com/kylef/PathKit.git", from: "1.0.0"),
//        .package(url: "https://github.com/jpsim/Yams.git", from: "4.0.0"),
//        .package(url: "https://github.com/onevcat/Rainbow.git", from: "3.0.0"),
//        .package(url: "https://github.com/jakeheis/SwiftCLI.git", from: "6.0.0")
//    ],
//    targets: [
//        .target(
//            name: "PackageGen",
//            dependencies: [
//                "PackageGenCLI"
//            ]
//        ),
//        .target(
//            name: "PackageGenCLI",
//            dependencies: [
//                "Core",
//                "SwiftCLI",
//                "Rainbow",
//                "PathKit"
//            ]
//        ),
//        .target(
//            name: "Core",
//            dependencies: [
//                "PathKit",
//                "Yams"
//            ]
//        ),
//    ]
//)
