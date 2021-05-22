import Foundation

public struct Target: Decodable, Equatable {
    
    public let name: String
    public let dependencies: [String]

    public init(name: String,
                dependencies: [String]) {
        self.name = name
        self.dependencies = dependencies
    }
}
