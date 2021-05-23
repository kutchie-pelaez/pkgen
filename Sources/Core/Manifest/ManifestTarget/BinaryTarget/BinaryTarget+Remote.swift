extension ManifestTarget.BinaryTarget {

    public struct Remote: Equatable {

        public let name: String
        public let url: String
        public let checksum: String

        public init(name: String,
                    url: String,
                    checksum: String) {
            self.name = name
            self.url = url
            self.checksum = checksum
        }
    }
}
