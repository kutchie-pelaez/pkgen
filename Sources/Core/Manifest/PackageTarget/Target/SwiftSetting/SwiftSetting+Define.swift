extension PackageTarget.Target.SwiftSetting {

    public struct Define: Equatable {

        public let name: String
        public let condition: BuildSettingCondition?

        public init(name: String,
                    condition: BuildSettingCondition? = nil) {
            self.name = name
            self.condition = condition
        }
    }
}
