protocol PrimitiveProtocol {

    var string: String { get }
    func chain(_ otherPrimitive: PrimitiveProtocol) -> PrimitiveProtocol
}

extension PrimitiveProtocol {

    func chain(_ otherPrimitive: PrimitiveProtocol) -> PrimitiveProtocol {
        string + otherPrimitive.string
    }
}

extension String: PrimitiveProtocol {

    var string: String {
        self
    }
}
