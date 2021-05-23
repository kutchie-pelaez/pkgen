public struct Manifest {

    public internal(set) var swiftToolsVersion: String
    public internal(set) var name: String
    public internal(set) var defaultLocalization: String?
    public internal(set) var platforms: Platforms?
    public internal(set) var pkgConfig: String?
    public internal(set) var providers: [Provider]?
    public internal(set) var products: [ManifestProduct]?
    public internal(set) var dependencies: [ManifestDependency]?
    public internal(set) var targets: [ManifestTarget]?
    public internal(set) var swiftLanguageVersions: [SwiftVersion]? 
    public internal(set) var cLanguageStandard: CStandard?
    public internal(set) var cxxLanguageStandard: CXXStandard?
    internal var decodedSwiftToolsVersion: String?
    internal var decodedName: String?
    internal var decodedDependencies: [String]?

    public init(swiftToolsVersion: String,
                name: String,
                defaultLocalization: String? = nil,
                platforms: Platforms? = nil,
                pkgConfig: String? = nil,
                providers: [Provider]? = nil,
                products: [ManifestProduct]? = nil,
                dependencies: [ManifestDependency]? = nil,
                targets: [ManifestTarget]? = nil,
                swiftLanguageVersions: [SwiftVersion]? = nil,
                cLanguageStandard: CStandard? = nil,
                cxxLanguageStandard: CXXStandard? = nil) {
        self.swiftToolsVersion = swiftToolsVersion
        self.name = name
        self.defaultLocalization = defaultLocalization
        self.platforms = platforms
        self.pkgConfig = pkgConfig
        self.providers = providers
        self.products = products
        self.dependencies = dependencies
        self.targets = targets
        self.swiftLanguageVersions = swiftLanguageVersions
        self.cLanguageStandard = cLanguageStandard
        self.cxxLanguageStandard = cxxLanguageStandard
    }
}
