public struct Packagefile: Decodable, Equatable {

    public let swiftToolsVersion: String?
    public let defaultLocalization: String?
    public let platforms: Platforms?
    public let pkgConfig: String?
    public let providers: [Provider]?
    public let swiftLanguageVersions: [SwiftVersion]?
    public let cLanguageStandard: CStandard?
    public let cxxLanguageStandard: CXXStandard?
    public let externalDependencies: [PackagefileDependency]?

    public init(swiftToolsVersion: String? = nil,
                defaultLocalization: String? = nil,
                platforms: Platforms? = nil,
                pkgConfig: String? = nil,
                providers: [Provider]? = nil,
                swiftLanguageVersions: [SwiftVersion]? = nil,
                cLanguageStandard: CStandard? = nil,
                cxxLanguageStandard: CXXStandard? = nil,
                externalDependencies: [PackagefileDependency]? = nil) {
        self.swiftToolsVersion = swiftToolsVersion
        self.defaultLocalization = defaultLocalization
        self.platforms = platforms
        self.pkgConfig = pkgConfig
        self.providers = providers
        self.swiftLanguageVersions = swiftLanguageVersions
        self.cLanguageStandard = cLanguageStandard
        self.cxxLanguageStandard = cxxLanguageStandard
        self.externalDependencies = externalDependencies
    }
}
