// MARK: - Decodable

extension PackageTarget.Target.LinkerSetting: Decodable {

    private enum CodingKeys: String, CodingKey {
        case type
        case framework
        case library
        case flags
        case condition
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let stringType = try? container.decode(String.self, forKey: .type) else {
            throw LinkerSettingDecodingError.noTypeSpecified
        }

        let condition = try? container.decode(BuildSettingCondition.self, forKey: .condition)

        switch stringType {
        case "linkedFramework":
            if let framework = try? container.decode(String.self, forKey: .framework) {
                self = .linkedFramework(
                    .init(
                        framework: framework,
                        condition: condition
                    )
                )
            } else {
                throw LinkerSettingDecodingError.invalidLinkedFrameworkSpecified
            }

        case "linkedLibrary":
            if let library = try? container.decode(String.self, forKey: .library) {
                self = .linkedLibrary(
                    .init(
                        library: library,
                        condition: condition
                    )
                )
            } else {
                throw LinkerSettingDecodingError.invalidLinkedLibrarySpecified
            }

        case "unsafeFlags":
            if let flags = try? container.decode([String].self, forKey: .flags) {
                self = .unsafeFlags(
                    .init(
                        flags: flags,
                        condition: condition
                    )
                )
            } else {
                throw LinkerSettingDecodingError.invalidUnsafeFlagsSpecified
            }

        default:
            throw LinkerSettingDecodingError.invalidType
        }
    }
}

// MARK: - LinkerSettingDecodingError

extension PackageTarget.Target.LinkerSetting {

    public enum LinkerSettingDecodingError: Error {
        case noTypeSpecified
        case invalidType
        case invalidLinkedFrameworkSpecified
        case invalidLinkedLibrarySpecified
        case invalidUnsafeFlagsSpecified
    }
}
