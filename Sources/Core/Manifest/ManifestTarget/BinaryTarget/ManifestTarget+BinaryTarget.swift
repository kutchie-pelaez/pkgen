extension ManifestTarget {

    public enum BinaryTarget: Equatable {
        case local(Local)
        case remote(Remote)
    }
}
