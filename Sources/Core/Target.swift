import Foundation

public struct Target: Decodable {
    public let name: String
    public let dependencies: [String]

    init(name: String,
         dependencies: [String]) {
        self.name = name
        self.dependencies = dependencies
    }
}
