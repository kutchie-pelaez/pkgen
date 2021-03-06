// MARK: - Decodable

extension ManifestTarget.Target.Resource: Decodable {

    private enum CodingKeys: String, CodingKey {
        case type
        case path
        case localization
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let stringType = try? container.decode(String.self, forKey: .type) else {
            throw ResourceDecodingError.noType
        }

        guard let path = try? container.decode(String.self, forKey: .path) else {
            throw ResourceDecodingError.noPath
        }

        switch stringType {
        case "copy":
            self = .copy(
                .init(
                    path: path
                )
            )

        case "process":
            let localization = try? container.decode(Process.ResourceLocalization.self, forKey: .localization)
            self = .process(
                .init(
                    path: path,
                    localization: localization
                )
            )

        default:
            throw ResourceDecodingError.invalidType
        }
    }
}

// MARK: - ResourceDecodingError

extension ManifestTarget.Target.Resource {

    public enum ResourceDecodingError: Error {
        case noType
        case noPath
        case invalidType
    }
}
