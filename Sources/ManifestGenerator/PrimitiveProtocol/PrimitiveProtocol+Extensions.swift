import Core

// MARK: - Core primitives

extension PrimitiveProtocol {

    func swiftToolsVersion(_ version: String) -> PrimitiveProtocol { self.chain(SwiftToolsVersion(version)) }

    func `import`(_ module: String) -> PrimitiveProtocol {
        chain(Import(module))
    }

    func platforms(_ platforms: Core.Platforms) -> PrimitiveProtocol {
        chain(Platforms(platforms))
    }

    func providers(_ providers: [PackageProvider]) -> PrimitiveProtocol {
        chain(Providers(providers))
    }

    func products(_ products: [Product]) -> PrimitiveProtocol {
        chain(Products(products))
    }

    func dependencies(_ dependencies: [Dependency]) -> PrimitiveProtocol {
        chain(Dependencies(dependencies))
    }

    func targets(_ targets: [Target]) -> PrimitiveProtocol {
        chain(Targets(targets))
    }

    func swiftLanguageVersions(_ swiftVersions: [SwiftVersion]) -> PrimitiveProtocol {
        chain(SwiftLanguageVersions(swiftVersions))
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

    func string(_ string: String) -> PrimitiveProtocol {
        chain("\"\(string)\"")
    }

    func parenthesis(type parenthesisType: Parenthesis.ParenthesisType) -> PrimitiveProtocol {
        chain(Parenthesis(parenthesisType))
    }

    func propertyDeclaration(name: String, type: String? = nil, isMutable: Bool = false) -> PrimitiveProtocol {
        chain(PropertyDeclaration(name: name, type: type, isMutable: isMutable))
    }

    func indented(with indentation: Indentation) -> PrimitiveProtocol {
        self.string
            .split(separator: "\n")
            .map { indentation.string + $0 }
            .joined(separator: "\n")
    }
}
