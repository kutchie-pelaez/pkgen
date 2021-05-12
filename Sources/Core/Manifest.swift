import Yams
import PathKit
import Foundation

public struct Manifest: Decodable {
    public private(set) var swiftToolsVersion: String!
    public private(set) var name: String!
    public private(set) var platforms: Platforms!
    public private(set) var products: [Product]!
    private var rawStringDependencies: [String] = []
    public private(set) var dependencies: [Dependency]!
    public private(set) var targets: [Target]!

    public init(from data: Data,
                at path: Path,
                with configuration: Configuration) throws {
        let decoder = YAMLDecoder()
        var manifest = try decoder.decode(Manifest.self, from: data)

        // Fallback accessors

        let fallbackName = path.parent().lastComponent

        let fallbackProducts = [
            Product.library(
                .init(name: fallbackName,
                      targets: [
                        fallbackName
                      ],
                      linking: .auto
                )
            )
        ]

        // Fallback nil properties

        if manifest.swiftToolsVersion == nil {
            manifest.swiftToolsVersion = configuration.options.swiftToolsVersion
        }

        if manifest.name == nil {
            manifest.name = fallbackName
        }

        if manifest.platforms == nil {
            manifest.platforms = configuration.options.platforms
        }

        if manifest.products == nil {
            manifest.products = fallbackProducts
        }

        // Find dependencies for package

        var rawStringDependencies = manifest.rawStringDependencies

        let externalDependencies = try configuration.externalDependencies
            .filter { externalDependency in
                let name = try externalDependency.name()

                return rawStringDependencies.contains(name)
            }
        rawStringDependencies.removeAll(where: { externalDependencies.compactMap { try? $0.name() }.contains($0) })

        let localDependencies = rawStringDependencies.map { LocalDependency.path($0) }

        let allDependencies = externalDependencies.map { Dependency.external($0) } + localDependencies.map { Dependency.local($0) }

        manifest.dependencies = allDependencies

        // Set targets after dependencies

        let allDependenciesNames = { () throws -> [String] in
            try allDependencies.map { try $0.name() }
        }
        let fallbackTargets = [
            Target(
                name: fallbackName,
                dependencies: try allDependenciesNames()
            )
        ]

        if manifest.targets == nil {
            manifest.targets = fallbackTargets
        }

        // Manifest is finally configured here

        self = manifest
    }

    // MARK: - Decodable

    private enum CodingKeys: String, CodingKey {
        case swiftToolsVersion, name, platforms, products, dependencies, targets
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        swiftToolsVersion = try? container.decode(String.self, forKey: .swiftToolsVersion)
        name = try? container.decode(String.self, forKey: .name)
        platforms = try? container.decode(Platforms.self, forKey: .platforms)
        products = try? container.decode([Product].self, forKey: .products)
        products = try? container.decode([Product].self, forKey: .products)
        rawStringDependencies = (try? container.decode([String].self, forKey: .dependencies)) ?? []
        targets = try? container.decode([Target].self, forKey: .targets)
    }

    // MARK: - Decoding errors

    public enum ManifestDecodingError: Error {
        case invalidPackagePath
        case noPlatformsSpecified
        case invalidDependencyName
    }
}
