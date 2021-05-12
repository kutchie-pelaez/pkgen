import Foundation

public enum ExternalDependency: Decodable {
    case github(Github)

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
        case invalidSource
    }
}
