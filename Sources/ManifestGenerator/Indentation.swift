enum Indentation {
    case spaces(Int)
    case tabs(Int)

    static let space = Indentation.spaces(1)
    static let tab = Indentation.tabs(1)

    var string: String {
        switch self {
        case let .spaces(count): return Array(repeating: " ", count: count).joined()
        case let .tabs(count): return Array(repeating: "    ", count: count).joined()
        }
    }
}
