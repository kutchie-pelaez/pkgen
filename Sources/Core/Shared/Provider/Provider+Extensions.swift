// MARK: - Decodable

extension Provider: Decodable {

    private enum CodingKeys: String, CodingKey {
        case type
        case packages
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let stringType = try? container.decode(String.self, forKey: .type) else {
            throw ProviderDecodingError.noType
        }

        guard let packages = try? container.decode([String].self, forKey: .packages) else {
            throw ProviderDecodingError.noPackages
        }

        switch stringType {
        case "apt":
            self = .apt(
                packages: packages
            )

        case "brew":
            self = .brew(
                packages: packages
            )

        case "yam":
            self = .yum(
                packages: packages
            )

        default:
            throw ProviderDecodingError.invalidType
        }
    }
}

// MARK: - PackageProviderDecodingError

extension Provider {

    public enum ProviderDecodingError: Error {
        case noType
        case noPackages
        case invalidType
    }
}
