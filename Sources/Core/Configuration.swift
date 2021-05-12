import Yams
import PathKit
import Foundation

public struct Configuration: Decodable {
    public let options: Options
    public let externalDependencies: [ExternalDependency]

    private enum CodingKeys: String, CodingKey {
        case options, externalDependencies
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        options = try container.decode(Options.self, forKey: .options)
        externalDependencies = (try? container.decode([ExternalDependency].self, forKey: .externalDependencies)) ?? []
    }

    // MARK: - Options

    public struct Options: Decodable {
        public let swiftToolsVersion: String
        public let platforms: [Platfotm]
    }

    // MARK: - ExternalDependency

    public enum ExternalDependency: Decodable {
        case github(Github)

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
                    throw ConfigurationParsingError.invalidGithubDependencyRoute
                }
            } else {
                throw ConfigurationParsingError.invalidExternalDependencySource
            }
        }

        public struct Github {
            public let path: String
            public let route: Route

            public enum Route {
                case branch(String)
                case from(String)
            }
        }
    }

    // MARK: - Platfotm

    public enum Platfotm: Decodable {
        case iOS(String)
        case macOS(String)

        private enum CodingKeys: String, CodingKey {
            case type, version
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            guard let type = try? container.decode(String.self, forKey: .type) else { throw ConfigurationParsingError.noPlatfotmTypeSpecified }
            guard let version = try? container.decode(String.self, forKey: .version) else { throw ConfigurationParsingError.noPlatfotmVersionSpecified }

            switch type {
            case "iOS": self = .iOS(version)
            case "macOS": self = .macOS(version)
            default: throw ConfigurationParsingError.invalidPlatfotmVersionSpecified
            }
        }
    }
}

extension Configuration {

    public enum ConfigurationParsingError: Error {
        case noPlatfotmTypeSpecified
        case noPlatfotmVersionSpecified
        case invalidPlatfotmVersionSpecified
        case invalidExternalDependencySource
        case invalidGithubDependencyRoute
    }

    public init(from data: Data) throws {
        let decoder = YAMLDecoder()
        self = try decoder.decode(Configuration.self, from: data)
    }
}
