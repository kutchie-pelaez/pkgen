public enum PackageDependency: Equatable {
    case local(localDependency: LocalDependency)
    case remote(remoteDependency: RemoteDependency)
}
