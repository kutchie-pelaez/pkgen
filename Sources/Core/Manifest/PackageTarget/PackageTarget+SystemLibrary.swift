extension PackageTarget {

    public struct SystemLibrary: Equatable {

        public let name: String
        public let path: String?
        public let pkgConfig: String?
        public let providers: [Provider]?

        public init(name: String,
                    path: String? = nil,
                    pkgConfig: String? = nil,
                    providers: [Provider]? = nil) {
            self.name = name
            self.path = path
            self.pkgConfig = pkgConfig
            self.providers = providers
        }
    }
}
