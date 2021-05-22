extension PackageTarget.Target.LinkerSetting {

    public struct LinkedLibrary: Equatable {

        public let library: String
        public let condition: BuildSettingCondition?

        public init(library: String,
                    condition: BuildSettingCondition? = nil) {
            self.library = library
            self.condition = condition
        }
    }
}
