extension BuildSettingCondition {

    public struct When: Equatable {

        public let platforms: [Platform]?
        public let configuration: BuildConfiguration?
    }
}
