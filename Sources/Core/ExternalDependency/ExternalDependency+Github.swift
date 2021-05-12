extension ExternalDependency {

    public struct Github: Equatable {
        public let path: String
        public let route: Route

        public init(path: String,
                    route: Route) {
            self.path = path
            self.route = route
        }

        public enum Route: Equatable {
            case branch(String)
            case from(String)
        }
    }
}
