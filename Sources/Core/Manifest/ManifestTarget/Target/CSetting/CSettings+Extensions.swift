// MARK: - Decodable

extension ManifestTarget.Target.CSetting: Decodable {

    private enum CodingKeys: String, CodingKey {
        case type
        case name
        case to
        case condition
        case path
        case flags
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let stringType = try? container.decode(String.self, forKey: .type) else {
            throw CSettingDecodingError.noType
        }

        let condition = try? container.decode(BuildSettingCondition.self, forKey: .condition)

        switch stringType {
        case "define":
            if let name = try? container.decode(String.self, forKey: .name),
               let to = try? container.decode(String.self, forKey: .to) {
                self = .define(
                    .init(
                        name: name,
                        to: to,
                        condition: condition
                    )
                )
            } else {
                throw CSettingDecodingError.invalidDefine
            }

        case "headerSearchPath":
            if let path = try? container.decode(String.self, forKey: .path) {
                self = .headerSearchPath(
                    .init(
                        path: path,
                        condition: condition
                    )
                )
            } else {
                throw CSettingDecodingError.invalidHeaderSearchPath
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
                throw CSettingDecodingError.invalidUnsafeFlags
            }

        default:
            throw CSettingDecodingError.invalidType
        }
    }
}

// MARK: - CSettingDecodingError

extension ManifestTarget.Target.CSetting {

    public enum CSettingDecodingError: Error {
        case noType
        case invalidType
        case invalidDefine
        case invalidHeaderSearchPath
        case invalidUnsafeFlags
    }
}
