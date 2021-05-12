import Foundation
import PathKit

public enum LocalDependency: Decodable, Equatable {
    case path(String)

    public func name() throws -> String {
        switch self {
        case let .path(path):
            guard let lastPathName = Path(path).components.last else { throw LocalDependencyDecodingError.invalidLocalDependencyPath }

            return lastPathName
        }
    }

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
        case invalidLocalDependencyPath
    }
}
