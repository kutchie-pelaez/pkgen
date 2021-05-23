import Foundation
import Yams
import PathKit

// MARK: - init(from:at:with:)

extension Manifest {

    public init(from data: Data,
                at path: Path,
                with packagefile: Packagefile) throws {
        let decoder = YAMLDecoder()
        var manifest: Manifest

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
                manifest = .init(swiftToolsVersion: "", name: "")
            } else {
                throw ManifestDecodingError.invalidPackagefile
            }
        } else {
            throw ManifestDecodingError.invalidPackagefile
        }

        let name = manifest.decodedName == nil ? path.parent().lastComponent : manifest.name

        // swiftToolsVersion
        if manifest.decodedSwiftToolsVersion == nil {
            if let packagefileSwiftToolsVersion = packagefile.swiftToolsVersion {
                manifest.swiftToolsVersion = packagefileSwiftToolsVersion
            } else {
                throw ManifestDecodingError.noSwiftToolsVersion
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
            let fallbackProduct = ManifestProduct.library(
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

// MARK: - Decodable

extension Manifest: Decodable {

    private enum CodingKeys: String, CodingKey {
        case swiftToolsVersion
        case name
        case defaultLocalization
        case platforms
        case pkgConfig
        case providers
        case products
        case dependencies
        case targets
        case swiftLanguageVersions
        case cLanguageStandard
        case cxxLanguageStandard
    }

    // Do not use this init directly
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // If swiftToolsVersion is not specified in manifest file
        // default value from Packagefile will be taken in init(from:at:with:)
        let decodedSwiftToolsVersion = try? container.decode(String.self, forKey: .swiftToolsVersion)
        self.decodedSwiftToolsVersion = decodedSwiftToolsVersion
        self.swiftToolsVersion = decodedSwiftToolsVersion ?? ""

        // If name is not specified in manifest file
        // default value as directory name where manifest
        // file is located will be taken in init(from:at:with:)
        let decodedName = try? container.decode(String.self, forKey: .name)
        self.decodedName = decodedName
        self.name = decodedName ?? ""

        self.defaultLocalization = try? container.decode(String.self, forKey: .defaultLocalization)

        self.platforms = try? container.decode(Platforms.self, forKey: .platforms)

        self.pkgConfig = try? container.decode(String.self, forKey: .pkgConfig)

        self.providers = try? container.decode([Provider].self, forKey: .providers)

        // If not provided init(from:at:with:) will
        // generate one product with package name
        self.products = try? container.decode([ManifestProduct].self, forKey: .products)

        // Will be populated in init(from:at:with:) from decodedDependencies
        self.dependencies = nil
        self.decodedDependencies = try? container.decode([String].self, forKey: .dependencies)

        // If not provided init(from:at:with:) will
        // generate one target with package name
        self.targets = try? container.decode([ManifestTarget].self, forKey: .targets)

        self.swiftLanguageVersions = try? container.decode([SwiftVersion].self, forKey: .swiftLanguageVersions)

        self.cLanguageStandard = try? container.decode(CStandard.self, forKey: .cLanguageStandard)

        self.cxxLanguageStandard = try? container.decode(CXXStandard.self, forKey: .cxxLanguageStandard)
    }
}

// MARK: - Equatable

extension Manifest: Equatable {

    public static func == (lhs: Manifest, rhs: Manifest) -> Bool {
        lhs.swiftToolsVersion == rhs.swiftToolsVersion &&
        lhs.name == rhs.name &&
        lhs.defaultLocalization == rhs.defaultLocalization &&
        lhs.platforms == rhs.platforms &&
        lhs.pkgConfig == rhs.pkgConfig &&
        lhs.providers == rhs.providers &&
        lhs.products == rhs.products &&
        lhs.dependencies == rhs.dependencies &&
        lhs.targets == rhs.targets &&
        lhs.swiftLanguageVersions == rhs.swiftLanguageVersions &&
        lhs.cLanguageStandard == rhs.cLanguageStandard &&
        lhs.cxxLanguageStandard == rhs.cxxLanguageStandard
    }
}

// MARK: - Decoding errors

extension Manifest {

    public enum ManifestDecodingError: Error {
        case noPlatforms
        case invalidDependencyName
        case invalidPackagefile
        case noSwiftToolsVersion
    }
}
