import Foundation

extension Packagefile {

    public struct Options: Decodable, Equatable {
        public let swiftToolsVersion: String
        public let platforms: Platforms

        public init(swiftToolsVersion: String,
                    platforms: Platforms) {
            self.swiftToolsVersion = swiftToolsVersion
            self.platforms = platforms
        }

        // MARK: - Decodable

        private enum CodingKeys: String, CodingKey {
            case swiftToolsVersion, platforms
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            swiftToolsVersion = try container.decode(String.self, forKey: .swiftToolsVersion)
            platforms = try container.decode(Platforms.self, forKey: .platforms)
        }
    }
}
