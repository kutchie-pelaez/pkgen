extension Product {

    public struct Executable: Equatable {
        public let name: String
        public let targets: [String]

        public init(name: String,
                    targets: [String]) {
            self.name = name
            self.targets = targets
        }
    }
}
