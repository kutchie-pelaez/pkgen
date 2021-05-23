extension ManifestTarget.Target.LinkerSetting {

    public struct UnsafeFlags: Equatable {

        public let flags: [String]
        public let condition: BuildSettingCondition?

        public init(flags: [String],
                    condition: BuildSettingCondition? = nil) {
            self.flags = flags
            self.condition = condition
        }
    }
}
