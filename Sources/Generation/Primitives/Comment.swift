struct Comment: PrimitiveProtocol {

    private let comment: String

    init(_ comment: String) {
        self.comment = comment
    }

    var string: String {
        "// \(comment)"
    }
}
