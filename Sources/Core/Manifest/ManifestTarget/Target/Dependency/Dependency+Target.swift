extension ManifestTarget.Target.Dependency {

    public struct Target: Equatable {

        public let name: String
        public let condition: Condition?

        public init(name: String,
                    condition: Condition? = nil) {
            self.name = name
            self.condition = condition
        }
    }
}
