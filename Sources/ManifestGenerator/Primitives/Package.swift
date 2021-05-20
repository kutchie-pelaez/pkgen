struct Package: PrimitiveProtocol {

    private let hasDefaultLocalization: Bool
    private let hasPlatforms: Bool
    private let hasPKGConfig: Bool
    private let hasProviders: Bool
    private let hasProducts: Bool
    private let hasDependencies: Bool
    private let hasTargets: Bool
    private let hasSwiftLanguageVersions: Bool
    private let hasCLanguageStandard: Bool
    private let hasCXXLanguageStandard: Bool

    init(hasDefaultLocalization: Bool,
         hasPlatforms: Bool,
         hasPKGConfig: Bool,
         hasProviders: Bool,
         hasProducts: Bool,
         hasDependencies: Bool,
         hasTargets: Bool,
         hasSwiftLanguageVersions: Bool,
         hasCLanguageStandard: Bool,
         hasCXXLanguageStandard: Bool) {
        self.hasDefaultLocalization = hasDefaultLocalization
        self.hasPlatforms = hasPlatforms
        self.hasPKGConfig = hasPKGConfig
        self.hasProviders = hasProviders
        self.hasProducts = hasProducts
        self.hasDependencies = hasDependencies
        self.hasTargets = hasTargets
        self.hasSwiftLanguageVersions = hasSwiftLanguageVersions
        self.hasCLanguageStandard = hasCLanguageStandard
        self.hasCXXLanguageStandard = hasCXXLanguageStandard
    }

    private func argument(_ name: String) -> PrimitiveProtocol {
        "\(name): \(name)"
            .indented(with: .tab)
    }

    var string: String {
        PropertyDeclaration(name: "package")
            .chain("Package")
            .parenthesis(type: .opened)
            .newLine
            .chain(argument("name"))
            .chain(hasDefaultLocalization ? argument("defaultLocalization") : Empty())
            .chain(hasPlatforms ? argument("platforms") : Empty())
            .chain(hasPKGConfig ? argument("pkgConfig") : Empty())
            .chain(hasProviders ? argument("providers") : Empty())
            .chain(hasProducts ? argument("products") : Empty())
            .chain(hasDependencies ? argument("dependencies") : Empty())
            .chain(hasTargets ? argument("targets") : Empty())
            .chain(hasSwiftLanguageVersions ? argument("swiftLanguageVersions") : Empty())
            .chain(hasCLanguageStandard ? argument("cLanguageStandard") : Empty())
            .chain(hasCXXLanguageStandard ? argument("cxxLanguageStandard") : Empty())
            .newLine
            .parenthesis(type: .closed)
            .string
    }
}
