import Core

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
    func name(_ name: String, isLastArgument: Bool = false) -> PrimitiveProtocol { self.chain(Name(name, isLastArgument: isLastArgument)) }
    var newLine: PrimitiveProtocol { self.chain(NewLine(1)) }
    func newLines(_ count: Int) -> PrimitiveProtocol { self.chain(NewLine(count)) }
    var packageDeclarationStart: PrimitiveProtocol { self.chain(PackageDeclarationStart()) }
    func parenthesis(type parenthesisType: Parenthesis.ParenthesisType) -> PrimitiveProtocol { self.chain(Parenthesis(parenthesisType)) }
    func platforms(_ platforms: Core.Platforms, isLastArgument: Bool = false) -> PrimitiveProtocol { self.chain(Platforms(platforms, isLastArgument: isLastArgument)) }
    func products(_ products: [Product], isLastArgument: Bool = false) -> PrimitiveProtocol { self.chain(Products(products, isLastArgument: isLastArgument)) }
    var space: PrimitiveProtocol { self.chain(Space()) }
    func swiftToolsVersion(_ version: String) -> PrimitiveProtocol { self.chain(SwiftToolsVersion(version)) }
    var tab: PrimitiveProtocol { self.chain(Tab()) }
}
