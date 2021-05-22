public struct Platforms: Decodable, Equatable {
    
    public let iOS: IOSVersion?
    public let macOS: MacOSVersion?
    public let tvOS: TVOSVersion?
    public let watchOS: WatchOSVersion?

    public init(iOS: IOSVersion? = nil,
                macOS: MacOSVersion? = nil,
                tvOS: TVOSVersion? = nil,
                watchOS: WatchOSVersion? = nil) {
        self.iOS = iOS
        self.macOS = macOS
        self.tvOS = tvOS
        self.watchOS = watchOS
    }
}
