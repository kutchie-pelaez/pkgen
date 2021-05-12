struct Import: PrimitiveProtocol {

    private let module: String

    init(_ module: String) {
        self.module = module
    }

    var string: String {
        "import \(module)"
    }
}
