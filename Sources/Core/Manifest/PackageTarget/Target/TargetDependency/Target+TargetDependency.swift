extension PackageTarget.Target {

    public enum TargetDependency: Equatable {
        case byName(ByName)
        case product(Product)
        case target(Target)
    }
}
