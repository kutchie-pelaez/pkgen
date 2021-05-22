extension PackageTarget.Target {

    public enum Resource: Equatable {
        case copy(Copy)
        case process(Process)
    }
}
