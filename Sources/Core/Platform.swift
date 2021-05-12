import Foundation

public enum Platform: Decodable {
    case iOS(String)
    case macOS(String)

    // MARK: - Decodable

    private enum CodingKeys: String, CodingKey {
        case type, version
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let type = try? container.decode(String.self, forKey: .type) else { throw PlatformDecodingError.noPlatfotmTypeSpecified }
        guard let version = try? container.decode(String.self, forKey: .version) else { throw PlatformDecodingError.noPlatfotmVersionSpecified }

        switch type {
        case "iOS": self = .iOS(version)
        case "macOS": self = .macOS(version)
        default: throw PlatformDecodingError.invalidPlatfotmVersionSpecified
        }
    }

    // MARK: - Decoding errors

    public enum PlatformDecodingError: Error {
        case noPlatfotmTypeSpecified
        case noPlatfotmVersionSpecified
        case invalidPlatfotmVersionSpecified
    }
}
