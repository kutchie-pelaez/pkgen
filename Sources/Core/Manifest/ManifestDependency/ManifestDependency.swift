public enum ManifestDependency: Equatable {
    case local(local: Local)
    case remote(remote: Remote)
}
