extension ManifestTarget.Target {

    public enum SwiftSetting: Equatable {
        case define(Define)
        case unsafeFlags(UnsafeFlags)
    }
}
