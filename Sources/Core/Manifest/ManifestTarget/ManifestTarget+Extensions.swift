// MARK: - Decodable

extension ManifestTarget: Decodable {

    private enum CodingKeys: String, CodingKey {
        case type
        case name
        case path
        case url
        case checksum
        case pkgConfig
        case providers
        case dependencies
        case exclude
        case sources
        case resources
        case publicHeadersPath
        case cSettings
        case cxxSettings
        case swiftSettings
        case linkerSettings
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let stringType = try? container.decode(String.self, forKey: .type) else {
            throw ManifestTargetDecodingError.noType
        }

        guard let name = try? container.decode(String.self, forKey: .name) else {
            throw ManifestTargetDecodingError.noName
        }

        switch stringType {
        case "binaryTarget":
            if let path = try? container.decode(String.self, forKey: .path) {
                self = .binaryTarget(
                    binaryTarget: .local(
                        .init(
                            name: name,
                            path: path
                        )
                    )
                )
            } else if let url = try? container.decode(String.self, forKey: .url),
                      let checksum = try? container.decode(String.self, forKey: .checksum) {
                self = .binaryTarget(
                    binaryTarget: .remote(
                        .init(
                            name: name,
                            url: url,
                            checksum: checksum
                        )
                    )
                )
            } else {
                throw ManifestTargetDecodingError.invalidBinaryTarget
            }
        case "systemLibrary":
            let path = try? container.decode(String.self, forKey: .path)
            let pkgConfig = try? container.decode(String.self, forKey: .pkgConfig)
            let providers = try? container.decode([Provider].self, forKey: .providers)
            self = .systemLibrary(
                systemLibrary: .init(
                    name: name,
                    path: path,
                    pkgConfig: pkgConfig,
                    providers: providers
                )
            )
        case "target", "testTarget":
            let dependencies = try? container.decode([Target.Dependency].self, forKey: .dependencies)
            let path = try? container.decode(String.self, forKey: .path)
            let exclude = try? container.decode([String].self, forKey: .exclude)
            let sources = try? container.decode([String].self, forKey: .sources)
            let resources = try? container.decode([Target.Resource].self, forKey: .resources)
            let publicHeadersPath = try? container.decode(String.self, forKey: .publicHeadersPath)
            let cSettings = try? container.decode([Target.CSetting].self, forKey: .cSettings)
            let cxxSettings = try? container.decode([Target.CSetting].self, forKey: .cxxSettings)
            let swiftSettings = try? container.decode([Target.SwiftSetting].self, forKey: .swiftSettings)
            let linkerSettings = try? container.decode([Target.LinkerSetting].self, forKey: .linkerSettings)
            let target = Target(
                name: name,
                dependencies: dependencies,
                path: path,
                exclude: exclude,
                sources: sources,
                resources: resources,
                publicHeadersPath: publicHeadersPath,
                cSettings: cSettings,
                cxxSettings: cxxSettings,
                swiftSettings: swiftSettings,
                linkerSettings: linkerSettings
            )
            if stringType == "target" {
                self = .target(
                    target: target
                )
            } else if stringType == "testTarget" {
                self = .testTarget(
                    testTarget: target
                )
            } else {
                throw ManifestTargetDecodingError.invalidType
            }

        default:
            throw ManifestTargetDecodingError.invalidType
        }
    }
}

// MARK: - ManifestTargetDecodingError

extension ManifestTarget {

    public enum ManifestTargetDecodingError: Error {
        case noType
        case noName
        case invalidType
        case invalidBinaryTarget
    }
}
