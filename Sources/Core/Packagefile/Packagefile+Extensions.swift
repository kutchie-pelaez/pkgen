import Foundation
import Yams

// MARK: - Decodable

extension Packagefile {

    private enum CodingKeys: String, CodingKey {
        case swiftToolsVersion
        case defaultLocalization
        case platforms
        case pkgConfig
        case providers
        case swiftLanguageVersions
        case cLanguageStandard
        case cxxLanguageStandard
        case dependencies
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        swiftToolsVersion = try? container.decode(String.self, forKey: .swiftToolsVersion)
        defaultLocalization = try? container.decode(String.self, forKey: .defaultLocalization)
        platforms = try? container.decode(Platforms.self, forKey: .platforms)
        pkgConfig = try? container.decode(String.self, forKey: .pkgConfig)
        providers = try? container.decode([Provider].self, forKey: .providers)
        swiftLanguageVersions = try? container.decode([SwiftVersion].self, forKey: .swiftLanguageVersions)
        cLanguageStandard = try? container.decode(CStandard.self, forKey: .cLanguageStandard)
        cxxLanguageStandard = try? container.decode(CXXStandard.self, forKey: .cxxLanguageStandard)
        externalDependencies = try? container.decode([PackagefileDependency].self, forKey: .dependencies)
    }

    public init(from data: Data) throws {
        let decoder = YAMLDecoder()
        self = try decoder.decode(Packagefile.self, from: data)
    }
}

// MARK: - Empty

extension Packagefile {

    public static let empty = Packagefile()
}
