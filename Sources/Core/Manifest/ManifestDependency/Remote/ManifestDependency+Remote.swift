extension ManifestDependency {

    public struct Remote: Equatable {

        public let url: String
        public let requirement: Requirement
        public let name: String?

        public init(url: String,
                    requirement: Requirement,
                    name: String? = nil) {
            self.url = url
            self.requirement = requirement
            self.name = name
        }
    }
}
