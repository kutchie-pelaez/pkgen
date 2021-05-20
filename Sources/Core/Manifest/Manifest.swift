public struct Manifest {

    public internal(set) var swiftToolsVersion: String
    public internal(set) var name: String
    public internal(set) var defaultLocalization: String?
    public internal(set) var platforms: Platforms?
    public internal(set) var pkgConfig: String?
    public internal(set) var providers: [PackageProvider]?
    public internal(set) var products: [Product]?
    public internal(set) var dependencies: [Dependency]?
    public internal(set) var targets: [Target]?
    public internal(set) var swiftLanguageVersions: [SwiftVersion]? // TODO:
    public internal(set) var cLanguageStandard: CStandard? // TODO:
    public internal(set) var cxxLanguageStandard: CXXStandard? // TODO:

    internal var decodedSwiftToolsVersion: String?
    internal var decodedName: String?
    internal var decodedDependencies: [String] = []
}
