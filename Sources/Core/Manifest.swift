import Yams
import PathKit
import Foundation

public struct Manifest: Decodable {
    public private(set) var name: String!
    public private(set) var platforms: [Platform]!
//    public private(set) var products: [Product]!
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

        // Fallback nil properties

        if manifest.name == nil {
            manifest.name = try fallbackName()
        }

        if manifest.platforms == nil {
            manifest.platforms = try fallbackPlatforms()
        }
    }

    // MARK: - Decodable

    private enum CodingKeys: String, CodingKey {
        case name, platforms
//             products, dependencies, targets
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try? container.decode(String.self, forKey: .name)
        platforms = try? container.decode([Platform].self, forKey: .platforms)
    }

    // MARK: - Decoding errors

    public enum ManifestDecodingError: Error {
        case invalidPackagePath
        case noPlatformsSpecified
    }
}




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
