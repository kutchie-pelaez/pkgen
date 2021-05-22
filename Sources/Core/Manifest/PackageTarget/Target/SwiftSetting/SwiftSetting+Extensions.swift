// MARK: - Decodable

extension PackageTarget.Target.SwiftSetting: Decodable {

    private enum CodingKeys: String, CodingKey {
        case type
        case name
        case flags
        case condition
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let stringType = try? container.decode(String.self, forKey: .type) else {
            throw SwiftSettingDecodingError.noTypeSpecified
        }

        let condition = try? container.decode(BuildSettingCondition.self, forKey: .condition)

        switch stringType {
        case "define":
            if let name = try? container.decode(String.self, forKey: .name) {
                self = .define(
                    .init(
                        name: name,
                        condition: condition
                    )
                )
            } else {
                throw SwiftSettingDecodingError.invalidDefineSpecified
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
                throw SwiftSettingDecodingError.invalidUnsafeFlagsSpecified
            }

        default:
            throw SwiftSettingDecodingError.invalidType
        }
    }
}

// MARK: - SwiftSettingDecodingError

extension PackageTarget.Target.SwiftSetting {

    public enum SwiftSettingDecodingError: Error {
        case noTypeSpecified
        case invalidType
        case invalidDefineSpecified
        case invalidUnsafeFlagsSpecified
    }
}
