extension PackageTarget.Target.Resource.Process {

    public enum ResourceLocalization: Equatable {
        case base
        case `default`
        case custom(String)
    }
}
