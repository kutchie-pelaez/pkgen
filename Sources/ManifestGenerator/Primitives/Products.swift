import Core

struct Products: PrimitiveProtocol {

    private let products: [Product]

    init(_ products: [Product]) {
        self.products = products
    }

    private func productString(from product: Product) -> String {
        switch product {
        case let .executable(executable): return executableString(from: executable)
        case let .library(library): return libraryString(from: library)
        }
    }

    private func executableString(from executable: Product.Executable) -> String {
        let rawTargets = executable.targets
            .map { "\"\($0)\"" }
            .joined(separator: ",\n")

        return """
        .executable(
        name: \"\(executable.name)\",
        targets: [
        \(rawTargets)
        ]
        )
        """
            .indented(with: .tab)
            .string
    }

    private func libraryString(from library: Product.Library) -> String {
        let rawTargets = library.targets
            .map { "\"\($0)\"" }
            .joined(separator: ",\n")
            .indented(with: .tab)
            .string

        let libraryLinking: String
        switch library.linking {
        case .static: libraryLinking = "\ntype: \"static\","
        case .dynamic: libraryLinking = "\ntype: \"static\","
        case .auto: libraryLinking = ""
        }

        return """
        .library(
            name: \"\(library.name)\",\(libraryLinking)
            targets: [
            \(rawTargets)
            ]
        )
        """
            .indented(with: .tab)
            .string
    }

    private var body: String {
        var result = ""
        let productStrings = products.map(productString)

        for productString in productStrings {
            if !result.isEmpty {
                result.append(",\n")
            }
            
            result.append(productString)
        }

        return result
    }

    var string: String {
        """
        [
        \(body)
        ]
        """
    }
}
