extension PackageTarget.BinaryTarget {

    public struct Local: Equatable {

        public let name: String
        public let path: String

        public init(name: String,
                    path: String) {
            self.name = name
            self.path = path
        }
    }
}
