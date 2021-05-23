extension ManifestTarget.Target.CSetting {

    public struct HeaderSearchPath: Equatable {

        public let path: String
        public let condition: BuildSettingCondition?

        public init(path: String,
                    condition: BuildSettingCondition? = nil) {
            self.path = path
            self.condition = condition
        }
    }
}
