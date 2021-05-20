import Foundation

public enum PackageProvider: Decodable, Equatable {
    case apt(_ packages: [String])
    case brew(_ packages: [String])
    case yum(_ packages: [String])

    // MARK: - Decodable

    private enum CodingKeys: String, CodingKey {
        case type, packages
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let packages = (try? container.decode([String].self, forKey: .packages)) ?? []

        guard let type = try? container.decode(String.self, forKey: .type) else { throw PackageProviderDecodingError.noTypeSpecified }

        switch type {
        case "apt": self = .apt(packages)
        case "brew": self = .brew(packages)
        case "yam": self = .yum(packages)
        default: throw PackageProviderDecodingError.invalidTypeProvided
        }
    }

    // MARK: - Decoding errors

    public enum PackageProviderDecodingError: Error {
        case invalidTypeProvided
        case noTypeSpecified
        case invalidLocalDependencyPath
    }
}
