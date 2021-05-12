extension ExternalDependency {

    public struct Github {
        public let path: String
        public let route: Route

        public enum Route {
            case branch(String)
            case from(String)
        }
    }
}
