import Yams
import PathKit
import Foundation

extension Manifest {

    public init(swiftToolsVersion: String,
                name: String,
                defaultLocalization: String? = nil, // TODO:
                platforms: Platforms? = nil,
                pkgConfig: Any? = nil, // TODO:
                providers: [Any]? = nil, // TODO:
                products: [Product] = [],
                dependencies: [Dependency] = [],
                targets: [Target] = [],
                swiftLanguageVersions: [Any]? = nil, // TODO:
                cLanguageStandard: Any? = nil, // TODO:
                cxxLanguageStandard: Any? = nil) { // TODO:
        self.swiftToolsVersion = swiftToolsVersion
        self.name = name
        self.defaultLocalization = defaultLocalization
        self.platforms = platforms
        self.pkgConfig = pkgConfig
        self.providers = providers
        self.products = products
        self.dependencies = dependencies
        self.targets = targets
        self.swiftLanguageVersions = swiftLanguageVersions
        self.cLanguageStandard = cLanguageStandard
        self.cxxLanguageStandard = cxxLanguageStandard
    }

    public init(from data: Data,
                at path: Path,
                with packagefile: Packagefile) throws {
        let decoder = YAMLDecoder()

        var manifest: Manifest = .empty
        if let decodedManifest = try? decoder.decode(Manifest.self, from: data) {
            manifest = decodedManifest
        } else if let rawDataStrig = String(data: data, encoding: .utf8) {
            let trimmedString = rawDataStrig
                .split(separator: "\n")
                .filter { line in !line.hasPrefix("#") }
                .joined(separator: "\n")
                .trimmingCharacters(in: [" ", "\n"])

            // When manifest file is empty (set all field as default)
            if trimmedString.isEmpty {
                manifest = .empty
            } else {
                throw ManifestDecodingError.invalidPackageFileData
            }
        } else {
            throw ManifestDecodingError.invalidPackageFileData
        }

        let name = manifest.decodedName == nil ? path.parent().lastComponent : manifest.name

        // swiftToolsVersion
        if manifest.decodedSwiftToolsVersion == nil {
            if let packagefileSwiftToolsVersion = packagefile.options.swiftToolsVersion {
                manifest.decodedSwiftToolsVersion = packagefileSwiftToolsVersion
            } else {
                throw ManifestDecodingError.noSwiftToolsVersionSpecified
            }
        }

        // name
        if manifest.decodedName == nil {
            manifest.name = name
        }

        // TODO: -
        // defaultLocalization
        if manifest.defaultLocalization == nil {

        }

        // platforms
        if manifest.platforms == nil {
            manifest.platforms = packagefile.options.platforms
        }

        // TODO: -
        // pkgConfig
        if manifest.pkgConfig == nil {

        }

        // TODO: -
        // providers
        if manifest.providers == nil {

        }

        // products
        if manifest.products == nil {
            let fallbackProducts = [
                Product.library(
                    .init(name: name,
                          targets: [
                            name
                          ],
                          linking: .auto
                    )
                )
            ]

            manifest.products = fallbackProducts
        }

        // dependencies
        var decodedDependencies = manifest.decodedDependencies
        if !decodedDependencies.isEmpty {
            let externalDependencies = try packagefile.externalDependencies
                .filter { decodedDependencies.contains(try $0.name()) }
                .map { Dependency.external($0) }
            decodedDependencies.removeAll(where: { externalDependencies.compactMap { try? $0.name() }.contains($0) })
            let internalDependencies = decodedDependencies
                .map { LocalDependency.path($0) }
                .map { Dependency.local($0) }
            
            manifest.dependencies = externalDependencies + internalDependencies
        }

        // targets
        if manifest.targets == nil {
            let fallbackTargets = [
                Target(
                    name: name,
                    dependencies: ["HEY"]
                )
            ]

            manifest.targets = fallbackTargets
        }

        // TODO: -
        // swiftLanguageVersions
        if manifest.swiftLanguageVersions == nil {

        }

        // TODO: -
        // cLanguageStandard
        if manifest.cLanguageStandard == nil {

        }

        // TODO: -
        // cxxLanguageStandard
        if manifest.cxxLanguageStandard == nil {

        }

        self = manifest
    }
}
