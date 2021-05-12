extension Product {

    public struct Library: Equatable {
        public let name: String
        public let targets: [String]
        public let linking: Linking

        public init(name: String,
                    targets: [String],
                    linking: Linking) {
            self.name = name
            self.targets = targets
            self.linking = linking
        }

        public enum Linking: String, Equatable {
            case `static`
            case dynamic
            case auto

            public enum LinkingDecodingError: Error {
                case invalidLinkingType
            }
        }
    }
}
