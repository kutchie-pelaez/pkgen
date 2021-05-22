extension PackageDependency {

    public struct LocalDependency: Equatable {

        public let path: String
        public let name: String?

        public init(path: String,
                    name: String? = nil) {
            self.path = path
            self.name = name
        }
    }
}
