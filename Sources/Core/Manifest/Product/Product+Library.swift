extension Product {

    public struct Library: Equatable {

        public let name: String
        public let targets: [String]
        public let linking: LinkingType

        public init(name: String,
                    targets: [String],
                    linking: LinkingType = .auto) {
            self.name = name
            self.targets = targets
            self.linking = linking
        }
    }
}
