import Foundation

public struct Platforms: Decodable, Equatable {
    public let iOS: String?
    public let macOS: String?
    public let tvOS: String?
    public let watchOS: String?

    public init(iOS: String?,
                macOS: String?,
                tvOS: String?,
                watchOS: String?) {
        self.iOS = iOS
        self.macOS = macOS
        self.tvOS = tvOS
        self.watchOS = watchOS
    }
}
