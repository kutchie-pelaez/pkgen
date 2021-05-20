import Foundation
import Yams

public struct Packagefile: Decodable, Equatable {

    public let options: Options
    public let externalDependencies: [ExternalDependency]

    public init(from data: Data) throws {
        let decoder = YAMLDecoder()
        self = try decoder.decode(Packagefile.self, from: data)
    }

    public init(options: Options,
                externalDependencies: [ExternalDependency]) {
        self.options = options
        self.externalDependencies = externalDependencies
    }

    // MARK: - Decodable

    private enum CodingKeys: String, CodingKey {
        case options, externalDependencies
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        options = try container.decode(Options.self, forKey: .options)
        externalDependencies = (try? container.decode([ExternalDependency].self, forKey: .externalDependencies)) ?? []
    }
}
