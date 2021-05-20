import Foundation
import Yams

public struct Packagefile: Decodable, Equatable {

    public let swiftToolsVersion: String?
    public let defaultLocalization: String?
    public let platforms: Platforms?
    public let pkgConfig: String?
    public let providers: [PackageProvider]?
    public let swiftLanguageVersions: [SwiftVersion]?
    public let cLanguageStandard: CStandard?
    public let cxxLanguageStandard: CXXStandard?
    public let externalDependencies: [ExternalDependency]?

    public init(from data: Data) throws {
        let decoder = YAMLDecoder()
        self = try decoder.decode(Packagefile.self, from: data)
    }

    public init(swiftToolsVersion: String?,
                defaultLocalization: String?,
                platforms: Platforms?,
                pkgConfig: String?,
                providers: [PackageProvider]?,
                swiftLanguageVersions: [SwiftVersion]?,
                cLanguageStandard: CStandard?,
                cxxLanguageStandard: CXXStandard?,
                externalDependencies: [ExternalDependency]?) {
        self.swiftToolsVersion = swiftToolsVersion
        self.defaultLocalization = defaultLocalization
        self.platforms = platforms
        self.pkgConfig = pkgConfig
        self.providers = providers
        self.swiftLanguageVersions = swiftLanguageVersions
        self.cLanguageStandard = cLanguageStandard
        self.cxxLanguageStandard = cxxLanguageStandard
        self.externalDependencies = externalDependencies
    }

    // MARK: - Decodable

    private enum CodingKeys: String, CodingKey {
        case swiftToolsVersion, defaultLocalization, platforms, pkgConfig, providers, swiftLanguageVersions, cLanguageStandard, cxxLanguageStandard, externalDependencies
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        swiftToolsVersion = try? container.decode(String.self, forKey: .swiftToolsVersion)
        defaultLocalization = try? container.decode(String.self, forKey: .defaultLocalization)
        platforms = try? container.decode(Platforms.self, forKey: .platforms)
        pkgConfig = try? container.decode(String.self, forKey: .pkgConfig)
        providers = try? container.decode([PackageProvider].self, forKey: .providers)
        swiftLanguageVersions = try? container.decode([SwiftVersion].self, forKey: .swiftLanguageVersions)
        cLanguageStandard = try? container.decode(CStandard.self, forKey: .cLanguageStandard)
        cxxLanguageStandard = try? container.decode(CXXStandard.self, forKey: .cxxLanguageStandard)
        externalDependencies = try? container.decode([ExternalDependency].self, forKey: .externalDependencies)
    }
}
