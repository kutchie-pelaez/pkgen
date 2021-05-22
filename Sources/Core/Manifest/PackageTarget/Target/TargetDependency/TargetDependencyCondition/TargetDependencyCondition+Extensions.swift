// MARK: - Decodable

extension PackageTarget.Target.TargetDependency.TargetDependencyCondition: Decodable {

    private enum CodingKeys: String, CodingKey {
        case type
        case platforms
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let stringType = try? container.decode(String.self, forKey: .type) else {
            throw TargetDependencyConditionDecodingError.noTypeSpecified
        }

        switch stringType {
        case "when":
            self = .when(
                .init(
                    platforms: try? container.decode([Platform].self, forKey: .platforms)
                )
            )

        default:
            throw TargetDependencyConditionDecodingError.invalidType
        }
    }
}

// MARK: - TargetDependencyConditionDecodingError

extension PackageTarget.Target.TargetDependency.TargetDependencyCondition {

    public enum TargetDependencyConditionDecodingError: Error {
        case noTypeSpecified
        case invalidType
    }
}
