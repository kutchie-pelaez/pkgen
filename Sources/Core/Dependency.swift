public enum Dependency {
    case external(ExternalDependency)
    case local(LocalDependency)

    public func name() throws -> String {
        switch self {
        case let .external(externalDependency): return try externalDependency.name()
        case let .local(localDependency): return try localDependency.name()
        }
    }
}
