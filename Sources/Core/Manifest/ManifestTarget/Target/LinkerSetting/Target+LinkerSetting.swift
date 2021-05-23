extension ManifestTarget.Target {

    public enum LinkerSetting: Equatable {
        case linkedFramework(LinkedFramework)
        case linkedLibrary(LinkedLibrary)
        case unsafeFlags(UnsafeFlags)
    }
}
