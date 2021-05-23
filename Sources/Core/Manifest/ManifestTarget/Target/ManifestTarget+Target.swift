extension ManifestTarget {

    public struct Target: Equatable {

        public let name: String
        public let dependencies: [Dependency]?
        public let path: String?
        public let exclude: [String]?
        public let sources: [String]?
        public let resources: [Resource]?
        public let publicHeadersPath: String?
        public let cSettings: [CSetting]?
        public let cxxSettings: [CSetting]?
        public let swiftSettings: [SwiftSetting]?
        public let linkerSettings: [LinkerSetting]?

        public init(name: String,
                    dependencies: [Dependency]? = nil,
                    path: String? = nil,
                    exclude: [String]? = nil,
                    sources: [String]? = nil,
                    resources: [Resource]? = nil,
                    publicHeadersPath: String? = nil,
                    cSettings: [CSetting]? = nil,
                    cxxSettings: [CSetting]? = nil,
                    swiftSettings: [SwiftSetting]? = nil,
                    linkerSettings: [LinkerSetting]? = nil) {
            self.name = name
            self.dependencies = dependencies
            self.path = path
            self.exclude = exclude
            self.sources = sources
            self.resources = resources
            self.publicHeadersPath = publicHeadersPath
            self.cSettings = cSettings
            self.cxxSettings = cxxSettings
            self.swiftSettings = swiftSettings
            self.linkerSettings = linkerSettings
        }
    }
}
