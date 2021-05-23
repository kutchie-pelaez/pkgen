// MARK: - Decodable

extension ManifestTarget.Target.Dependency: Decodable {

    private enum CodingKeys: String, CodingKey {
        case type
        case name
        case package
        case condition
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let stringType = try? container.decode(String.self, forKey: .type) else {
            throw DependencyDecodingError.noType
        }

        guard let name = try? container.decode(String.self, forKey: .name) else {
            throw DependencyDecodingError.noName
        }

        switch stringType {
        case "byName":
            self = .byName(
                .init(
                    name: name,
                    condition: try? container.decode(Condition.self, forKey: .condition)
                )
            )

        case "product":
            if let package = try? container.decode(String.self, forKey: .package) {
                self = .product(
                    .init(
                        name: name,
                        package: package,
                        condition: try? container.decode(Condition.self, forKey: .condition)
                    )
                )
            } else {
                throw DependencyDecodingError.invalidProduct
            }

        case "target":
            self = .target(
                .init(
                    name: name,
                    condition: try? container.decode(Condition.self, forKey: .condition)
                )
            )

        default:
            throw DependencyDecodingError.invalidType
        }
    }
}

// MARK: - DependencyDecodingError

extension ManifestTarget.Target.Dependency {

    public enum DependencyDecodingError: Error {
        case noType
        case noName
        case invalidType
        case invalidProduct
    }
}
