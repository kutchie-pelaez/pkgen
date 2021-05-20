import Core

struct Targets: PrimitiveProtocol {

    private let targets: [Target]

    init(_ targets: [Target]) {
        self.targets = targets
    }

    private func targetSting(for target: Target) -> String {
        var dependenciesRawString = ""

        for dependency in target.dependencies {
            if dependenciesRawString.isEmpty {
                dependenciesRawString.append("\n    dependencies: [\n")
            } else {
                dependenciesRawString.append(",\n")
            }
            dependenciesRawString.append("        .product(name: \"\(dependency)\", package: \"\(dependency)\")")
        }
        if !dependenciesRawString.isEmpty {
            dependenciesRawString.append("\n    ],")
        }

        return """
        .target(
            name: \"\(target.name)\",\(dependenciesRawString)
            path: \"Sources\"
        )
        """
    }

    private var body: String {
        var result = ""
        let targetStrings = targets.map(targetSting)

        for targetString in targetStrings {
            if !result.isEmpty {
                result.append(",\n")
            }
            result.append(targetString)
        }

        return result
            .indented(with: .tab)
            .string
    }

    var string: String {
        """
        [
        \(body)
        ]
        """
    }
}
