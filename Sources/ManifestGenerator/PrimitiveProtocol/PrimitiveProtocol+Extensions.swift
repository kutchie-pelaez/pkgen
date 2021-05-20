import Core

// MARK: - Core primitives

extension PrimitiveProtocol {

    func swiftToolsVersion(_ version: String) -> PrimitiveProtocol { self.chain(SwiftToolsVersion(version)) }

    func `import`(_ module: String) -> PrimitiveProtocol {
        chain(Import(module))
    }

    var packageDeclarationStart: PrimitiveProtocol {
        chain(PackageDeclarationStart())
    }

    func name(_ name: String, isLastArgument: Bool) -> PrimitiveProtocol {
        chain(Name(name, isLastArgument: isLastArgument))
    }

    func platforms(_ platforms: Core.Platforms, isLastArgument: Bool) -> PrimitiveProtocol {
        chain(Platforms(platforms, isLastArgument: isLastArgument))
    }

    func products(_ products: [Product], isLastArgument: Bool) -> PrimitiveProtocol {
        chain(Products(products, isLastArgument: isLastArgument))
    }

    func dependencies(_ dependencies: [Dependency], isLastArgument: Bool) -> PrimitiveProtocol {
        chain(Dependencies(dependencies, isLastArgument: isLastArgument))
    }

    func targets(_ targets: [Target], isLastArgument: Bool) -> PrimitiveProtocol {
        chain(Targets(targets, isLastArgument: isLastArgument))
    }
}

// MARK: - Helper primitives

extension PrimitiveProtocol {

    func newLines(_ count: Int) -> PrimitiveProtocol {
        chain(NewLine(count))
    }

    var newLine: PrimitiveProtocol {
       newLines(1)
    }

    func parenthesis(type parenthesisType: Parenthesis.ParenthesisType) -> PrimitiveProtocol {
        chain(Parenthesis(parenthesisType))
    }

    func propertyDeclaration(name: String, type: String? = nil, isMutable: Bool = false) {
        chain(PropertyDeclaration(name: name, type: type, isMutable: isMutable))
    }

    func indented(with indentation: Indentation) -> PrimitiveProtocol {
        self.string
            .split(separator: "\n")
            .map { indentation.string + $0 }
            .joined(separator: "\n")
    }
}
