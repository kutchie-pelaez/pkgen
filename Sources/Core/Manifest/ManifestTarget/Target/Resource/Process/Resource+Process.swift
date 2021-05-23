extension ManifestTarget.Target.Resource {

    public struct Process: Equatable {

        public let path: String
        public let localization: ResourceLocalization?

        public init(path: String,
                    localization: ResourceLocalization? = nil) {
            self.path = path
            self.localization = localization
        }
    }
}
