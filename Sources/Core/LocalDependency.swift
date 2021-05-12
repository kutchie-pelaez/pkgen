import Foundation

public enum LocalDependency: Decodable {
    case path(String)

    // MARK: - Decodable

    private enum CodingKeys: String, CodingKey {
        case path
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let path = try? container.decode(String.self, forKey: .path) {
            self = .path(path)
        } else {
            throw LocalDependencyDecodingError.invalidLocalDependency
        }
    }

    // MARK: - Decoding errors

    public enum LocalDependencyDecodingError: Error {
        case invalidLocalDependency
    }
}
