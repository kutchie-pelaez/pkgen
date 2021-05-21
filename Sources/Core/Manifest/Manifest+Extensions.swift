import Foundation

// MARK: - Decodable

extension Manifest: Decodable {

    private enum CodingKeys: String, CodingKey {
        case swiftToolsVersion, name, defaultLocalization, platforms, pkgConfig, providers, products, dependencies, targets, swiftLanguageVersions, cLanguageStandard, cxxLanguageStandard
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

        self.providers = try? container.decode([PackageProvider].self, forKey: .providers)

        // If not provided init(from:at:with:) will
        // generate one product with package name
        self.products = try? container.decode([Product].self, forKey: .products)

        // Will be populated in init(from:at:with:) from decodedDependencies
        self.dependencies = nil
        self.decodedDependencies = try? container.decode([String].self, forKey: .dependencies)

        // If not provided init(from:at:with:) will
        // generate one target with package name
        self.targets = try? container.decode([Target].self, forKey: .targets)

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
        case invalidPackagePath
        case noPlatformsSpecified
        case invalidDependencyName
        case invalidPackageFileData
        case noSwiftToolsVersionSpecified
    }
}

// MARK: - Empty

extension Manifest {

    public static let empty = Manifest(
        swiftToolsVersion: "",
        name: ""
    )
}
