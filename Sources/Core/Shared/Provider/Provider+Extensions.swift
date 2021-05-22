// MARK: - Decodable

extension Provider: Decodable {

    private enum CodingKeys: String, CodingKey {
        case type, packages
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let packages = (try? container.decode([String].self, forKey: .packages)) ?? []

        guard let stringType = try? container.decode(String.self, forKey: .type) else {
            throw PackageProviderDecodingError.noTypeSpecified
        }

        switch stringType {
        case "apt":
            self = .apt(packages: packages)

        case "brew":
            self = .brew(packages: packages)

        case "yam":
            self = .yum(packages: packages)

        default:
            throw PackageProviderDecodingError.invalidTypeProvided
        }
    }
}

// MARK: - PackageProviderDecodingError

extension Provider {

    public enum PackageProviderDecodingError: Error {
        case invalidTypeProvided
        case noTypeSpecified
        case invalidLocalDependencyPath
    }
}
