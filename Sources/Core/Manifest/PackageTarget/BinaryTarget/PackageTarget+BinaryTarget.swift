extension PackageTarget {

    public enum BinaryTarget: Equatable {
        case local(Local)
        case remote(Remote)
    }
}
