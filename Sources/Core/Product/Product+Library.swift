import Foundation

extension Product {

    public struct Library {
        public let name: String
        public let targets: [String]
        public let linking: Linking

        public enum Linking: String {
            case `static`
            case dynamic
            case auto

            public enum LinkingDecodingError: Error {
                case invalidLinkingType
            }
        }
    }
}
