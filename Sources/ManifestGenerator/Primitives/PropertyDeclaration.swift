struct PropertyDeclaration: PrimitiveProtocol {

    private let name: String
    private let type: String?
    private let isMutable: Bool

    init(name: String,
         type: String?,
         isMutable: Bool) {
        self.name = name
        self.type = type
        self.isMutable = isMutable
    }

    var string: String {
        let keyword = isMutable ? "var" : "let"

        if let type = type {
            return "\(keyword) \(name): \(type) = "
        } else {
            return "\(keyword) \(name) = "
        }
    }
}
