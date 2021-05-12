struct SwiftToolVersion: PrimitiveProtocol {

    private let version: String

    init(_ version: String) {
        self.version = version
    }

    var string: String {
        "// swift-tools-version:\(version)"
    }
}
