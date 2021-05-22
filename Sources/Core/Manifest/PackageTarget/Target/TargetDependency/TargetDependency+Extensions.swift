// MARK: - Decodable

extension PackageTarget.Target.TargetDependency: Decodable {

    private enum CodingKeys: String, CodingKey {
        case type
        case name
        case package
        case condition
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let stringType = try? container.decode(String.self, forKey: .type) else {
            throw TargetDependencyDecodingError.noTypeSpecified
        }

        guard let name = try? container.decode(String.self, forKey: .name) else {
            throw TargetDependencyDecodingError.noNameSpecified
        }

        switch stringType {
        case "byName":
            self = .byName(
                .init(
                    name: name,
                    condition: try? container.decode(TargetDependencyCondition.self, forKey: .condition)
                )
            )

        case "product":
            if let package = try? container.decode(String.self, forKey: .package) {
                self = .product(
                    .init(
                        name: name,
                        package: package,
                        condition: try? container.decode(TargetDependencyCondition.self, forKey: .condition)
                    )
                )
            } else {
                throw TargetDependencyDecodingError.invalidProductTargetDependency
            }

        case "target":
            self = .target(
                .init(
                    name: name,
                    condition: try? container.decode(TargetDependencyCondition.self, forKey: .condition)
                )
            )

        default:
            throw TargetDependencyDecodingError.invalidType
        }
    }
}

// MARK: - TargetDependencyDecodingError

extension PackageTarget.Target.TargetDependency {

    public enum TargetDependencyDecodingError: Error {
        case noTypeSpecified
        case noNameSpecified
        case invalidType
        case invalidProductTargetDependency
    }
}
