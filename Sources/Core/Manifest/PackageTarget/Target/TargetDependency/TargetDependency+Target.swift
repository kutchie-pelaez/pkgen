extension PackageTarget.Target.TargetDependency {

    public struct Target: Equatable {

        public let name: String
        public let condition: TargetDependencyCondition?

        public init(name: String,
                    condition: TargetDependencyCondition? = nil) {
            self.name = name
            self.condition = condition
        }
    }
}
