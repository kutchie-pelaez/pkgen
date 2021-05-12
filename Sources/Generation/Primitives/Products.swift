import Core

struct Products: PrimitiveProtocol {

    private let products: [Product]
    private let isLastArgument: Bool

    init(_ products: [Product],
         isLastArgument: Bool) {
        self.products = products
        self.isLastArgument = isLastArgument
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
    }

    private func libraryString(from library: Product.Library) -> String {
        let rawTargets = library.targets
            .map { "\"\($0)\"" }
            .joined(separator: ",\n")

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
        products: [
        \(body)
        ]\(isLastArgument ? "" : ",")
        """
    }
}
