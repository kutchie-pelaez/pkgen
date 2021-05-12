import Foundation
import PathKit

public enum ExternalDependency: Decodable {
    case github(Github)

    public func name() throws -> String {
        switch self {
        case let .github(github):
            guard let lastPathName = Path(github.path).components.last else { throw ExternalDependencyDecodingError.invalidGithubPath }

            return lastPathName
        }
    }

    // MARK: - Decodable

    private enum CodingKeys: String, CodingKey {
        case github, branch, from
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let github = try? container.decode(String.self, forKey: .github) {
            if let branch = try? container.decode(String.self, forKey: .github) {
                self = .github(.init(path: github, route: .branch(branch)))
            } else if let from = try? container.decode(String.self, forKey: .from) {
                self = .github(.init(path: github, route: .from(from)))
            } else {
                throw ExternalDependencyDecodingError.invalidGithubRoute
            }
        } else {
            throw ExternalDependencyDecodingError.invalidSource
        }
    }

    // MARK: - Decoding errors

    public enum ExternalDependencyDecodingError: Error {
        case invalidGithubRoute
        case invalidGithubPath
        case invalidSource
    }
}
