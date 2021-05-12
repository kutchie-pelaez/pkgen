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

    func dependencies(_ dependencies: [Dependency], isLastArgument: Bool = false) -> PrimitiveProtocol { self.chain(Dependencies(dependencies, isLastArgument: isLastArgument)) }
    func `import`(_ module: String) -> PrimitiveProtocol { self.chain(Import(module)) }
    func name(_ name: String, isLastArgument: Bool = false) -> PrimitiveProtocol { self.chain(Name(name, isLastArgument: isLastArgument)) }
    var newLine: PrimitiveProtocol { self.chain(NewLine(1)) }
    func newLines(_ count: Int) -> PrimitiveProtocol { self.chain(NewLine(count)) }
    var packageDeclarationStart: PrimitiveProtocol { self.chain(PackageDeclarationStart()) }
    func parenthesis(type parenthesisType: Parenthesis.ParenthesisType) -> PrimitiveProtocol { self.chain(Parenthesis(parenthesisType)) }
    func platforms(_ platforms: Core.Platforms, isLastArgument: Bool = false) -> PrimitiveProtocol { self.chain(Platforms(platforms, isLastArgument: isLastArgument)) }
    func products(_ products: [Product], isLastArgument: Bool = false) -> PrimitiveProtocol { self.chain(Products(products, isLastArgument: isLastArgument)) }
    func swiftToolsVersion(_ version: String) -> PrimitiveProtocol { self.chain(SwiftToolsVersion(version)) }
    func targets(_ targets: [Target], isLastArgument: Bool = false) -> PrimitiveProtocol { self.chain(Targets(targets, isLastArgument: isLastArgument)) }

    func indented(with indentation: Indentation) -> PrimitiveProtocol {
        self.string
            .split(separator: "\n")
            .map { indentation.string + $0 }
            .joined(separator: "\n")
    }
}

enum Indentation {
    case spaces(Int)
    case tabs(Int)

    static let space = Indentation.spaces(1)
    static let tab = Indentation.tabs(1)

    var string: String {
        switch self {
        case let .spaces(count): return Array(repeating: " ", count: count).joined()
        case let .tabs(count):  return Array(repeating: "    ", count: count).joined()
        }
    }
}
