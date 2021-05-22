extension PackageTarget.Target {

    public enum CSetting: Equatable {
        case define(Define)
        case headerSearchPath(HeaderSearchPath)
        case unsafeFlags(UnsafeFlags)
    }
}
