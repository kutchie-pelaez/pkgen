// MARK: - Decodable

extension BuildSettingCondition: Decodable {

    private enum CodingKeys: String, CodingKey {
        case type
        case platforms
        case configuration
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let stringType = try? container.decode(String.self, forKey: .type) else {
            throw BuildSettingConditionDecodingError.noType
        }

        switch stringType {
        case "when":
            let platforms = try? container.decode([Platform].self, forKey: .platforms)
            let configuration = try? container.decode(BuildConfiguration.self, forKey: .configuration)
            self = .when(
                .init(
                    platforms: platforms,
                    configuration: configuration
                )
            )

        default:
            throw BuildSettingConditionDecodingError.invalidType
        }
    }
}

// MARK: - BuildSettingConditionDecodingError

extension BuildSettingCondition {

    public enum BuildSettingConditionDecodingError: Error {
        case noType
        case invalidType
    }
}
