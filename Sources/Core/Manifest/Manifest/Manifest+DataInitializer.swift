import Yams
import PathKit
import Foundation

extension Manifest {

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
            let fallbackProduct = Product.library(
                library: .init(
                    name: name,
                    targets: [
                        name
                    ]
                )
            )

            manifest.products = [fallbackProduct]
        }

        // dependencies
        if let decodedDependencies = manifest.decodedDependencies,
           !decodedDependencies.isEmpty {
            // TODO: -
        }

        // targets
        if manifest.targets == nil {
            // TODO: -
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
