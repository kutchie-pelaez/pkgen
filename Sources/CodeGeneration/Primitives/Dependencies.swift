import Core

struct Dependencies: PrimitiveProtocol {

    private let dependencies: [Dependency]
    private let isLastArgument: Bool

    init(_ dependencies: [Dependency],
         isLastArgument: Bool) {
        self.dependencies = dependencies
        self.isLastArgument = isLastArgument
    }

    private func dependencyString(from dependency: Dependency) -> String {
        switch dependency {
        case let .external(externalDependency): return externalDependencyString(from: externalDependency)
        case let .local(localDependency): return localDependencyString(from: localDependency)
        }
    }

    private func externalDependencyString(from externalDependency: ExternalDependency) -> String {
        switch externalDependency {
        case let .github(github): return externalGithubDependencyString(from: github)
        }
    }

    private func externalGithubDependencyString(from github: ExternalDependency.Github) -> String {
        ".package(url: \"https://github.com/\(github.path).git\", \(github.route.string))"
    }

    private func localDependencyString(from localDependency: LocalDependency) -> String {
        switch localDependency {
        case let .path(path): return localPathDependencyString(from: path)
        }
    }

    private func localPathDependencyString(from path: String) -> String {
        ".package(path: \"../\(path)\")"
    }

    private var body: String {
        var result = ""
        let dependencyStrings = dependencies.map(dependencyString)

        for dependencyString in dependencyStrings {
            if !result.isEmpty {
                result.append(",\n")
            }
            result.append(dependencyString)
        }

        return result
            .indented(with: .tab)
            .string
    }

    var string: String {
        """
        dependencies: [
        \(body)
        ]\(isLastArgument ? "" : ",")
        """
    }
}

private extension ExternalDependency.Github.Route {

    var string: String {
        switch self {
        case let .branch(branch): return ".branch(\"\(branch)\")"
        case let .from(from): return "from: \"\(from)\""
        }
    }
}
