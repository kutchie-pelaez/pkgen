// MARK: - Decodable

extension ManifestTarget.Target.Dependency.Condition: Decodable {

    private enum CodingKeys: String, CodingKey {
        case type
        case platforms
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let stringType = try? container.decode(String.self, forKey: .type) else {
            throw ConditionDecodingError.noType
        }

        switch stringType {
        case "when":
            self = .when(
                .init(
                    platforms: try? container.decode([Platform].self, forKey: .platforms)
                )
            )

        default:
            throw ConditionDecodingError.invalidType
        }
    }
}

// MARK: - ConditionDecodingError

extension ManifestTarget.Target.Dependency.Condition {

    public enum ConditionDecodingError: Error {
        case noType
        case invalidType
    }
}
