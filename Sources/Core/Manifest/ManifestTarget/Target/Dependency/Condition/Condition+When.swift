extension ManifestTarget.Target.Dependency.Condition {

    public struct When: Equatable {

        public let platforms: [Platform]?

        public init(platforms: [Platform]? = nil) {
            self.platforms = platforms
        }
    }
}
