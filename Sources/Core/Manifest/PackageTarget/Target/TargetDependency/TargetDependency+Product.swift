extension PackageTarget.Target.TargetDependency {

    public struct Product: Equatable {

        public let name: String
        public let package: String
        public let condition: TargetDependencyCondition?

        public init(name: String,
                    package: String,
                    condition: TargetDependencyCondition? = nil) {
            self.name = name
            self.package = package
            self.condition = condition
        }
    }
}
