extension ManifestTarget.Target.CSetting {

    public struct Define: Equatable {

        public let name: String
        public let to: String
        public let condition: BuildSettingCondition?

        public init(name: String,
                    to: String,
                    condition: BuildSettingCondition? = nil) {
            self.name = name
            self.to = to
            self.condition = condition
        }
    }
}
