extension ManifestTarget.Target.Resource {

    public struct Copy: Equatable {

        public let path: String

        public init(path: String) {
            self.path = path
        }
    }
}
