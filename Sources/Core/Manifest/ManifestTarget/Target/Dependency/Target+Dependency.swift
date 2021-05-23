extension ManifestTarget.Target {

    public enum Dependency: Equatable {
        case byName(ByName)
        case product(Product)
        case target(Target)
    }
}
