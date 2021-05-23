extension ManifestTarget.Target.LinkerSetting {

    public struct LinkedFramework: Equatable {

        public let framework: String
        public let condition: BuildSettingCondition?

        public init(framework: String,
                    condition: BuildSettingCondition? = nil) {
            self.framework = framework
            self.condition = condition
        }
    }
}
