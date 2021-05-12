struct Name: PrimitiveProtocol {

    private let name: String
    private let isLastArgument: Bool

    init(_ name: String,
         isLastArgument: Bool) {
        self.name = name
        self.isLastArgument = isLastArgument
    }

    var string: String {
        "name: \"\(name)\"\(isLastArgument ? "" : ",")"
    }
}
