import Foundation

extension Configuration {

    public struct Options: Decodable {
        public let swiftToolsVersion: String
        public let platforms: [Platform]

        // MARK: - Decodable

        private enum CodingKeys: String, CodingKey {
            case swiftToolsVersion, platforms
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            swiftToolsVersion = try container.decode(String.self, forKey: .swiftToolsVersion)
            platforms = (try? container.decode([Platform].self, forKey: .platforms)) ?? []
        }
    }
}
