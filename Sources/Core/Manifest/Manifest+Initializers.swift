import Yams
import PathKit
import Foundation

extension Manifest {

    public init(swiftToolsVersion: String,
                name: String,
                defaultLocalization: String? = nil,
                platforms: Platforms? = nil,
                pkgConfig: String? = nil,
                providers: [PackageProvider]? = nil,
                products: [Product]? = nil,
                dependencies: [Dependency]? = nil,
                targets: [Target]? = nil,
                swiftLanguageVersions: [SwiftVersion]? = nil,
                cLanguageStandard: CStandard? = nil,
                cxxLanguageStandard: CXXStandard? = nil) {
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
            if let packagefileSwiftToolsVersion = packagefile.swiftToolsVersion {
                manifest.swiftToolsVersion = packagefileSwiftToolsVersion
            } else {
                throw ManifestDecodingError.noSwiftToolsVersionSpecified
            }
        }

        // name
        if manifest.decodedName == nil {
            manifest.name = name
        }

        // defaultLocalization
        if manifest.defaultLocalization == nil {
            manifest.defaultLocalization = packagefile.defaultLocalization
        }

        // platforms
        if manifest.platforms == nil {
            manifest.platforms = packagefile.platforms
        }

        // pkgConfig
        if manifest.pkgConfig == nil {
            manifest.pkgConfig = packagefile.pkgConfig
        }

        // providers
        if manifest.providers == nil {
            manifest.providers = packagefile.providers
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
        if var decodedDependencies = manifest.decodedDependencies {
            if !decodedDependencies.isEmpty {
                let externalDependencies = try packagefile.externalDependencies?
                    .filter { decodedDependencies.contains(try $0.name()) }
                    .map { Dependency.external($0) } ?? []
                let externalDependenciesNames = externalDependencies
                    .map { try? $0.name() }
                    .compactMap { $0 }
                decodedDependencies.removeAll(where: { externalDependenciesNames.contains($0) })
                let internalDependencies = decodedDependencies
                    .map { LocalDependency.path($0) }
                    .map { Dependency.local($0) }

                manifest.dependencies = externalDependencies + internalDependencies
            }
        }

        // targets
        if manifest.targets == nil {
            let fallbackTargets = [
                Target(
                    name: name,
                    dependencies: []
                )
            ]

            manifest.targets = fallbackTargets
        }

        // swiftLanguageVersions
        if manifest.swiftLanguageVersions == nil {
            manifest.swiftLanguageVersions = packagefile.swiftLanguageVersions
        }

        // cLanguageStandard
        if manifest.cLanguageStandard == nil {
            manifest.cLanguageStandard = packagefile.cLanguageStandard
        }

        // cxxLanguageStandard
        if manifest.cxxLanguageStandard == nil {
            manifest.cxxLanguageStandard = packagefile.cxxLanguageStandard
        }

        self = manifest
    }
}
