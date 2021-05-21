import Foundation

public struct Platforms: Decodable, Equatable {
    public let iOS: String?
    public let macOS: String?
    public let tvOS: String?
    public let watchOS: String?

    public init(iOS: String? = nil,
                macOS: String? = nil,
                tvOS: String? = nil,
                watchOS: String? = nil) {
        self.iOS = iOS
        self.macOS = macOS
        self.tvOS = tvOS
        self.watchOS = watchOS
    }
}
