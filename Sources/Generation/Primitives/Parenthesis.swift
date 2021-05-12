struct Parenthesis: PrimitiveProtocol {

    private let parenthesisType: ParenthesisType

    init(_ parenthesisType: ParenthesisType) {
        self.parenthesisType = parenthesisType
    }

    var string: String {
        "\(parenthesisType == .opened ? "(" : ")")"
    }

    enum ParenthesisType {
        case opened
        case closed
    }
}
