extension PackageDependency.RemoteDependency {

    public enum Requirement: Equatable {
        case from(version: String)
        case branch(name: String)
        case exact(version: String)
        case revision(revision: String)
        case upToNextMajor(version: String)
        case upToNextMinor(version: String)
        case closedRange(from: String, to: String)
        case range(from: String, upTo: String)
    }
}
