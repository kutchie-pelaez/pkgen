import Foundation

public struct Platforms: Decodable, Equatable {
    public let iOS: String?
    public let macOS: String?

    public init(iOS: String?,
                macOS: String?) {
        self.iOS = iOS
        self.macOS = macOS
    }
}
