struct NewLine: PrimitiveProtocol {

    private let count: Int

    init(_ count: Int) {
        self.count = count
    }

    var string: String {
        Array(repeating: "\n", count: count)
            .joined()
    }
}
