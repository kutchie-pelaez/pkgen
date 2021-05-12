protocol PrimitiveProtocol {

    var string: String { get }
    func chain(_ otherPrimitive: PrimitiveProtocol) -> PrimitiveProtocol
}

extension PrimitiveProtocol {

    func chain(_ otherPrimitive: PrimitiveProtocol) -> PrimitiveProtocol {
        self.string + otherPrimitive.string
    }
}

extension String: PrimitiveProtocol {

    var string: String { self }
}

extension PrimitiveProtocol {

    var colon: PrimitiveProtocol { self.chain(Colon()) }
    func comment(_ comment: String) -> PrimitiveProtocol { self.chain(Comment(comment)) }
    func `import`(_ module: String) -> PrimitiveProtocol { self.chain(Import(module)) }
    var newLine: PrimitiveProtocol { self.chain(NewLine()) }
    var space: PrimitiveProtocol { self.chain(Space()) }
    func swiftToolVersion(_ version: String) -> PrimitiveProtocol { self.chain(SwiftToolVersion(version)) }
    var tab: PrimitiveProtocol { self.chain(Tab()) }
}
