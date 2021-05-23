extension ManifestTarget.Target.Dependency {

    public struct Product: Equatable {

        public let name: String
        public let package: String
        public let condition: Condition?

        public init(name: String,
                    package: String,
                    condition: Condition? = nil) {
            self.name = name
            self.package = package
            self.condition = condition
        }
    }
}
