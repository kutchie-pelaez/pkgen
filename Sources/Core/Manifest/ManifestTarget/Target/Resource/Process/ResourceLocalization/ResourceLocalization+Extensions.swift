// MARK: - Decodable

extension ManifestTarget.Target.Resource.Process.ResourceLocalization: Decodable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        guard let string = try? container.decode(String.self) else {
            throw ResourceLocalizationDecodingError.noString
        }

        switch string {
        case "base":
            self = .base

        case "default":
            self = .default

        default:
            self = .custom(string)
        }
    }
}

// MARK: - ResourceLocalizationDecodingError

extension ManifestTarget.Target.Resource.Process.ResourceLocalization {

    public enum ResourceLocalizationDecodingError: Error {
        case noString
    }
}
